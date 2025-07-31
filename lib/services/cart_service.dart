import 'dart:async';
import '../models/product_model.dart';

class CartService {
  static final CartService _instance = CartService._internal();
  factory CartService() => _instance;
  CartService._internal();

  final List<CartItem> _cartItems = [];
  final StreamController<List<CartItem>> _cartController = StreamController<List<CartItem>>.broadcast();

  Stream<List<CartItem>> get cartStream => _cartController.stream;
  List<CartItem> get cartItems => List.unmodifiable(_cartItems);
  int get itemCount => _cartItems.fold(0, (sum, item) => sum + item.quantity);
  
  double get subtotal => _cartItems.fold(0.0, (sum, item) => sum + item.totalPrice);
  double get originalTotal => _cartItems.fold(0.0, (sum, item) => sum + item.totalOriginalPrice);
  double get totalSavings => originalTotal - subtotal;
  double get shipping => subtotal > 500 ? 0.0 : 50.0; // Free shipping above Rs.500
  double get tax => subtotal * 0.18; // 18% GST
  double get total => subtotal + shipping + tax;

  void addToCart(Product product, {int quantity = 1, String color = '', String size = ''}) {
    final existingItemIndex = _cartItems.indexWhere((item) => 
        item.product.id == product.id && 
        item.selectedColor == color && 
        item.selectedSize == size);

    if (existingItemIndex != -1) {
      _cartItems[existingItemIndex].quantity += quantity;
    } else {
      final cartItem = CartItem(
        id: '${product.id}_${DateTime.now().millisecondsSinceEpoch}',
        product: product,
        quantity: quantity,
        selectedColor: color,
        selectedSize: size,
      );
      _cartItems.add(cartItem);
    }
    
    _notifyListeners();
  }

  void removeFromCart(String cartItemId) {
    _cartItems.removeWhere((item) => item.id == cartItemId);
    _notifyListeners();
  }

  void updateQuantity(String cartItemId, int newQuantity) {
    if (newQuantity <= 0) {
      removeFromCart(cartItemId);
      return;
    }

    final itemIndex = _cartItems.indexWhere((item) => item.id == cartItemId);
    if (itemIndex != -1) {
      _cartItems[itemIndex].quantity = newQuantity;
      _notifyListeners();
    }
  }

  void clearCart() {
    _cartItems.clear();
    _notifyListeners();
  }

  bool isInCart(String productId) {
    return _cartItems.any((item) => item.product.id == productId);
  }

  int getProductQuantityInCart(String productId) {
    return _cartItems
        .where((item) => item.product.id == productId)
        .fold(0, (sum, item) => sum + item.quantity);
  }

  void _notifyListeners() {
    _cartController.add(List.unmodifiable(_cartItems));
  }

  void dispose() {
    _cartController.close();
  }
}