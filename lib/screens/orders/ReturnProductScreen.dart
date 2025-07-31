import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class ReturnProductScreen extends StatefulWidget {
  final String orderId;
  final List<ReturnItem> returnItems;

  const ReturnProductScreen({
    super.key,
    required this.orderId,
    required this.returnItems,
  });

  @override
  State<ReturnProductScreen> createState() => _ReturnProductScreenState();
}

class _ReturnProductScreenState extends State<ReturnProductScreen> {
  List<ReturnItem> selectedItems = [];
  String? selectedReason;
  ReturnType selectedReturnType = ReturnType.pickup;
  final TextEditingController _commentsController = TextEditingController();

  final List<String> returnReasons = [
    'Defective product',
    'Wrong item received',
    'Size doesn\'t fit',
    'Not as described',
    'Quality issues',
    'Damaged during delivery',
    'Changed my mind',
    'Other',
  ];

  @override
  void initState() {
    super.initState();
    selectedItems = List.from(widget.returnItems);
  }

  @override
  void dispose() {
    _commentsController.dispose();
    super.dispose();
  }

  void _toggleItemSelection(ReturnItem item) {
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
      selectedItems = List.from(widget.returnItems);
    });
  }

  void _deselectAllItems() {
    setState(() {
      selectedItems.clear();
    });
  }

  void _submitReturn() {
    if (selectedItems.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select at least one item to return'),
          backgroundColor: AppTheme.errorColor,
        ),
      );
      return;
    }

    if (selectedReason == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a return reason'),
          backgroundColor: AppTheme.errorColor,
        ),
      );
      return;
    }

    // Show confirmation dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Submit Return Request'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Are you sure you want to return ${selectedItems.length} item(s)?'),
            const SizedBox(height: 8),
            Text(
              'Return Type: ${selectedReturnType == ReturnType.pickup ? 'Pickup' : 'Drop-off'}',
              style: AppTheme.bodySmall,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _confirmReturn();
            },
            child: const Text('Submit Return'),
          ),
        ],
      ),
    );
  }

  void _confirmReturn() {
    // TODO: Submit return request to backend
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Return request submitted successfully!'),
        backgroundColor: AppTheme.successColor,
      ),
    );

    Navigator.pop(context, {
      'returnedItems': selectedItems,
      'reason': selectedReason,
      'returnType': selectedReturnType,
      'comments': _commentsController.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Return Products'),
      ),
      body: Column(
        children: [
          // Order info
          Container(
            padding: const EdgeInsets.all(16),
            color: AppTheme.backgroundColor,
            child: Row(
              children: [
                Icon(Icons.assignment_return, color: AppTheme.primaryColor),
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
                        'Select items you want to return',
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
          
          // Return items
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: widget.returnItems.length,
              itemBuilder: (context, index) {
                return _buildReturnItem(widget.returnItems[index]);
              },
            ),
          ),
          
          // Return details
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
                  'Return Details',
                  style: AppTheme.heading3,
                ),
                const SizedBox(height: 16),
                
                // Return reason
                DropdownButtonFormField<String>(
                  value: selectedReason,
                  decoration: const InputDecoration(
                    labelText: 'Return Reason',
                    border: OutlineInputBorder(),
                  ),
                  items: returnReasons.map((reason) {
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
                
                // Return type
                Text(
                  'Return Type',
                  style: AppTheme.bodyLarge.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: RadioListTile<ReturnType>(
                        title: const Text('Pickup'),
                        subtitle: const Text('We\'ll collect from your address'),
                        value: ReturnType.pickup,
                        groupValue: selectedReturnType,
                        onChanged: (value) {
                          setState(() {
                            selectedReturnType = value!;
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: RadioListTile<ReturnType>(
                        title: const Text('Drop-off'),
                        subtitle: const Text('Drop at nearest center'),
                        value: ReturnType.dropoff,
                        groupValue: selectedReturnType,
                        onChanged: (value) {
                          setState(() {
                            selectedReturnType = value!;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                
                // Comments
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
          
          // Submit button
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _submitReturn,
                child: const Text('Submit Return Request'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReturnItem(ReturnItem item) {
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
                      const SizedBox(height: 4),
                      Text(
                        'Return Window: ${item.returnWindow} days',
                        style: AppTheme.bodySmall.copyWith(color: AppTheme.textLight),
                      ),
                    ],
                  ),
                ),
                if (item.canReturn)
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

class ReturnItem {
  final String id;
  final String name;
  final String price;
  final int quantity;
  final String imageUrl;
  final bool canReturn;
  final int returnWindow;

  ReturnItem({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
    required this.imageUrl,
    required this.canReturn,
    required this.returnWindow,
  });
}

enum ReturnType { pickup, dropoff } 