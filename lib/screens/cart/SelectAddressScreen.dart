import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class SelectAddressScreen extends StatefulWidget {
  final bool isSelectionMode;

  const SelectAddressScreen({
    super.key,
    this.isSelectionMode = true,
  });

  @override
  State<SelectAddressScreen> createState() => _SelectAddressScreenState();
}

class _SelectAddressScreenState extends State<SelectAddressScreen> {
  List<Address> addresses = [];
  Address? selectedAddress;

  @override
  void initState() {
    super.initState();
    _loadAddresses();
  }

  void _loadAddresses() {
    addresses = [
      Address(
        id: '1',
        name: 'John Doe',
        phone: '+91 98765 43210',
        address: '123 Main Street, Apartment 4B',
        landmark: 'Near Central Park',
        city: 'Mumbai',
        state: 'Maharashtra',
        pincode: '400001',
        type: AddressType.home,
        isDefault: true,
      ),
      Address(
        id: '2',
        name: 'John Doe',
        phone: '+91 98765 43210',
        address: '456 Business Plaza, Floor 8',
        landmark: 'Opposite Metro Station',
        city: 'Mumbai',
        state: 'Maharashtra',
        pincode: '400002',
        type: AddressType.work,
        isDefault: false,
      ),
      Address(
        id: '3',
        name: 'John Doe',
        phone: '+91 98765 43210',
        address: '789 Residential Complex, Block C',
        landmark: 'Near Shopping Mall',
        city: 'Mumbai',
        state: 'Maharashtra',
        pincode: '400003',
        type: AddressType.other,
        isDefault: false,
      ),
    ];

    selectedAddress = addresses.firstWhere((addr) => addr.isDefault);
  }

  void _selectAddress(Address address) {
    setState(() {
      selectedAddress = address;
    });

    if (widget.isSelectionMode) {
      Navigator.pop(context, address);
    }
  }

  void _addNewAddress() {
    Navigator.pushNamed(context, '/add-edit-address').then((result) {
      if (result != null) {
        setState(() {
          addresses.add(result as Address);
        });
      }
    });
  }

  void _editAddress(Address address) {
    Navigator.pushNamed(
      context,
      '/add-edit-address',
      arguments: address,
    ).then((result) {
      if (result != null) {
        setState(() {
          final index = addresses.indexWhere((addr) => addr.id == address.id);
          if (index != -1) {
            addresses[index] = result as Address;
          }
        });
      }
    });
  }

  void _deleteAddress(Address address) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Address'),
        content: Text('Are you sure you want to delete this address?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                addresses.removeWhere((addr) => addr.id == address.id);
                if (selectedAddress?.id == address.id) {
                  selectedAddress = addresses.isNotEmpty ? addresses.first : null;
                }
              });
              Navigator.pop(context);
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isSelectionMode ? 'Select Address' : 'My Addresses'),
        actions: [
          if (!widget.isSelectionMode)
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: _addNewAddress,
            ),
        ],
      ),
      body: Column(
        children: [
          // Add new address button (only in selection mode)
          if (widget.isSelectionMode)
            Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: _addNewAddress,
                  icon: const Icon(Icons.add_location),
                  label: const Text('Add New Address'),
                ),
              ),
            ),
          
          // Address list
          Expanded(
            child: addresses.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.location_off,
                          size: 64,
                          color: AppTheme.textLight,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No addresses found',
                          style: AppTheme.heading3,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Add your first address to get started',
                          style: AppTheme.bodyMedium,
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton.icon(
                          onPressed: _addNewAddress,
                          icon: const Icon(Icons.add_location),
                          label: const Text('Add Address'),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: addresses.length,
                    itemBuilder: (context, index) {
                      return _buildAddressCard(addresses[index]);
                    },
                  ),
          ),
          
          // Continue button (only in selection mode)
          if (widget.isSelectionMode && selectedAddress != null)
            Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, selectedAddress);
                  },
                  child: const Text('Continue'),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildAddressCard(Address address) {
    final isSelected = selectedAddress?.id == address.id;
    
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: isSelected ? 4 : 2,
      color: isSelected ? AppTheme.primaryColor.withOpacity(0.1) : Colors.white,
      child: InkWell(
        onTap: () => _selectAddress(address),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: isSelected
                ? Border.all(color: AppTheme.primaryColor, width: 2)
                : null,
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      _getAddressTypeIcon(address.type),
                      color: AppTheme.primaryColor,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      _getAddressTypeText(address.type),
                      style: AppTheme.bodySmall.copyWith(
                        color: AppTheme.primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (address.isDefault) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppTheme.successColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          'Default',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                    const Spacer(),
                    if (!widget.isSelectionMode) ...[
                      IconButton(
                        icon: const Icon(Icons.edit, size: 20),
                        onPressed: () => _editAddress(address),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, size: 20),
                        onPressed: () => _deleteAddress(address),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  address.name,
                  style: AppTheme.bodyLarge.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                Text(
                  address.phone,
                  style: AppTheme.bodyMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  address.address,
                  style: AppTheme.bodyMedium,
                ),
                if (address.landmark.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    'Landmark: ${address.landmark}',
                    style: AppTheme.bodySmall,
                  ),
                ],
                const SizedBox(height: 4),
                Text(
                  '${address.city}, ${address.state} - ${address.pincode}',
                  style: AppTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  IconData _getAddressTypeIcon(AddressType type) {
    switch (type) {
      case AddressType.home:
        return Icons.home;
      case AddressType.work:
        return Icons.work;
      case AddressType.other:
        return Icons.location_on;
    }
  }

  String _getAddressTypeText(AddressType type) {
    switch (type) {
      case AddressType.home:
        return 'Home';
      case AddressType.work:
        return 'Work';
      case AddressType.other:
        return 'Other';
    }
  }
}

class Address {
  final String id;
  final String name;
  final String phone;
  final String address;
  final String landmark;
  final String city;
  final String state;
  final String pincode;
  final AddressType type;
  final bool isDefault;

  Address({
    required this.id,
    required this.name,
    required this.phone,
    required this.address,
    required this.landmark,
    required this.city,
    required this.state,
    required this.pincode,
    required this.type,
    required this.isDefault,
  });
}

enum AddressType { home, work, other } 