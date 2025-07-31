import 'package:flutter/material.dart';
import '../../models/order_model.dart';
import '../../services/payment_service.dart';
import '../../theme/app_theme.dart';
import '../../widgets/common_widgets.dart';

class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({super.key});

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  final PaymentService _paymentService = PaymentService();
  PaymentMethod? _selectedMethod;

  @override
  void initState() {
    super.initState();
    _selectedMethod = _paymentService.defaultPaymentMethod;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('Payment Methods'),
        backgroundColor: Colors.white,
        foregroundColor: AppTheme.textPrimary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          TextButton(
            onPressed: () => _showAddPaymentMethodDialog(),
            child: Text(
              'Add New',
              style: AppTheme.bodyMedium.copyWith(
                color: AppTheme.primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: StreamBuilder<List<PaymentMethod>>(
        stream: _paymentService.paymentMethodsStream,
        builder: (context, snapshot) {
          final methods = snapshot.data ?? _paymentService.paymentMethods;
          
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: methods.length,
            itemBuilder: (context, index) {
              final method = methods[index];
              return _buildPaymentMethodCard(method);
            },
          );
        },
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: CustomButton(
          text: 'Continue',
          onPressed: _selectedMethod != null ? () {
            Navigator.pop(context, _selectedMethod);
          } : null,
        ),
      ),
    );
  }

  Widget _buildPaymentMethodCard(PaymentMethod method) {
    final isSelected = _selectedMethod?.id == method.id;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSelected ? AppTheme.primaryColor : AppTheme.borderColor,
          width: isSelected ? 2 : 1,
        ),
      ),
      child: RadioListTile<PaymentMethod>(
        value: method,
        groupValue: _selectedMethod,
        onChanged: (value) {
          setState(() {
            _selectedMethod = value;
          });
        },
        title: Row(
          children: [
            Icon(
              _getPaymentIcon(method.type),
              color: AppTheme.primaryColor,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                method.displayName,
                style: AppTheme.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            if (method.isDefault) ...[
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Default',
                  style: AppTheme.bodySmall.copyWith(
                    color: AppTheme.primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ],
        ),
        subtitle: method.type == PaymentType.card && method.expiryDate != null
            ? Text(
                'Expires ${method.expiryDate}',
                style: AppTheme.bodySmall.copyWith(
                  color: AppTheme.textSecondary,
                ),
              )
            : null,
        activeColor: AppTheme.primaryColor,
      ),
    );
  }

  IconData _getPaymentIcon(PaymentType type) {
    switch (type) {
      case PaymentType.card:
        return Icons.credit_card;
      case PaymentType.upi:
        return Icons.account_balance_wallet;
      case PaymentType.netBanking:
        return Icons.account_balance;
      case PaymentType.wallet:
        return Icons.wallet;
      case PaymentType.cod:
        return Icons.money;
    }
  }

  void _showAddPaymentMethodDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.4,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Add Payment Method',
                    style: AppTheme.heading3,
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _buildAddMethodOption(
                    icon: Icons.credit_card,
                    title: 'Credit/Debit Card',
                    subtitle: 'Add a new card',
                    onTap: () {
                      Navigator.pop(context);
                      _showAddCardDialog();
                    },
                  ),
                  _buildAddMethodOption(
                    icon: Icons.account_balance_wallet,
                    title: 'UPI',
                    subtitle: 'Add UPI ID',
                    onTap: () {
                      Navigator.pop(context);
                      _showAddUPIDialog();
                    },
                  ),
                  _buildAddMethodOption(
                    icon: Icons.account_balance,
                    title: 'Net Banking',
                    subtitle: 'Add bank account',
                    onTap: () {
                      Navigator.pop(context);
                      _showAddNetBankingDialog();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddMethodOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppTheme.primaryColor),
      title: Text(
        title,
        style: AppTheme.bodyMedium.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: AppTheme.bodySmall.copyWith(
          color: AppTheme.textSecondary,
        ),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }

  void _showAddCardDialog() {
    final cardNumberController = TextEditingController();
    final expiryController = TextEditingController();
    final holderNameController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Credit/Debit Card'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: cardNumberController,
              decoration: const InputDecoration(
                labelText: 'Card Number',
                hintText: '1234 5678 9012 3456',
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: expiryController,
              decoration: const InputDecoration(
                labelText: 'Expiry Date',
                hintText: 'MM/YY',
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: holderNameController,
              decoration: const InputDecoration(
                labelText: 'Cardholder Name',
                hintText: 'John Doe',
              ),
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
              if (cardNumberController.text.isNotEmpty &&
                  expiryController.text.isNotEmpty &&
                  holderNameController.text.isNotEmpty) {
                final method = PaymentMethod(
                  id: 'card_${DateTime.now().millisecondsSinceEpoch}',
                  type: PaymentType.card,
                  displayName: '**** **** **** ${cardNumberController.text.substring(cardNumberController.text.length - 4)}',
                  cardNumber: cardNumberController.text,
                  expiryDate: expiryController.text,
                  holderName: holderNameController.text,
                );
                
                _paymentService.addPaymentMethod(method);
                Navigator.pop(context);
                
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Card added successfully')),
                );
              }
            },
            child: const Text('Add Card'),
          ),
        ],
      ),
    );
  }

  void _showAddUPIDialog() {
    final upiController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add UPI ID'),
        content: TextField(
          controller: upiController,
          decoration: const InputDecoration(
            labelText: 'UPI ID',
            hintText: 'yourname@paytm',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (upiController.text.isNotEmpty) {
                final method = PaymentMethod(
                  id: 'upi_${DateTime.now().millisecondsSinceEpoch}',
                  type: PaymentType.upi,
                  displayName: upiController.text,
                  upiId: upiController.text,
                );
                
                _paymentService.addPaymentMethod(method);
                Navigator.pop(context);
                
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('UPI ID added successfully')),
                );
              }
            },
            child: const Text('Add UPI'),
          ),
        ],
      ),
    );
  }

  void _showAddNetBankingDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Net Banking'),
        content: const Text('Net Banking integration will be available soon.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}