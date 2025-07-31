class Product {
  final String id;
  final String name;
  final String price;
  final String originalPrice;
  final double rating;
  final List<String> imageUrls;
  final String description;
  final String categoryId;
  final String brand;
  final List<String> colors;
  final List<String> sizes;
  final bool inStock;
  final int stockQuantity;
  final List<String> features;
  final Map<String, dynamic> specifications;
  final double discount;
  final bool isFeatured;
  final bool isTrending;
  final bool isNewArrival;
  final List<ProductReview> reviews;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.originalPrice,
    required this.rating,
    required this.imageUrls,
    required this.description,
    required this.categoryId,
    this.brand = '',
    this.colors = const [],
    this.sizes = const [],
    this.inStock = true,
    this.stockQuantity = 10,
    this.features = const [],
    this.specifications = const {},
    this.discount = 0.0,
    this.isFeatured = false,
    this.isTrending = false,
    this.isNewArrival = false,
    this.reviews = const [],
  });

  double get numericPrice => double.tryParse(price.replaceAll(RegExp(r'[^\d.]'), '')) ?? 0.0;
  double get numericOriginalPrice => double.tryParse(originalPrice.replaceAll(RegExp(r'[^\d.]'), '')) ?? 0.0;
  double get discountPercentage => ((numericOriginalPrice - numericPrice) / numericOriginalPrice * 100);

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      price: json['price'] ?? '',
      originalPrice: json['originalPrice'] ?? '',
      rating: (json['rating'] ?? 0.0).toDouble(),
      imageUrls: List<String>.from(json['imageUrls'] ?? []),
      description: json['description'] ?? '',
      categoryId: json['categoryId'] ?? '',
      brand: json['brand'] ?? '',
      colors: List<String>.from(json['colors'] ?? []),
      sizes: List<String>.from(json['sizes'] ?? []),
      inStock: json['inStock'] ?? true,
      stockQuantity: json['stockQuantity'] ?? 10,
      features: List<String>.from(json['features'] ?? []),
      specifications: Map<String, dynamic>.from(json['specifications'] ?? {}),
      discount: (json['discount'] ?? 0.0).toDouble(),
      isFeatured: json['isFeatured'] ?? false,
      isTrending: json['isTrending'] ?? false,
      isNewArrival: json['isNewArrival'] ?? false,
      reviews: (json['reviews'] as List<dynamic>?)
          ?.map((review) => ProductReview.fromJson(review))
          .toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'originalPrice': originalPrice,
      'rating': rating,
      'imageUrls': imageUrls,
      'description': description,
      'categoryId': categoryId,
      'brand': brand,
      'colors': colors,
      'sizes': sizes,
      'inStock': inStock,
      'stockQuantity': stockQuantity,
      'features': features,
      'specifications': specifications,
      'discount': discount,
      'isFeatured': isFeatured,
      'isTrending': isTrending,
      'isNewArrival': isNewArrival,
      'reviews': reviews.map((review) => review.toJson()).toList(),
    };
  }
}

class ProductReview {
  final String id;
  final String userName;
  final double rating;
  final String comment;
  final DateTime date;
  final List<String> images;

  ProductReview({
    required this.id,
    required this.userName,
    required this.rating,
    required this.comment,
    required this.date,
    this.images = const [],
  });

  factory ProductReview.fromJson(Map<String, dynamic> json) {
    return ProductReview(
      id: json['id'] ?? '',
      userName: json['userName'] ?? '',
      rating: (json['rating'] ?? 0.0).toDouble(),
      comment: json['comment'] ?? '',
      date: DateTime.parse(json['date'] ?? DateTime.now().toIso8601String()),
      images: List<String>.from(json['images'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userName': userName,
      'rating': rating,
      'comment': comment,
      'date': date.toIso8601String(),
      'images': images,
    };
  }
}

class CartItem {
  final String id;
  final Product product;
  int quantity;
  final String selectedColor;
  final String selectedSize;
  final DateTime addedAt;

  CartItem({
    required this.id,
    required this.product,
    required this.quantity,
    this.selectedColor = '',
    this.selectedSize = '',
    DateTime? addedAt,
  }) : addedAt = addedAt ?? DateTime.now();

  double get totalPrice => product.numericPrice * quantity;
  double get totalOriginalPrice => product.numericOriginalPrice * quantity;
  double get totalSavings => totalOriginalPrice - totalPrice;

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'] ?? '',
      product: Product.fromJson(json['product'] ?? {}),
      quantity: json['quantity'] ?? 1,
      selectedColor: json['selectedColor'] ?? '',
      selectedSize: json['selectedSize'] ?? '',
      addedAt: DateTime.parse(json['addedAt'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product': product.toJson(),
      'quantity': quantity,
      'selectedColor': selectedColor,
      'selectedSize': selectedSize,
      'addedAt': addedAt.toIso8601String(),
    };
  }
}
