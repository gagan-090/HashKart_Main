import 'package:flutter/material.dart';
import '../../routes/navigation_helper.dart';
import '../../theme/app_theme.dart';
import '../../widgets/common_widgets.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  final List<Order> _allOrders = [
    Order(
      id: '#ORD-001',
      date: '2024-01-15',
      status: OrderStatus.delivered,
      total: 23999.00,
      items: [
        OrderItem('Wireless Headphones', 1, 99.99, 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=300'),
        OrderItem('Smart Watch', 1, 199.99, 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=300'),
      ],
    ),
    Order(
      id: '#ORD-002',
      date: '2024-01-20',
      status: OrderStatus.shipped,
      total: 11999.00,
      items: [
        OrderItem('Laptop Backpack', 1, 49.99, 'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=300'),
        OrderItem('Coffee Maker', 1, 99.99, 'https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?w=300'),
      ],
    ),
    Order(
      id: '#ORD-003',
      date: '2024-01-22',
      status: OrderStatus.processing,
      total: 7199.00,
      items: [
        OrderItem('Running Shoes', 1, 89.99, 'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=300'),
      ],
    ),
    Order(
      id: '#ORD-004',
      date: '2024-01-10',
      status: OrderStatus.cancelled,
      total: 4799.00,
      items: [
        OrderItem('Bluetooth Speaker', 1, 59.99, 'https://images.unsplash.com/photo-1608043152269-423dbba4e7e1?w=300'),
      ],
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppTheme.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'My Orders',
          style: AppTheme.heading3.copyWith(
            color: AppTheme.textPrimary,
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          labelColor: AppTheme.primaryColor,
          unselectedLabelColor: AppTheme.textSecondary,
          indicatorColor: AppTheme.primaryColor,
          labelStyle: AppTheme.bodyMedium.copyWith(fontWeight: FontWeight.w600),
          unselectedLabelStyle: AppTheme.bodyMedium,
          tabs: const [
            Tab(text: 'All'),
            Tab(text: 'Processing'),
            Tab(text: 'Shipped'),
            Tab(text: 'Delivered'),
            Tab(text: 'Cancelled'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildOrdersList(_allOrders),
          _buildOrdersList(_allOrders.where((o) => o.status == OrderStatus.processing).toList()),
          _buildOrdersList(_allOrders.where((o) => o.status == OrderStatus.shipped).toList()),
          _buildOrdersList(_allOrders.where((o) => o.status == OrderStatus.delivered).toList()),
          _buildOrdersList(_allOrders.where((o) => o.status == OrderStatus.cancelled).toList()),
        ],
      ),
    );
  }

  Widget _buildOrdersList(List<Order> orders) {
    if (orders.isEmpty) {
      return EmptyStateWidget(
        title: 'No orders found',
        subtitle: 'Start shopping to see your orders here',
        icon: Icons.shopping_bag_outlined,
        buttonText: 'Start Shopping',
        onButtonPressed: () => NavigationHelper.goToHome(),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        return _buildOrderCard(order);
      },
    );
  }

  Widget _buildOrderCard(Order order) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Order Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  order.id,
                  style: AppTheme.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textPrimary,
                  ),
                ),
                _buildStatusChip(order.status),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              'Ordered on ${order.date}',
              style: AppTheme.bodySmall.copyWith(
                color: AppTheme.textSecondary,
              ),
            ),
            const SizedBox(height: 12),

            // Order Items
            ...List.generate(order.items.length.clamp(0, 2), (index) {
              final item = order.items[index];
              return _buildOrderItem(item);
            }),

            if (order.items.length > 2) ...[
              const SizedBox(height: 8),
              Text(
                '+${order.items.length - 2} more items',
                style: AppTheme.bodySmall.copyWith(
                  color: AppTheme.textSecondary,
                ),
              ),
            ],

            const SizedBox(height: 12),
            const Divider(height: 1),
            const SizedBox(height: 12),

            // Order Footer
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Amount',
                      style: AppTheme.bodySmall.copyWith(
                        color: AppTheme.textSecondary,
                      ),
                    ),
                    Text(
                      'Rs.${order.total.toStringAsFixed(2)}',
                      style: AppTheme.bodyMedium.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primaryColor,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    if (order.status == OrderStatus.shipped) ...[
                      OutlinedButton(
                        onPressed: () => NavigationHelper.goToTrackOrder(orderId: order.id),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          side: const BorderSide(color: AppTheme.primaryColor),
                        ),
                        child: Text(
                          'Track',
                          style: AppTheme.bodySmall.copyWith(
                            color: AppTheme.primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                    ],
                    if (order.status == OrderStatus.delivered) ...[
                      OutlinedButton(
                        onPressed: () => NavigationHelper.goToOrderRating(orderId: order.id),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          side: const BorderSide(color: AppTheme.primaryColor),
                        ),
                        child: Text(
                          'Rate',
                          style: AppTheme.bodySmall.copyWith(
                            color: AppTheme.primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                    ],
                    ElevatedButton(
                      onPressed: () => NavigationHelper.goToOrderDetails(orderId: order.id),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primaryColor,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      ),
                      child: Text(
                        'Details',
                        style: AppTheme.bodySmall.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderItem(OrderItem item) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(
              width: 50,
              height: 50,
              color: Colors.grey[100],
              child: Image.network(
                item.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: AppTheme.primaryColor.withValues(alpha: 0.1),
                    child: const Icon(Icons.image, color: AppTheme.primaryColor),
                  );
                },
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: AppTheme.bodyMedium.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  'Qty: ${item.quantity}',
                  style: AppTheme.bodySmall.copyWith(
                    color: AppTheme.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Text(
            'Rs.${item.price.toStringAsFixed(2)}',
            style: AppTheme.bodyMedium.copyWith(
              fontWeight: FontWeight.w600,
              color: AppTheme.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusChip(OrderStatus status) {
    Color color;
    String text;

    switch (status) {
      case OrderStatus.processing:
        color = AppTheme.warningColor;
        text = 'Processing';
        break;
      case OrderStatus.shipped:
        color = AppTheme.secondaryColor;
        text = 'Shipped';
        break;
      case OrderStatus.delivered:
        color = AppTheme.successColor;
        text = 'Delivered';
        break;
      case OrderStatus.cancelled:
        color = AppTheme.errorColor;
        text = 'Cancelled';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: AppTheme.bodySmall.copyWith(
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}

enum OrderStatus { processing, shipped, delivered, cancelled }

class Order {
  final String id;
  final String date;
  final OrderStatus status;
  final double total;
  final List<OrderItem> items;

  Order({
    required this.id,
    required this.date,
    required this.status,
    required this.total,
    required this.items,
  });
}

class OrderItem {
  final String name;
  final int quantity;
  final double price;
  final String imageUrl;

  OrderItem(this.name, this.quantity, this.price, this.imageUrl);
}
