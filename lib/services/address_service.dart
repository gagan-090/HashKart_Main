import 'dart:async';
import '../models/order_model.dart';

class AddressService {
  static final AddressService _instance = AddressService._internal();
  factory AddressService() => _instance;
  AddressService._internal();

  final List<DeliveryAddress> _addresses = [
    DeliveryAddress(
      id: 'addr1',
      name: 'John Doe',
      phone: '+91 9876543210',
      addressLine1: '123 Main Street',
      addressLine2: 'Apartment 4B',
      city: 'Mumbai',
      state: 'Maharashtra',
      pincode: '400001',
      type: AddressType.home,
      isDefault: true,
    ),
    DeliveryAddress(
      id: 'addr2',
      name: 'John Doe',
      phone: '+91 9876543210',
      addressLine1: 'Tech Park, Building A',
      addressLine2: 'Floor 5, Office 501',
      city: 'Bangalore',
      state: 'Karnataka',
      pincode: '560001',
      type: AddressType.work,
    ),
  ];

  final StreamController<List<DeliveryAddress>> _addressController = 
      StreamController<List<DeliveryAddress>>.broadcast();

  Stream<List<DeliveryAddress>> get addressStream => _addressController.stream;
  List<DeliveryAddress> get addresses => List.unmodifiable(_addresses);

  DeliveryAddress? get defaultAddress {
    try {
      return _addresses.firstWhere((address) => address.isDefault);
    } catch (e) {
      return _addresses.isNotEmpty ? _addresses.first : null;
    }
  }

  void addAddress(DeliveryAddress address) {
    // If this is set as default, remove default from others
    if (address.isDefault) {
      for (int i = 0; i < _addresses.length; i++) {
        if (_addresses[i].isDefault) {
          _addresses[i] = DeliveryAddress(
            id: _addresses[i].id,
            name: _addresses[i].name,
            phone: _addresses[i].phone,
            addressLine1: _addresses[i].addressLine1,
            addressLine2: _addresses[i].addressLine2,
            city: _addresses[i].city,
            state: _addresses[i].state,
            pincode: _addresses[i].pincode,
            country: _addresses[i].country,
            type: _addresses[i].type,
            isDefault: false,
          );
        }
      }
    }

    _addresses.add(address);
    _notifyListeners();
  }

  void updateAddress(DeliveryAddress updatedAddress) {
    final index = _addresses.indexWhere((addr) => addr.id == updatedAddress.id);
    if (index != -1) {
      // If this is set as default, remove default from others
      if (updatedAddress.isDefault) {
        for (int i = 0; i < _addresses.length; i++) {
          if (i != index && _addresses[i].isDefault) {
            _addresses[i] = DeliveryAddress(
              id: _addresses[i].id,
              name: _addresses[i].name,
              phone: _addresses[i].phone,
              addressLine1: _addresses[i].addressLine1,
              addressLine2: _addresses[i].addressLine2,
              city: _addresses[i].city,
              state: _addresses[i].state,
              pincode: _addresses[i].pincode,
              country: _addresses[i].country,
              type: _addresses[i].type,
              isDefault: false,
            );
          }
        }
      }

      _addresses[index] = updatedAddress;
      _notifyListeners();
    }
  }

  void deleteAddress(String addressId) {
    _addresses.removeWhere((addr) => addr.id == addressId);
    
    // If we deleted the default address and there are other addresses, make the first one default
    if (!_addresses.any((addr) => addr.isDefault) && _addresses.isNotEmpty) {
      final firstAddress = _addresses.first;
      _addresses[0] = DeliveryAddress(
        id: firstAddress.id,
        name: firstAddress.name,
        phone: firstAddress.phone,
        addressLine1: firstAddress.addressLine1,
        addressLine2: firstAddress.addressLine2,
        city: firstAddress.city,
        state: firstAddress.state,
        pincode: firstAddress.pincode,
        country: firstAddress.country,
        type: firstAddress.type,
        isDefault: true,
      );
    }
    
    _notifyListeners();
  }

  void setDefaultAddress(String addressId) {
    for (int i = 0; i < _addresses.length; i++) {
      final address = _addresses[i];
      _addresses[i] = DeliveryAddress(
        id: address.id,
        name: address.name,
        phone: address.phone,
        addressLine1: address.addressLine1,
        addressLine2: address.addressLine2,
        city: address.city,
        state: address.state,
        pincode: address.pincode,
        country: address.country,
        type: address.type,
        isDefault: address.id == addressId,
      );
    }
    _notifyListeners();
  }

  DeliveryAddress? getAddressById(String addressId) {
    try {
      return _addresses.firstWhere((addr) => addr.id == addressId);
    } catch (e) {
      return null;
    }
  }

  void _notifyListeners() {
    _addressController.add(List.unmodifiable(_addresses));
  }

  void dispose() {
    _addressController.close();
  }
}