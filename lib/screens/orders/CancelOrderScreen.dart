import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class CancelOrderScreen extends StatefulWidget {
  final String orderId;
  final List<OrderItem> orderItems;

  const CancelOrderScreen({
    super.key,
    required this.orderId,
    required this.orderItems,
  });

  @override
  State<CancelOrderScreen> createState() => _CancelOrderScreenState();
}

class _CancelOrderScreenState extends State<CancelOrderScreen> {
  List<OrderItem> selectedItems = [];
  String? selectedReason;
  final TextEditingController _commentsController = TextEditingController();

  final List<String> cancelReasons = [
    'Changed my mind',
    'Found better price elsewhere',
    'Ordered by mistake',
    'Item not as expected',
    'Delivery too late',
    'Duplicate order',
    'Payment issues',
    'Other',
  ];

  @override
  void initState() {
    super.initState();
    selectedItems = List.from(widget.orderItems);
  }

  @override
  void dispose() {
    _commentsController.dispose();
    super.dispose();
  }

  void _toggleItemSelection(OrderItem item) {
    setState(() {
      if (selectedItems.contains(item)) {
        selectedItems.remove(item);
      } else {
        selectedItems.add(item);
      }
    });
  }

  void _selectAllItems() {
    setState(() {
      selectedItems = List.from(widget.orderItems);
    });
  }

  void _deselectAllItems() {
    setState(() {
      selectedItems.clear();
    });
  }

  void _cancelOrder() {
    if (selectedItems.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select at least one item to cancel'),
          backgroundColor: AppTheme.errorColor,
        ),
      );
      return;
    }

    if (selectedReason == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a cancellation reason'),
          backgroundColor: AppTheme.errorColor,
        ),
      );
      return;
    }

    // Show confirmation dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cancel Order'),
        content: Text(
          'Are you sure you want to cancel ${selectedItems.length} item(s) from order #${widget.orderId}?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('No, Keep Order'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _confirmCancellation();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.errorColor,
            ),
            child: const Text('Yes, Cancel Order'),
          ),
        ],
      ),
    );
  }

  void _confirmCancellation() {
    // TODO: Submit cancellation to backend
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Order cancellation request submitted successfully!'),
        backgroundColor: AppTheme.successColor,
      ),
    );

    Navigator.pop(context, {
      'cancelledItems': selectedItems,
      'reason': selectedReason,
      'comments': _commentsController.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cancel Order'),
      ),
      body: Column(
        children: [
          // Order info
          Container(
            padding: const EdgeInsets.all(16),
            color: AppTheme.backgroundColor,
            child: Row(
              children: [
                Icon(Icons.receipt, color: AppTheme.primaryColor),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Order #${widget.orderId}',
                        style: AppTheme.heading3,
                      ),
                      Text(
                        'Select items you want to cancel',
                        style: AppTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Select all/none buttons
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: _selectAllItems,
                    child: const Text('Select All'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton(
                    onPressed: _deselectAllItems,
                    child: const Text('Deselect All'),
                  ),
                ),
              ],
            ),
          ),
          
          // Order items
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: widget.orderItems.length,
              itemBuilder: (context, index) {
                return _buildOrderItem(widget.orderItems[index]);
              },
            ),
          ),
          
          // Cancellation reason
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: AppTheme.borderColor)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Cancellation Reason',
                  style: AppTheme.heading3,
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  value: selectedReason,
                  decoration: const InputDecoration(
                    labelText: 'Select a reason',
                    border: OutlineInputBorder(),
                  ),
                  items: cancelReasons.map((reason) {
                    return DropdownMenuItem(
                      value: reason,
                      child: Text(reason),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedReason = value;
                    });
                  },
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _commentsController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: 'Additional Comments (Optional)',
                    border: OutlineInputBorder(),
                    hintText: 'Please provide any additional details...',
                  ),
                ),
              ],
            ),
          ),
          
          // Cancel button
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _cancelOrder,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.errorColor,
                ),
                child: const Text('Cancel Selected Items'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderItem(OrderItem item) {
    final isSelected = selectedItems.contains(item);
    
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () => _toggleItemSelection(item),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: isSelected
                ? Border.all(color: AppTheme.primaryColor, width: 2)
                : null,
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Checkbox(
                  value: isSelected,
                  onChanged: (value) => _toggleItemSelection(item),
                ),
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: NetworkImage(item.imageUrl),
                      fit: BoxFit.cover,
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
                        style: AppTheme.bodyLarge,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Qty: ${item.quantity}',
                        style: AppTheme.bodyMedium,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item.price,
                        style: AppTheme.heading3.copyWith(color: AppTheme.primaryColor),
                      ),
                    ],
                  ),
                ),
                if (item.canCancel)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppTheme.successColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'Eligible',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                else
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppTheme.textLight,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'Not Eligible',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class OrderItem {
  final String id;
  final String name;
  final String price;
  final int quantity;
  final String imageUrl;
  final bool canCancel;

  OrderItem({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
    required this.imageUrl,
    required this.canCancel,
  });
} 