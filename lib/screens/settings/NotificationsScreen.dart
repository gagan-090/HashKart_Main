import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  List<NotificationItem> notifications = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadNotifications();
  }

  void _loadNotifications() {
    // Simulate loading
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        notifications = [
          NotificationItem(
            id: '1',
            title: 'Flash Sale Alert!',
            message: 'Get up to 50% off on electronics. Sale ends in 2 hours.',
            type: NotificationType.offer,
            timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
            isRead: false,
            imageUrl: 'https://via.placeholder.com/60x60/6C5CE7/FFFFFF?text=Sale',
          ),
          NotificationItem(
            id: '2',
            title: 'Order Shipped',
            message: 'Your order #ORD123456 has been shipped and is on its way.',
            type: NotificationType.order,
            timestamp: DateTime.now().subtract(const Duration(hours: 2)),
            isRead: true,
            imageUrl: 'https://via.placeholder.com/60x60/00B894/FFFFFF?text=Ship',
          ),
          NotificationItem(
            id: '3',
            title: 'New Product Available',
            message: 'Check out the latest smartphones from top brands.',
            type: NotificationType.product,
            timestamp: DateTime.now().subtract(const Duration(hours: 4)),
            isRead: false,
            imageUrl: 'https://via.placeholder.com/60x60/74B9FF/FFFFFF?text=New',
          ),
          NotificationItem(
            id: '4',
            title: 'App Update Available',
            message: 'Update to the latest version for new features and improvements.',
            type: NotificationType.app,
            timestamp: DateTime.now().subtract(const Duration(days: 1)),
            isRead: true,
            imageUrl: 'https://via.placeholder.com/60x60/FDCB6E/FFFFFF?text=App',
          ),
          NotificationItem(
            id: '5',
            title: 'Payment Successful',
            message: 'Payment of ₹2,499 for order #ORD123456 has been processed.',
            type: NotificationType.payment,
            timestamp: DateTime.now().subtract(const Duration(days: 1)),
            isRead: true,
            imageUrl: 'https://via.placeholder.com/60x60/00B894/FFFFFF?text=Pay',
          ),
          NotificationItem(
            id: '6',
            title: 'Welcome to HashKart!',
            message: 'Thank you for joining us. Start shopping now!',
            type: NotificationType.welcome,
            timestamp: DateTime.now().subtract(const Duration(days: 2)),
            isRead: true,
            imageUrl: 'https://via.placeholder.com/60x60/6C5CE7/FFFFFF?text=Hi',
          ),
        ];
        isLoading = false;
      });
    });
  }

  void _markAsRead(NotificationItem notification) {
    setState(() {
      notification.isRead = true;
    });
  }

  void _deleteNotification(NotificationItem notification) {
    setState(() {
      notifications.remove(notification);
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Notification deleted'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              notifications.add(notification);
            });
          },
        ),
      ),
    );
  }

  void _markAllAsRead() {
    setState(() {
      for (var notification in notifications) {
        notification.isRead = true;
      }
    });
  }

  void _clearAll() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear All Notifications'),
        content: const Text('Are you sure you want to clear all notifications?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                notifications.clear();
              });
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.errorColor,
            ),
            child: const Text('Clear All'),
          ),
        ],
      ),
    );
  }

  String _getTimeAgo(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }

  Color _getNotificationColor(NotificationType type) {
    switch (type) {
      case NotificationType.offer:
        return AppTheme.accentColor;
      case NotificationType.order:
        return AppTheme.successColor;
      case NotificationType.product:
        return AppTheme.secondaryColor;
      case NotificationType.app:
        return AppTheme.warningColor;
      case NotificationType.payment:
        return AppTheme.successColor;
      case NotificationType.welcome:
        return AppTheme.primaryColor;
    }
  }

  IconData _getNotificationIcon(NotificationType type) {
    switch (type) {
      case NotificationType.offer:
        return Icons.local_offer;
      case NotificationType.order:
        return Icons.shopping_bag;
      case NotificationType.product:
        return Icons.inventory;
      case NotificationType.app:
        return Icons.system_update;
      case NotificationType.payment:
        return Icons.payment;
      case NotificationType.welcome:
        return Icons.waving_hand;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [
          if (notifications.isNotEmpty) ...[
            TextButton(
              onPressed: _markAllAsRead,
              child: const Text('Mark All Read'),
            ),
            IconButton(
              icon: const Icon(Icons.clear_all),
              onPressed: _clearAll,
            ),
          ],
        ],
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : notifications.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.notifications_none,
                        size: 64,
                        color: AppTheme.textLight,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No notifications',
                        style: AppTheme.heading3,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'You\'re all caught up!',
                        style: AppTheme.bodyMedium,
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: notifications.length,
                  itemBuilder: (context, index) {
                    return _buildNotificationCard(notifications[index]);
                  },
                ),
    );
  }

  Widget _buildNotificationCard(NotificationItem notification) {
    return Dismissible(
      key: Key(notification.id),
      background: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: AppTheme.errorColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ),
        ),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        _deleteNotification(notification);
      },
      child: Card(
        margin: const EdgeInsets.only(bottom: 12),
        color: notification.isRead ? Colors.white : AppTheme.primaryColor.withOpacity(0.05),
        child: InkWell(
          onTap: () => _markAsRead(notification),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: _getNotificationColor(notification.type).withOpacity(0.1),
                  ),
                  child: Icon(
                    _getNotificationIcon(notification.type),
                    color: _getNotificationColor(notification.type),
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              notification.title,
                              style: AppTheme.bodyLarge.copyWith(
                                fontWeight: notification.isRead ? FontWeight.normal : FontWeight.w600,
                              ),
                            ),
                          ),
                          if (!notification.isRead)
                            Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                color: AppTheme.primaryColor,
                                shape: BoxShape.circle,
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        notification.message,
                        style: AppTheme.bodyMedium,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _getTimeAgo(notification.timestamp),
                        style: AppTheme.bodySmall.copyWith(color: AppTheme.textLight),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.more_vert),
                  onPressed: () {
                    _showNotificationOptions(notification);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showNotificationOptions(NotificationItem notification) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(
                notification.isRead ? Icons.mark_email_unread : Icons.mark_email_read,
              ),
              title: Text(notification.isRead ? 'Mark as unread' : 'Mark as read'),
              onTap: () {
                Navigator.pop(context);
                _markAsRead(notification);
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete),
              title: const Text('Delete notification'),
              onTap: () {
                Navigator.pop(context);
                _deleteNotification(notification);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class NotificationItem {
  final String id;
  final String title;
  final String message;
  final NotificationType type;
  final DateTime timestamp;
  bool isRead;
  final String? imageUrl;

  NotificationItem({
    required this.id,
    required this.title,
    required this.message,
    required this.type,
    required this.timestamp,
    required this.isRead,
    this.imageUrl,
  });
}

enum NotificationType {
  offer,
  order,
  product,
  app,
  payment,
  welcome,
} 