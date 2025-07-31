class Order {
  final String id;
  final String userId;
  final List<OrderItem> items;
  final double subtotal;
  final double shipping;
  final double tax;
  final double total;
  final OrderStatus status;
  final PaymentMethod paymentMethod;
  final DeliveryAddress deliveryAddress;
  final DateTime orderDate;
  final DateTime? estimatedDelivery;
  final DateTime? actualDelivery;
  final String? trackingNumber;
  final List<OrderStatusUpdate> statusUpdates;
  final String? notes;

  Order({
    required this.id,
    required this.userId,
    required this.items,
    required this.subtotal,
    required this.shipping,
    required this.tax,
    required this.total,
    required this.status,
    required this.paymentMethod,
    required this.deliveryAddress,
    required this.orderDate,
    this.estimatedDelivery,
    this.actualDelivery,
    this.trackingNumber,
    this.statusUpdates = const [],
    this.notes,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'] ?? '',
      userId: json['userId'] ?? '',
      items: (json['items'] as List<dynamic>?)
          ?.map((item) => OrderItem.fromJson(item))
          .toList() ?? [],
      subtotal: (json['subtotal'] ?? 0.0).toDouble(),
      shipping: (json['shipping'] ?? 0.0).toDouble(),
      tax: (json['tax'] ?? 0.0).toDouble(),
      total: (json['total'] ?? 0.0).toDouble(),
      status: OrderStatus.values.firstWhere(
        (e) => e.toString() == 'OrderStatus.${json['status']}',
        orElse: () => OrderStatus.pending,
      ),
      paymentMethod: PaymentMethod.fromJson(json['paymentMethod'] ?? {}),
      deliveryAddress: DeliveryAddress.fromJson(json['deliveryAddress'] ?? {}),
      orderDate: DateTime.parse(json['orderDate'] ?? DateTime.now().toIso8601String()),
      estimatedDelivery: json['estimatedDelivery'] != null 
          ? DateTime.parse(json['estimatedDelivery']) 
          : null,
      actualDelivery: json['actualDelivery'] != null 
          ? DateTime.parse(json['actualDelivery']) 
          : null,
      trackingNumber: json['trackingNumber'],
      statusUpdates: (json['statusUpdates'] as List<dynamic>?)
          ?.map((update) => OrderStatusUpdate.fromJson(update))
          .toList() ?? [],
      notes: json['notes'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'items': items.map((item) => item.toJson()).toList(),
      'subtotal': subtotal,
      'shipping': shipping,
      'tax': tax,
      'total': total,
      'status': status.toString().split('.').last,
      'paymentMethod': paymentMethod.toJson(),
      'deliveryAddress': deliveryAddress.toJson(),
      'orderDate': orderDate.toIso8601String(),
      'estimatedDelivery': estimatedDelivery?.toIso8601String(),
      'actualDelivery': actualDelivery?.toIso8601String(),
      'trackingNumber': trackingNumber,
      'statusUpdates': statusUpdates.map((update) => update.toJson()).toList(),
      'notes': notes,
    };
  }
}

class OrderItem {
  final String id;
  final String productId;
  final String productName;
  final String productImage;
  final double price;
  final int quantity;
  final String selectedColor;
  final String selectedSize;

  OrderItem({
    required this.id,
    required this.productId,
    required this.productName,
    required this.productImage,
    required this.price,
    required this.quantity,
    this.selectedColor = '',
    this.selectedSize = '',
  });

  double get totalPrice => price * quantity;

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      id: json['id'] ?? '',
      productId: json['productId'] ?? '',
      productName: json['productName'] ?? '',
      productImage: json['productImage'] ?? '',
      price: (json['price'] ?? 0.0).toDouble(),
      quantity: json['quantity'] ?? 1,
      selectedColor: json['selectedColor'] ?? '',
      selectedSize: json['selectedSize'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productId': productId,
      'productName': productName,
      'productImage': productImage,
      'price': price,
      'quantity': quantity,
      'selectedColor': selectedColor,
      'selectedSize': selectedSize,
    };
  }
}

enum OrderStatus {
  pending,
  confirmed,
  processing,
  shipped,
  outForDelivery,
  delivered,
  cancelled,
  returned,
  refunded
}

class OrderStatusUpdate {
  final OrderStatus status;
  final DateTime timestamp;
  final String description;
  final String? location;

  OrderStatusUpdate({
    required this.status,
    required this.timestamp,
    required this.description,
    this.location,
  });

  factory OrderStatusUpdate.fromJson(Map<String, dynamic> json) {
    return OrderStatusUpdate(
      status: OrderStatus.values.firstWhere(
        (e) => e.toString() == 'OrderStatus.${json['status']}',
        orElse: () => OrderStatus.pending,
      ),
      timestamp: DateTime.parse(json['timestamp'] ?? DateTime.now().toIso8601String()),
      description: json['description'] ?? '',
      location: json['location'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status.toString().split('.').last,
      'timestamp': timestamp.toIso8601String(),
      'description': description,
      'location': location,
    };
  }
}

class PaymentMethod {
  final String id;
  final PaymentType type;
  final String displayName;
  final String? cardNumber;
  final String? expiryDate;
  final String? holderName;
  final String? upiId;
  final bool isDefault;

  PaymentMethod({
    required this.id,
    required this.type,
    required this.displayName,
    this.cardNumber,
    this.expiryDate,
    this.holderName,
    this.upiId,
    this.isDefault = false,
  });

  factory PaymentMethod.fromJson(Map<String, dynamic> json) {
    return PaymentMethod(
      id: json['id'] ?? '',
      type: PaymentType.values.firstWhere(
        (e) => e.toString() == 'PaymentType.${json['type']}',
        orElse: () => PaymentType.card,
      ),
      displayName: json['displayName'] ?? '',
      cardNumber: json['cardNumber'],
      expiryDate: json['expiryDate'],
      holderName: json['holderName'],
      upiId: json['upiId'],
      isDefault: json['isDefault'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type.toString().split('.').last,
      'displayName': displayName,
      'cardNumber': cardNumber,
      'expiryDate': expiryDate,
      'holderName': holderName,
      'upiId': upiId,
      'isDefault': isDefault,
    };
  }
}

enum PaymentType {
  card,
  upi,
  netBanking,
  wallet,
  cod
}

class DeliveryAddress {
  final String id;
  final String name;
  final String phone;
  final String addressLine1;
  final String addressLine2;
  final String city;
  final String state;
  final String pincode;
  final String country;
  final AddressType type;
  final bool isDefault;

  DeliveryAddress({
    required this.id,
    required this.name,
    required this.phone,
    required this.addressLine1,
    this.addressLine2 = '',
    required this.city,
    required this.state,
    required this.pincode,
    this.country = 'India',
    required this.type,
    this.isDefault = false,
  });

  String get fullAddress {
    final parts = [
      addressLine1,
      if (addressLine2.isNotEmpty) addressLine2,
      city,
      state,
      pincode,
      country,
    ];
    return parts.join(', ');
  }

  factory DeliveryAddress.fromJson(Map<String, dynamic> json) {
    return DeliveryAddress(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      addressLine1: json['addressLine1'] ?? '',
      addressLine2: json['addressLine2'] ?? '',
      city: json['city'] ?? '',
      state: json['state'] ?? '',
      pincode: json['pincode'] ?? '',
      country: json['country'] ?? 'India',
      type: AddressType.values.firstWhere(
        (e) => e.toString() == 'AddressType.${json['type']}',
        orElse: () => AddressType.home,
      ),
      isDefault: json['isDefault'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'addressLine1': addressLine1,
      'addressLine2': addressLine2,
      'city': city,
      'state': state,
      'pincode': pincode,
      'country': country,
      'type': type.toString().split('.').last,
      'isDefault': isDefault,
    };
  }
}

enum AddressType {
  home,
  work,
  other
}