import 'package:flutter/material.dart';
import '../../routes/navigation_helper.dart';
import '../../theme/app_theme.dart';
import '../../widgets/common_widgets.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  int _selectedAddressIndex = 0;
  int _selectedPaymentIndex = 0;
  bool _isLoading = false;
  String _selectedDeliveryOption = 'standard';
  bool _applyPromoCode = false;
  final TextEditingController _promoCodeController = TextEditingController();
  final TextEditingController _specialInstructionsController =
      TextEditingController();

  // Mock data
  final List<CheckoutItem> _cartItems = [
    CheckoutItem(
      id: '1',
      name: 'Wireless Headphones',
      brand: 'Sony',
      price: 7999.00,
      originalPrice: 9999.00,
      quantity: 1,
      imageUrl:
          'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=300',
      color: 'Black',
      size: 'M',
    ),
    CheckoutItem(
      id: '2',
      name: 'Smart Watch',
      brand: 'Apple',
      price: 15999.00,
      originalPrice: 19999.00,
      quantity: 2,
      imageUrl:
          'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=300',
      color: 'Silver',
      size: 'L',
    ),
    CheckoutItem(
      id: '3',
      name: 'Laptop Backpack',
      brand: 'Targus',
      price: 3999.00,
      originalPrice: 5499.00,
      quantity: 1,
      imageUrl:
          'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=300',
      color: 'Navy',
      size: 'One Size',
    ),
  ];

  final List<DeliveryAddress> _addresses = [
    DeliveryAddress(
      id: '1',
      name: 'Rajesh Kumar',
      phone: '+91 98765 43210',
      address: '123 MG Road, Sector 15',
      city: 'Mumbai',
      state: 'Maharashtra',
      zipCode: '400001',
      isDefault: true,
    ),
    DeliveryAddress(
      id: '2',
      name: 'Rajesh Kumar',
      phone: '+91 98765 43210',
      address: '456 Park Street, Andheri West',
      city: 'Mumbai',
      state: 'Maharashtra',
      zipCode: '400058',
      isDefault: false,
    ),
  ];

  final List<PaymentMethod> _paymentMethods = [
    PaymentMethod(
      id: '1',
      type: PaymentType.card,
      title: 'Credit Card',
      subtitle: '**** **** **** 1234',
      icon: Icons.credit_card,
      isDefault: true,
    ),
    PaymentMethod(
      id: '2',
      type: PaymentType.card,
      title: 'Debit Card',
      subtitle: '**** **** **** 5678',
      icon: Icons.credit_card,
      isDefault: false,
    ),
    PaymentMethod(
      id: '3',
      type: PaymentType.digital,
      title: 'UPI',
      subtitle: 'john@paytm',
      icon: Icons.account_balance_wallet,
      isDefault: false,
    ),
    PaymentMethod(
      id: '4',
      type: PaymentType.digital,
      title: 'Paytm Wallet',
      subtitle: '+91 98765 43210',
      icon: Icons.phone_android,
      isDefault: false,
    ),
    PaymentMethod(
      id: '5',
      type: PaymentType.digital,
      title: 'Google Pay',
      subtitle: 'john.doe@gmail.com',
      icon: Icons.payment,
      isDefault: false,
    ),
    PaymentMethod(
      id: '6',
      type: PaymentType.cash,
      title: 'Cash on Delivery',
      subtitle: 'Pay when you receive',
      icon: Icons.money,
      isDefault: false,
    ),
  ];

  final Map<String, DeliveryOption> _deliveryOptions = {
    'standard': DeliveryOption(
      id: 'standard',
      title: 'Standard Delivery',
      subtitle: '5-7 business days',
      price: 0.00,
      estimatedDays: '5-7',
    ),
    'express': DeliveryOption(
      id: 'express',
      title: 'Express Delivery',
      subtitle: '2-3 business days',
      price: 199.00,
      estimatedDays: '2-3',
    ),
    'overnight': DeliveryOption(
      id: 'overnight',
      title: 'Overnight Delivery',
      subtitle: 'Next business day',
      price: 299.00,
      estimatedDays: '1',
    ),
  };

  double get _subtotal {
    return _cartItems.fold(
        0, (sum, item) => sum + (item.price * item.quantity));
  }

  double get _savings {
    return _cartItems.fold(
        0,
        (sum, item) =>
            sum + ((item.originalPrice - item.price) * item.quantity));
  }

  double get _deliveryFee =>
      _deliveryOptions[_selectedDeliveryOption]?.price ?? 0.0;
  // 18% GST for India
  double get _promoDiscount => _applyPromoCode ? 500.0 : 0.0;
  double get _total => _subtotal + _deliveryFee - _promoDiscount;

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
          'Checkout',
          style: AppTheme.heading3.copyWith(
            color: AppTheme.textPrimary,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline, color: AppTheme.textPrimary),
            onPressed: () => NavigationHelper.goToHelpCenter(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Order Summary
            _buildOrderSummary(),

            // Delivery Address
            _buildDeliveryAddress(),

            // Delivery Options
            _buildDeliveryOptions(),

            // Payment Method
            _buildPaymentMethod(),

            // Promo Code
            _buildPromoCode(),

            // Special Instructions
            _buildSpecialInstructions(),

            // Order Summary
            _buildPriceSummary(),

            const SizedBox(height: 100), // Space for bottom button
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  Widget _buildOrderSummary() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Order Summary',
                style: AppTheme.heading3.copyWith(fontSize: 18),
              ),
              Text(
                '${_cartItems.length} items',
                style: AppTheme.bodyMedium.copyWith(
                  color: AppTheme.textSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...List.generate(_cartItems.length, (index) {
            final item = _cartItems[index];
            return _buildOrderItem(item);
          }),
        ],
      ),
    );
  }

  Widget _buildOrderItem(CheckoutItem item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(
              width: 60,
              height: 60,
              color: Colors.grey[100],
              child: Image.network(
                item.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: AppTheme.primaryColor.withValues(alpha: 0.1),
                    child:
                        const Icon(Icons.image, color: AppTheme.primaryColor),
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
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  '${item.brand} • ${item.color} • ${item.size}',
                  style: AppTheme.bodySmall.copyWith(
                    color: AppTheme.textSecondary,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        'Rs.${item.price.toStringAsFixed(2)}',
                        style: AppTheme.bodyMedium.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppTheme.primaryColor,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        'Rs.${item.originalPrice.toStringAsFixed(2)}',
                        style: AppTheme.bodySmall.copyWith(
                          decoration: TextDecoration.lineThrough,
                          color: AppTheme.textLight,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Text(
            'Qty: ${item.quantity}',
            style: AppTheme.bodyMedium.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeliveryAddress() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Delivery Address',
                style: AppTheme.heading3.copyWith(fontSize: 18),
              ),
              TextButton(
                onPressed: () => NavigationHelper.goToAddressList(),
                child: Text(
                  'Change',
                  style: AppTheme.bodyMedium.copyWith(
                    color: AppTheme.primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...List.generate(_addresses.length, (index) {
            final address = _addresses[index];
            final isSelected = index == _selectedAddressIndex;

            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedAddressIndex = index;
                });
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppTheme.primaryColor.withValues(alpha: 0.1)
                      : AppTheme.backgroundColor,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: isSelected
                        ? AppTheme.primaryColor
                        : AppTheme.borderColor,
                  ),
                ),
                child: Row(
                  children: [
                    Radio<int>(
                      value: index,
                      groupValue: _selectedAddressIndex,
                      onChanged: (value) {
                        setState(() {
                          _selectedAddressIndex = value!;
                        });
                      },
                      activeColor: AppTheme.primaryColor,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                address.name,
                                style: AppTheme.bodyMedium.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              if (address.isDefault) ...[
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppTheme.successColor,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    'Default',
                                    style: AppTheme.bodySmall.copyWith(
                                      color: Colors.white,
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            address.phone,
                            style: AppTheme.bodySmall.copyWith(
                              color: AppTheme.textSecondary,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${address.address}, ${address.city}, ${address.state} ${address.zipCode}',
                            style: AppTheme.bodySmall.copyWith(
                              color: AppTheme.textSecondary,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
          const SizedBox(height: 8),
          OutlinedButton.icon(
            onPressed: () => NavigationHelper.goToAddAddress(),
            icon: const Icon(Icons.add, size: 20),
            label: const Text('Add New Address'),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppTheme.primaryColor,
              side: const BorderSide(color: AppTheme.primaryColor),
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeliveryOptions() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Delivery Options',
            style: AppTheme.heading3.copyWith(fontSize: 18),
          ),
          const SizedBox(height: 16),
          ...List.generate(_deliveryOptions.length, (index) {
            final option = _deliveryOptions.values.elementAt(index);
            final isSelected = _selectedDeliveryOption == option.id;

            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedDeliveryOption = option.id;
                });
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppTheme.primaryColor.withValues(alpha: 0.1)
                      : AppTheme.backgroundColor,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: isSelected
                        ? AppTheme.primaryColor
                        : AppTheme.borderColor,
                  ),
                ),
                child: Row(
                  children: [
                    Radio<String>(
                      value: option.id,
                      groupValue: _selectedDeliveryOption,
                      onChanged: (value) {
                        setState(() {
                          _selectedDeliveryOption = value!;
                        });
                      },
                      activeColor: AppTheme.primaryColor,
                    ),
                    const SizedBox(width: 12),
                    Icon(
                      _getDeliveryIcon(option.id),
                      color: AppTheme.primaryColor,
                      size: 24,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            option.title,
                            style: AppTheme.bodyMedium.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            option.subtitle,
                            style: AppTheme.bodySmall.copyWith(
                              color: AppTheme.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      option.price == 0
                          ? 'Free'
                          : 'Rs.${option.price.toStringAsFixed(2)}',
                      style: AppTheme.bodyMedium.copyWith(
                        fontWeight: FontWeight.bold,
                        color: option.price == 0
                            ? AppTheme.successColor
                            : AppTheme.primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildPaymentMethod() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Payment Method',
                style: AppTheme.heading3.copyWith(fontSize: 18),
              ),
              TextButton(
                onPressed: () => NavigationHelper.goToPaymentMethod(),
                child: Text(
                  'Manage',
                  style: AppTheme.bodyMedium.copyWith(
                    color: AppTheme.primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...List.generate(_paymentMethods.length, (index) {
            final method = _paymentMethods[index];
            final isSelected = index == _selectedPaymentIndex;

            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedPaymentIndex = index;
                });
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppTheme.primaryColor.withValues(alpha: 0.1)
                      : AppTheme.backgroundColor,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: isSelected
                        ? AppTheme.primaryColor
                        : AppTheme.borderColor,
                  ),
                ),
                child: Row(
                  children: [
                    Radio<int>(
                      value: index,
                      groupValue: _selectedPaymentIndex,
                      onChanged: (value) {
                        setState(() {
                          _selectedPaymentIndex = value!;
                        });
                      },
                      activeColor: AppTheme.primaryColor,
                    ),
                    const SizedBox(width: 12),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: _getPaymentColor(method.type)
                            .withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        method.icon,
                        color: _getPaymentColor(method.type),
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
                              Text(
                                method.title,
                                style: AppTheme.bodyMedium.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              if (method.isDefault) ...[
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppTheme.successColor,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    'Default',
                                    style: AppTheme.bodySmall.copyWith(
                                      color: Colors.white,
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                          const SizedBox(height: 2),
                          Text(
                            method.subtitle,
                            style: AppTheme.bodySmall.copyWith(
                              color: AppTheme.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
          const SizedBox(height: 8),
          OutlinedButton.icon(
            onPressed: () => NavigationHelper.goToAddNewCard(),
            icon: const Icon(Icons.add, size: 20),
            label: const Text('Add New Payment Method'),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppTheme.primaryColor,
              side: const BorderSide(color: AppTheme.primaryColor),
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPromoCode() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Promo Code',
            style: AppTheme.heading3.copyWith(fontSize: 18),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _promoCodeController,
                  decoration: InputDecoration(
                    hintText: 'Enter promo code',
                    prefixIcon: const Icon(Icons.local_offer_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: AppTheme.borderColor),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: AppTheme.borderColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide:
                          const BorderSide(color: AppTheme.primaryColor),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              ElevatedButton(
                onPressed: _applyPromoCode
                    ? null
                    : () {
                        if (_promoCodeController.text.isNotEmpty) {
                          setState(() {
                            _applyPromoCode = true;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Promo code applied successfully!'),
                              backgroundColor: AppTheme.successColor,
                            ),
                          );
                        }
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryColor,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                ),
                child: Text(
                  _applyPromoCode ? 'Applied' : 'Apply',
                  style: AppTheme.bodyMedium.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          if (_applyPromoCode) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.successColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppTheme.successColor),
              ),
              child: Row(
                children: [
                  const Icon(Icons.check_circle,
                      color: AppTheme.successColor, size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Promo code "${_promoCodeController.text}" applied',
                      style: AppTheme.bodySmall.copyWith(
                        color: AppTheme.successColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Text(
                    '-Rs.${_promoDiscount.toStringAsFixed(2)}',
                    style: AppTheme.bodyMedium.copyWith(
                      color: AppTheme.successColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSpecialInstructions() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Special Instructions',
            style: AppTheme.heading3.copyWith(fontSize: 18),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _specialInstructionsController,
            maxLines: 3,
            decoration: InputDecoration(
              hintText: 'Add any special delivery instructions...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: AppTheme.borderColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: AppTheme.borderColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: AppTheme.primaryColor),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceSummary() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Price Summary',
            style: AppTheme.heading3.copyWith(fontSize: 18),
          ),
          const SizedBox(height: 16),
          _buildPriceRow('Subtotal', _subtotal),
          if (_savings > 0)
            _buildPriceRow('You Save', -_savings, color: AppTheme.successColor),
          _buildPriceRow('Delivery Fee', _deliveryFee),
          if (_applyPromoCode)
            _buildPriceRow('Promo Discount', -_promoDiscount,
                color: AppTheme.successColor),
          const Divider(height: 20),
          _buildPriceRow('Total', _total, isTotal: true),
        ],
      ),
    );
  }

  Widget _buildPriceRow(String label, double amount,
      {bool isTotal = false, Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: isTotal
                ? AppTheme.bodyMedium.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textPrimary,
                  )
                : AppTheme.bodyMedium.copyWith(
                    color: AppTheme.textSecondary,
                  ),
          ),
          Text(
            '${amount < 0 ? '-' : ''}Rs.${amount.abs().toStringAsFixed(2)}',
            style: isTotal
                ? AppTheme.heading3.copyWith(
                    color: AppTheme.primaryColor,
                  )
                : AppTheme.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                    color: color ?? AppTheme.textPrimary,
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(20),
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
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
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
                      'Rs.${_total.toStringAsFixed(2)}',
                      style: AppTheme.heading3.copyWith(
                        color: AppTheme.primaryColor,
                      ),
                    ),
                  ],
                ),
                Text(
                  'Estimated delivery: ${_deliveryOptions[_selectedDeliveryOption]?.estimatedDays} days',
                  style: AppTheme.bodySmall.copyWith(
                    color: AppTheme.textSecondary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            CustomButton(
              text: _isLoading ? 'Processing...' : 'Place Order',
              onPressed: _isLoading ? null : _handlePlaceOrder,
              isLoading: _isLoading,
            ),
          ],
        ),
      ),
    );
  }

  IconData _getDeliveryIcon(String deliveryId) {
    switch (deliveryId) {
      case 'standard':
        return Icons.local_shipping;
      case 'express':
        return Icons.flash_on;
      case 'overnight':
        return Icons.rocket_launch;
      default:
        return Icons.local_shipping;
    }
  }

  Color _getPaymentColor(PaymentType type) {
    switch (type) {
      case PaymentType.card:
        return AppTheme.primaryColor;
      case PaymentType.digital:
        return AppTheme.secondaryColor;
      case PaymentType.cash:
        return AppTheme.successColor;
    }
  }

  void _handlePlaceOrder() async {
    setState(() {
      _isLoading = true;
    });

    // Simulate order processing
    await Future.delayed(const Duration(seconds: 3));

    if (mounted) {
      setState(() {
        _isLoading = false;
      });
      NavigationHelper.goToOrderSuccess();
    }
  }

  @override
  void dispose() {
    _promoCodeController.dispose();
    _specialInstructionsController.dispose();
    super.dispose();
  }
}

// Data Models
class CheckoutItem {
  final String id;
  final String name;
  final String brand;
  final double price;
  final double originalPrice;
  final int quantity;
  final String imageUrl;
  final String color;
  final String size;

  CheckoutItem({
    required this.id,
    required this.name,
    required this.brand,
    required this.price,
    required this.originalPrice,
    required this.quantity,
    required this.imageUrl,
    required this.color,
    required this.size,
  });
}

class DeliveryAddress {
  final String id;
  final String name;
  final String phone;
  final String address;
  final String city;
  final String state;
  final String zipCode;
  final bool isDefault;

  DeliveryAddress({
    required this.id,
    required this.name,
    required this.phone,
    required this.address,
    required this.city,
    required this.state,
    required this.zipCode,
    required this.isDefault,
  });
}

class PaymentMethod {
  final String id;
  final PaymentType type;
  final String title;
  final String subtitle;
  final IconData icon;
  final bool isDefault;

  PaymentMethod({
    required this.id,
    required this.type,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.isDefault,
  });
}

enum PaymentType { card, digital, cash }

class DeliveryOption {
  final String id;
  final String title;
  final String subtitle;
  final double price;
  final String estimatedDays;

  DeliveryOption({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.estimatedDays,
  });
}
