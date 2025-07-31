import 'dart:async';
import '../models/order_model.dart';
import '../models/product_model.dart';

class OrderService {
  static final OrderService _instance = OrderService._internal();
  factory OrderService() => _instance;
  OrderService._internal();

  final List<Order> _orders = [];
  final StreamController<List<Order>> _ordersController = StreamController<List<Order>>.broadcast();

  Stream<List<Order>> get ordersStream => _ordersController.stream;
  List<Order> get orders => List.unmodifiable(_orders);

  Future<Order> createOrder({
    required List<CartItem> cartItems,
    required PaymentMethod paymentMethod,
    required DeliveryAddress deliveryAddress,
    required double subtotal,
    required double shipping,
    required double tax,
  }) async {
    final orderId = 'ORD${DateTime.now().millisecondsSinceEpoch}';
    
    final orderItems = cartItems.map((cartItem) => OrderItem(
      id: '${orderId}_${cartItem.product.id}',
      productId: cartItem.product.id,
      productName: cartItem.product.name,
      productImage: cartItem.product.imageUrls.first,
      price: cartItem.product.numericPrice,
      quantity: cartItem.quantity,
      selectedColor: cartItem.selectedColor,
      selectedSize: cartItem.selectedSize,
    )).toList();

    final order = Order(
      id: orderId,
      userId: 'user123', // In real app, get from auth service
      items: orderItems,
      subtotal: subtotal,
      shipping: shipping,
      tax: tax,
      total: subtotal + shipping + tax,
      status: OrderStatus.pending,
      paymentMethod: paymentMethod,
      deliveryAddress: deliveryAddress,
      orderDate: DateTime.now(),
      estimatedDelivery: DateTime.now().add(const Duration(days: 5)),
      statusUpdates: [
        OrderStatusUpdate(
          status: OrderStatus.pending,
          timestamp: DateTime.now(),
          description: 'Order placed successfully',
        ),
      ],
    );

    _orders.insert(0, order);
    _notifyListeners();

    // Simulate order processing
    _simulateOrderProgress(order);

    return order;
  }

  void _simulateOrderProgress(Order order) {
    // Simulate order confirmation after 2 minutes
    Timer(const Duration(minutes: 2), () {
      _updateOrderStatus(order.id, OrderStatus.confirmed, 'Order confirmed by seller');
    });

    // Simulate processing after 1 hour
    Timer(const Duration(hours: 1), () {
      _updateOrderStatus(order.id, OrderStatus.processing, 'Order is being processed');
    });

    // Simulate shipping after 1 day
    Timer(const Duration(days: 1), () {
      _updateOrderStatus(order.id, OrderStatus.shipped, 'Order has been shipped', 
          trackingNumber: 'TRK${DateTime.now().millisecondsSinceEpoch}');
    });

    // Simulate out for delivery after 3 days
    Timer(const Duration(days: 3), () {
      _updateOrderStatus(order.id, OrderStatus.outForDelivery, 'Out for delivery');
    });

    // Simulate delivery after 5 days
    Timer(const Duration(days: 5), () {
      _updateOrderStatus(order.id, OrderStatus.delivered, 'Order delivered successfully');
    });
  }

  void _updateOrderStatus(String orderId, OrderStatus newStatus, String description, {String? trackingNumber}) {
    final orderIndex = _orders.indexWhere((order) => order.id == orderId);
    if (orderIndex != -1) {
      final order = _orders[orderIndex];
      final updatedStatusUpdates = List<OrderStatusUpdate>.from(order.statusUpdates);
      updatedStatusUpdates.add(OrderStatusUpdate(
        status: newStatus,
        timestamp: DateTime.now(),
        description: description,
      ));

      final updatedOrder = Order(
        id: order.id,
        userId: order.userId,
        items: order.items,
        subtotal: order.subtotal,
        shipping: order.shipping,
        tax: order.tax,
        total: order.total,
        status: newStatus,
        paymentMethod: order.paymentMethod,
        deliveryAddress: order.deliveryAddress,
        orderDate: order.orderDate,
        estimatedDelivery: order.estimatedDelivery,
        actualDelivery: newStatus == OrderStatus.delivered ? DateTime.now() : order.actualDelivery,
        trackingNumber: trackingNumber ?? order.trackingNumber,
        statusUpdates: updatedStatusUpdates,
        notes: order.notes,
      );

      _orders[orderIndex] = updatedOrder;
      _notifyListeners();
    }
  }

  Order? getOrderById(String orderId) {
    try {
      return _orders.firstWhere((order) => order.id == orderId);
    } catch (e) {
      return null;
    }
  }

  List<Order> getOrdersByStatus(OrderStatus status) {
    return _orders.where((order) => order.status == status).toList();
  }

  void cancelOrder(String orderId) {
    _updateOrderStatus(orderId, OrderStatus.cancelled, 'Order cancelled by user');
  }

  void _notifyListeners() {
    _ordersController.add(List.unmodifiable(_orders));
  }

  void dispose() {
    _ordersController.close();
  }
}