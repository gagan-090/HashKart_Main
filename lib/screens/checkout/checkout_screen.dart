import 'package:flutter/material.dart';
import '../../models/product_model.dart';
import '../../models/order_model.dart';
import '../../services/cart_service.dart';
import '../../services/address_service.dart';
import '../../services/payment_service.dart';
import '../../theme/app_theme.dart';
import '../../widgets/common_widgets.dart';
import '../../routes/navigation_helper.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final CartService _cartService = CartService();
  final AddressService _addressService = AddressService();
  final PaymentService _paymentService = PaymentService();
  
  DeliveryAddress? _selectedAddress;
  PaymentMethod? _selectedPaymentMethod;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _selectedAddress = _addressService.defaultAddress;
    _selectedPaymentMethod = _paymentService.defaultPaymentMethod;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('Checkout'),
        backgroundColor: Colors.white,
        foregroundColor: AppTheme.textPrimary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: StreamBuilder<List<CartItem>>(
        stream: _cartService.cartStream,
        builder: (context, snapshot) {
          final cartItems = snapshot.data ?? _cartService.cartItems;
          
          if (cartItems.isEmpty) {
            return const Center(
              child: Text('Your cart is empty'),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Delivery Address Section
                _buildDeliveryAddressSection(),
                const SizedBox(height: 16),
                
                // Order Items Section
                _buildOrderItemsSection(cartItems),
                const SizedBox(height: 16),
                
                // Payment Method Section
                _buildPaymentMethodSection(),
                const SizedBox(height: 16),
                
                // Order Summary Section
                _buildOrderSummarySection(),
                const SizedBox(height: 100),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  Widget _buildDeliveryAddressSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Delivery Address',
                style: AppTheme.heading3.copyWith(fontSize: 16),
              ),
              TextButton(
                onPressed: () => _showAddressSelection(),
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
          if (_selectedAddress != null) ...[
            Text(
              _selectedAddress!.name,
              style: AppTheme.bodyMedium.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              _selectedAddress!.phone,
              style: AppTheme.bodyMedium.copyWith(
                color: AppTheme.textSecondary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              _selectedAddress!.fullAddress,
              style: AppTheme.bodyMedium.copyWith(
                color: AppTheme.textSecondary,
                height: 1.4,
              ),
            ),
          ] else ...[
            TextButton.icon(
              onPressed: () => NavigationHelper.goToAddAddress(),
              icon: const Icon(Icons.add),
              label: const Text('Add Delivery Address'),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildOrderItemsSection(List<CartItem> cartItems) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Order Items (${cartItems.length})',
            style: AppTheme.heading3.copyWith(fontSize: 16),
          ),
          const SizedBox(height: 12),
          ...cartItems.map((item) => _buildOrderItem(item)),
        ],
      ),
    );
  }

  Widget _buildOrderItem(CartItem item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              item.product.imageUrls.first,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 60,
                  height: 60,
                  color: Colors.grey[200],
                  child: const Icon(Icons.image, color: Colors.grey),
                );
              },
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.product.name,
                  style: AppTheme.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                if (item.selectedColor.isNotEmpty || item.selectedSize.isNotEmpty) ...[
                  Text(
                    '${item.selectedColor.isNotEmpty ? 'Color: ${item.selectedColor}' : ''}'
                    '${item.selectedColor.isNotEmpty && item.selectedSize.isNotEmpty ? ', ' : ''}'
                    '${item.selectedSize.isNotEmpty ? 'Size: ${item.selectedSize}' : ''}',
                    style: AppTheme.bodySmall.copyWith(
                      color: AppTheme.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 4),
                ],
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Qty: ${item.quantity}',
                      style: AppTheme.bodyMedium.copyWith(
                        color: AppTheme.textSecondary,
                      ),
                    ),
                    Text(
                      item.product.price,
                      style: AppTheme.bodyMedium.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppTheme.primaryColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Payment Method',
                style: AppTheme.heading3.copyWith(fontSize: 16),
              ),
              TextButton(
                onPressed: () => _showPaymentMethodSelection(),
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
          if (_selectedPaymentMethod != null) ...[
            Row(
              children: [
                Icon(
                  _getPaymentIcon(_selectedPaymentMethod!.type),
                  color: AppTheme.primaryColor,
                ),
                const SizedBox(width: 12),
                Text(
                  _selectedPaymentMethod!.displayName,
                  style: AppTheme.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ] else ...[
            TextButton.icon(
              onPressed: () => NavigationHelper.goToPaymentMethod(),
              icon: const Icon(Icons.add),
              label: const Text('Select Payment Method'),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildOrderSummarySection() {
    final subtotal = _cartService.subtotal;
    final shipping = _cartService.shipping;
    final tax = _cartService.tax;
    final total = _cartService.total;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Order Summary',
            style: AppTheme.heading3.copyWith(fontSize: 16),
          ),
          const SizedBox(height: 12),
          _buildSummaryRow('Subtotal', '₹${subtotal.toStringAsFixed(2)}'),
          _buildSummaryRow('Shipping', shipping == 0 ? 'Free' : '₹${shipping.toStringAsFixed(2)}'),
          _buildSummaryRow('Tax (GST)', '₹${tax.toStringAsFixed(2)}'),
          const Divider(height: 24),
          _buildSummaryRow(
            'Total',
            '₹${total.toStringAsFixed(2)}',
            isTotal: true,
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: isTotal 
                ? AppTheme.bodyMedium.copyWith(fontWeight: FontWeight.w600)
                : AppTheme.bodyMedium.copyWith(color: AppTheme.textSecondary),
          ),
          Text(
            value,
            style: isTotal 
                ? AppTheme.heading3.copyWith(color: AppTheme.primaryColor)
                : AppTheme.bodyMedium.copyWith(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
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
        text: _isLoading ? 'Processing...' : 'Place Order',
        onPressed: _selectedAddress != null && _selectedPaymentMethod != null && !_isLoading
            ? _placeOrder
            : null,
        isLoading: _isLoading,
      ),
    );
  }

  void _showAddressSelection() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
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
                    'Select Address',
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
              child: StreamBuilder<List<DeliveryAddress>>(
                stream: _addressService.addressStream,
                builder: (context, snapshot) {
                  final addresses = snapshot.data ?? _addressService.addresses;
                  
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: addresses.length + 1,
                    itemBuilder: (context, index) {
                      if (index == addresses.length) {
                        return ListTile(
                          leading: const Icon(Icons.add, color: AppTheme.primaryColor),
                          title: Text(
                            'Add New Address',
                            style: AppTheme.bodyMedium.copyWith(
                              color: AppTheme.primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          onTap: () {
                            Navigator.pop(context);
                            NavigationHelper.goToAddAddress();
                          },
                        );
                      }
                      
                      final address = addresses[index];
                      return RadioListTile<DeliveryAddress>(
                        value: address,
                        groupValue: _selectedAddress,
                        onChanged: (value) {
                          setState(() {
                            _selectedAddress = value;
                          });
                          Navigator.pop(context);
                        },
                        title: Text(
                          address.name,
                          style: AppTheme.bodyMedium.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        subtitle: Text(
                          address.fullAddress,
                          style: AppTheme.bodySmall.copyWith(
                            color: AppTheme.textSecondary,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showPaymentMethodSelection() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
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
                    'Select Payment Method',
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
              child: StreamBuilder<List<PaymentMethod>>(
                stream: _paymentService.paymentMethodsStream,
                builder: (context, snapshot) {
                  final methods = snapshot.data ?? _paymentService.paymentMethods;
                  
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: methods.length + 1,
                    itemBuilder: (context, index) {
                      if (index == methods.length) {
                        return ListTile(
                          leading: const Icon(Icons.add, color: AppTheme.primaryColor),
                          title: Text(
                            'Add New Payment Method',
                            style: AppTheme.bodyMedium.copyWith(
                              color: AppTheme.primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          onTap: () {
                            Navigator.pop(context);
                            NavigationHelper.goToAddNewCard();
                          },
                        );
                      }
                      
                      final method = methods[index];
                      return RadioListTile<PaymentMethod>(
                        value: method,
                        groupValue: _selectedPaymentMethod,
                        onChanged: (value) {
                          setState(() {
                            _selectedPaymentMethod = value;
                          });
                          Navigator.pop(context);
                        },
                        title: Text(
                          method.displayName,
                          style: AppTheme.bodyMedium.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        secondary: Icon(
                          _getPaymentIcon(method.type),
                          color: AppTheme.primaryColor,
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
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

  void _placeOrder() async {
    if (_selectedAddress == null || _selectedPaymentMethod == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select address and payment method')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Navigate to payment processing screen
      final result = await Navigator.pushNamed(
        context,
        '/payment-processing',
        arguments: {
          'paymentMethod': _selectedPaymentMethod,
          'address': _selectedAddress,
          'cartItems': _cartService.cartItems,
          'total': _cartService.total,
        },
      );

      if (result == true) {
        // Payment successful, clear cart and navigate to success
        _cartService.clearCart();
        NavigationHelper.goToOrderSuccess();
      }
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}
