import 'package:flutter/material.dart';
import '../../models/order_model.dart';
import '../../models/product_model.dart';
import '../../services/payment_service.dart';
import '../../services/order_service.dart';
import '../../theme/app_theme.dart';
import '../../widgets/common_widgets.dart';

class PaymentProcessingScreen extends StatefulWidget {
  const PaymentProcessingScreen({super.key});

  @override
  State<PaymentProcessingScreen> createState() => _PaymentProcessingScreenState();
}

class _PaymentProcessingScreenState extends State<PaymentProcessingScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  
  final PaymentService _paymentService = PaymentService();
  final OrderService _orderService = OrderService();
  
  PaymentMethod? _paymentMethod;
  DeliveryAddress? _address;
  List<CartItem>? _cartItems;
  double? _total;
  
  bool _isProcessing = true;
  bool _paymentSuccess = false;
  String _statusMessage = 'Processing your payment...';

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
    );
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
      if (args != null) {
        _paymentMethod = args['paymentMethod'] as PaymentMethod?;
        _address = args['address'] as DeliveryAddress?;
        _cartItems = args['cartItems'] as List<CartItem>?;
        _total = args['total'] as double?;
        
        _processPayment();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _processPayment() async {
    if (_paymentMethod == null || _address == null || _cartItems == null || _total == null) {
      _showError('Invalid payment data');
      return;
    }

    try {
      // Show payment method specific UI
      if (_paymentMethod!.type == PaymentType.card) {
        await _showCardPaymentDialog();
      } else if (_paymentMethod!.type == PaymentType.upi) {
        await _showUPIPaymentDialog();
      } else if (_paymentMethod!.type == PaymentType.cod) {
        await _processCODPayment();
      } else {
        await _processOtherPayment();
      }
    } catch (e) {
      _showError('Payment processing failed');
    }
  }

  Future<void> _showCardPaymentDialog() async {
    final cvvController = TextEditingController();
    
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Enter CVV'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Card: ${_paymentMethod!.displayName}',
              style: AppTheme.bodyMedium.copyWith(
                color: AppTheme.textSecondary,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: cvvController,
              decoration: const InputDecoration(
                labelText: 'CVV',
                hintText: 'Enter 3-digit CVV',
              ),
              keyboardType: TextInputType.number,
              maxLength: 3,
              obscureText: true,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context, false);
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _processActualPayment(cardCvv: cvvController.text);
            },
            child: const Text('Pay Now'),
          ),
        ],
      ),
    );
  }

  Future<void> _showUPIPaymentDialog() async {
    final pinController = TextEditingController();
    
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Enter UPI PIN'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'UPI ID: ${_paymentMethod!.displayName}',
              style: AppTheme.bodyMedium.copyWith(
                color: AppTheme.textSecondary,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: pinController,
              decoration: const InputDecoration(
                labelText: 'UPI PIN',
                hintText: 'Enter your UPI PIN',
              ),
              keyboardType: TextInputType.number,
              maxLength: 6,
              obscureText: true,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context, false);
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _processActualPayment(upiPin: pinController.text);
            },
            child: const Text('Pay Now'),
          ),
        ],
      ),
    );
  }

  Future<void> _processCODPayment() async {
    setState(() {
      _statusMessage = 'Confirming Cash on Delivery...';
    });
    
    await Future.delayed(const Duration(seconds: 2));
    _processActualPayment();
  }

  Future<void> _processOtherPayment() async {
    setState(() {
      _statusMessage = 'Processing payment...';
    });
    
    await Future.delayed(const Duration(seconds: 2));
    _processActualPayment();
  }

  Future<void> _processActualPayment({String? cardCvv, String? upiPin}) async {
    setState(() {
      _statusMessage = 'Processing payment...';
    });

    // Simulate payment processing
    final success = await _paymentService.processPayment(
      paymentMethod: _paymentMethod!,
      amount: _total!,
      cardCvv: cardCvv,
      upiPin: upiPin,
    );

    if (success) {
      // Create order
      final order = await _orderService.createOrder(
        cartItems: _cartItems!,
        paymentMethod: _paymentMethod!,
        deliveryAddress: _address!,
        subtotal: _cartItems!.fold(0.0, (sum, item) => sum + item.totalPrice),
        shipping: _total! > 500 ? 0.0 : 50.0,
        tax: _cartItems!.fold(0.0, (sum, item) => sum + item.totalPrice) * 0.18,
      );

      setState(() {
        _isProcessing = false;
        _paymentSuccess = true;
        _statusMessage = 'Payment Successful!';
      });

      _animationController.forward();

      // Wait for animation and then navigate
      await Future.delayed(const Duration(seconds: 3));
      Navigator.pop(context, true);
    } else {
      _showError('Payment failed. Please try again.');
    }
  }

  void _showError(String message) {
    setState(() {
      _isProcessing = false;
      _paymentSuccess = false;
      _statusMessage = message;
    });

    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pop(context, false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_isProcessing) ...[
                const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primaryColor),
                ),
                const SizedBox(height: 32),
              ] else if (_paymentSuccess) ...[
                AnimatedBuilder(
                  animation: _scaleAnimation,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _scaleAnimation.value,
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: const BoxDecoration(
                          color: AppTheme.successColor,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 50,
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 32),
              ] else ...[
                Container(
                  width: 100,
                  height: 100,
                  decoration: const BoxDecoration(
                    color: AppTheme.errorColor,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 50,
                  ),
                ),
                const SizedBox(height: 32),
              ],
              
              Text(
                _statusMessage,
                style: AppTheme.heading2.copyWith(
                  color: _paymentSuccess 
                      ? AppTheme.successColor 
                      : _isProcessing 
                          ? AppTheme.textPrimary 
                          : AppTheme.errorColor,
                ),
                textAlign: TextAlign.center,
              ),
              
              if (_paymentMethod != null) ...[
                const SizedBox(height: 16),
                Text(
                  'Amount: ₹${_total?.toStringAsFixed(2)}',
                  style: AppTheme.bodyLarge.copyWith(
                    color: AppTheme.textSecondary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Payment Method: ${_paymentMethod!.displayName}',
                  style: AppTheme.bodyMedium.copyWith(
                    color: AppTheme.textSecondary,
                  ),
                ),
              ],
              
              if (!_isProcessing && !_paymentSuccess) ...[
                const SizedBox(height: 32),
                CustomButton(
                  text: 'Try Again',
                  onPressed: () => Navigator.pop(context, false),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}