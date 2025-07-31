import 'dart:async';
import '../models/order_model.dart';

class PaymentService {
  static final PaymentService _instance = PaymentService._internal();
  factory PaymentService() => _instance;
  PaymentService._internal();

  final List<PaymentMethod> _paymentMethods = [
    PaymentMethod(
      id: 'card1',
      type: PaymentType.card,
      displayName: '**** **** **** 1234',
      cardNumber: '1234567812345678',
      expiryDate: '12/25',
      holderName: 'John Doe',
      isDefault: true,
    ),
    PaymentMethod(
      id: 'upi1',
      type: PaymentType.upi,
      displayName: 'john.doe@paytm',
      upiId: 'john.doe@paytm',
    ),
    PaymentMethod(
      id: 'cod1',
      type: PaymentType.cod,
      displayName: 'Cash on Delivery',
    ),
  ];

  final StreamController<List<PaymentMethod>> _paymentController = 
      StreamController<List<PaymentMethod>>.broadcast();

  Stream<List<PaymentMethod>> get paymentMethodsStream => _paymentController.stream;
  List<PaymentMethod> get paymentMethods => List.unmodifiable(_paymentMethods);

  PaymentMethod? get defaultPaymentMethod {
    try {
      return _paymentMethods.firstWhere((method) => method.isDefault);
    } catch (e) {
      return _paymentMethods.isNotEmpty ? _paymentMethods.first : null;
    }
  }

  void addPaymentMethod(PaymentMethod paymentMethod) {
    // If this is set as default, remove default from others
    if (paymentMethod.isDefault) {
      for (int i = 0; i < _paymentMethods.length; i++) {
        if (_paymentMethods[i].isDefault) {
          _paymentMethods[i] = PaymentMethod(
            id: _paymentMethods[i].id,
            type: _paymentMethods[i].type,
            displayName: _paymentMethods[i].displayName,
            cardNumber: _paymentMethods[i].cardNumber,
            expiryDate: _paymentMethods[i].expiryDate,
            holderName: _paymentMethods[i].holderName,
            upiId: _paymentMethods[i].upiId,
            isDefault: false,
          );
        }
      }
    }

    _paymentMethods.add(paymentMethod);
    _notifyListeners();
  }

  void updatePaymentMethod(PaymentMethod updatedMethod) {
    final index = _paymentMethods.indexWhere((method) => method.id == updatedMethod.id);
    if (index != -1) {
      // If this is set as default, remove default from others
      if (updatedMethod.isDefault) {
        for (int i = 0; i < _paymentMethods.length; i++) {
          if (i != index && _paymentMethods[i].isDefault) {
            _paymentMethods[i] = PaymentMethod(
              id: _paymentMethods[i].id,
              type: _paymentMethods[i].type,
              displayName: _paymentMethods[i].displayName,
              cardNumber: _paymentMethods[i].cardNumber,
              expiryDate: _paymentMethods[i].expiryDate,
              holderName: _paymentMethods[i].holderName,
              upiId: _paymentMethods[i].upiId,
              isDefault: false,
            );
          }
        }
      }

      _paymentMethods[index] = updatedMethod;
      _notifyListeners();
    }
  }

  void deletePaymentMethod(String methodId) {
    _paymentMethods.removeWhere((method) => method.id == methodId);
    
    // If we deleted the default method and there are other methods, make the first one default
    if (!_paymentMethods.any((method) => method.isDefault) && _paymentMethods.isNotEmpty) {
      final firstMethod = _paymentMethods.first;
      _paymentMethods[0] = PaymentMethod(
        id: firstMethod.id,
        type: firstMethod.type,
        displayName: firstMethod.displayName,
        cardNumber: firstMethod.cardNumber,
        expiryDate: firstMethod.expiryDate,
        holderName: firstMethod.holderName,
        upiId: firstMethod.upiId,
        isDefault: true,
      );
    }
    
    _notifyListeners();
  }

  void setDefaultPaymentMethod(String methodId) {
    for (int i = 0; i < _paymentMethods.length; i++) {
      final method = _paymentMethods[i];
      _paymentMethods[i] = PaymentMethod(
        id: method.id,
        type: method.type,
        displayName: method.displayName,
        cardNumber: method.cardNumber,
        expiryDate: method.expiryDate,
        holderName: method.holderName,
        upiId: method.upiId,
        isDefault: method.id == methodId,
      );
    }
    _notifyListeners();
  }

  PaymentMethod? getPaymentMethodById(String methodId) {
    try {
      return _paymentMethods.firstWhere((method) => method.id == methodId);
    } catch (e) {
      return null;
    }
  }

  Future<bool> processPayment({
    required PaymentMethod paymentMethod,
    required double amount,
    String? cardCvv,
    String? upiPin,
  }) async {
    // Simulate payment processing
    await Future.delayed(const Duration(seconds: 3));
    
    // Simulate 90% success rate
    return DateTime.now().millisecond % 10 != 0;
  }

  void _notifyListeners() {
    _paymentController.add(List.unmodifiable(_paymentMethods));
  }

  void dispose() {
    _paymentController.close();
  }
}