import 'package:flutter/material.dart';

class Category {
  final String id;
  final String title;
  final String? description;
  final String? icon;
  final IconData? iconData;
  final String? imageUrl;
  final Color? color;
  final List<Category> children;
  final Map<String, dynamic>? metadata;
  final bool isActive;
  final int sortOrder;
  final String? seoSlug;
  final List<String>? aliases;
  final Map<String, dynamic>? attributes;

  Category({
    required this.id,
    required this.title,
    this.description,
    this.icon,
    this.iconData,
    this.imageUrl,
    this.color,
    this.children = const [],
    this.metadata,
    this.isActive = true,
    this.sortOrder = 0,
    this.seoSlug,
    this.aliases,
    this.attributes,
  });

  // Helper method to get display icon
  IconData get displayIcon {
    if (iconData != null) return iconData!;
    
    // Default icons based on category name
    switch (title.toLowerCase()) {
      case 'electronics':
      case 'electronics & technology':
        return Icons.devices;
      case 'fashion':
      case 'fashion & apparel':
        return Icons.checkroom;
      case 'home':
      case 'home & garden':
      case 'home, garden & diy':
        return Icons.home;
      case 'beauty':
      case 'health, beauty & personal care':
        return Icons.face_retouching_natural;
      case 'sports':
      case 'sports, outdoors & hobbies':
        return Icons.sports_soccer;
      case 'books':
      case 'books, media & entertainment':
        return Icons.menu_book;
      case 'food':
      case 'food, beverages & grocery':
        return Icons.restaurant;
      case 'automotive':
      case 'automotive & industrial':
        return Icons.directions_car;
      case 'toys':
      case 'toys, kids & baby':
        return Icons.toys;
      case 'pets':
      case 'pet supplies':
        return Icons.pets;
      case 'office':
      case 'office, business & school supplies':
        return Icons.business;
      case 'art':
      case 'art, collectibles & craft supplies':
        return Icons.palette;
      case 'services':
      case 'services & digital goods':
        return Icons.computer;
      default:
        return Icons.category;
    }
  }

  // Helper method to get display color
  Color get displayColor {
    if (color != null) return color!;
    
    // Default colors based on category
    switch (title.toLowerCase()) {
      case 'electronics':
      case 'electronics & technology':
        return const Color(0xFF6C5CE7);
      case 'fashion':
      case 'fashion & apparel':
        return const Color(0xFFE84393);
      case 'home':
      case 'home & garden':
      case 'home, garden & diy':
        return const Color(0xFF00B894);
      case 'beauty':
      case 'health, beauty & personal care':
        return const Color(0xFFFF7675);
      case 'sports':
      case 'sports, outdoors & hobbies':
        return const Color(0xFFFDCB6E);
      case 'books':
      case 'books, media & entertainment':
        return const Color(0xFF74B9FF);
      case 'food':
      case 'food, beverages & grocery':
        return const Color(0xFFA29BFE);
      case 'automotive':
      case 'automotive & industrial':
        return const Color(0xFF636E72);
      case 'toys':
      case 'toys, kids & baby':
        return const Color(0xFFFD79A8);
      case 'pets':
      case 'pet supplies':
        return const Color(0xFFFAB1A0);
      case 'office':
      case 'office, business & school supplies':
        return const Color(0xFF55A3FF);
      case 'art':
      case 'art, collectibles & craft supplies':
        return const Color(0xFFE17055);
      case 'services':
      case 'services & digital goods':
        return const Color(0xFF00CEC9);
      default:
        return const Color(0xFF6C5CE7);
    }
  }

  // Helper method to get all subcategories recursively
  List<Category> getAllSubcategories() {
    List<Category> allSubcategories = [];
    for (var child in children) {
      allSubcategories.add(child);
      allSubcategories.addAll(child.getAllSubcategories());
    }
    return allSubcategories;
  }

  // Helper method to find category by ID
  Category? findById(String id) {
    if (this.id == id) return this;
    for (var child in children) {
      final found = child.findById(id);
      if (found != null) return found;
    }
    return null;
  }

  // Helper method to get breadcrumb path
  List<Category> getBreadcrumbPath(String targetId) {
    if (id == targetId) return [this];
    for (var child in children) {
      final path = child.getBreadcrumbPath(targetId);
      if (path.isNotEmpty) return [this, ...path];
    }
    return [];
  }

  // Helper method to check if category has children
  bool get hasChildren => children.isNotEmpty;

  // Helper method to get total product count (recursive)
  int get totalProductCount {
    int count = metadata?['productCount'] ?? 0;
    for (var child in children) {
      count += child.totalProductCount;
    }
    return count;
  }

  // Helper method to get trending status
  bool get isTrending {
    return metadata?['isTrending'] ?? false;
  }

  // Helper method to get featured status
  bool get isFeatured {
    return metadata?['isFeatured'] ?? false;
  }

  // Copy with method for immutability
  Category copyWith({
    String? id,
    String? title,
    String? description,
    String? icon,
    IconData? iconData,
    String? imageUrl,
    Color? color,
    List<Category>? children,
    Map<String, dynamic>? metadata,
    bool? isActive,
    int? sortOrder,
    String? seoSlug,
    List<String>? aliases,
    Map<String, dynamic>? attributes,
  }) {
    return Category(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      icon: icon ?? this.icon,
      iconData: iconData ?? this.iconData,
      imageUrl: imageUrl ?? this.imageUrl,
      color: color ?? this.color,
      children: children ?? this.children,
      metadata: metadata ?? this.metadata,
      isActive: isActive ?? this.isActive,
      sortOrder: sortOrder ?? this.sortOrder,
      seoSlug: seoSlug ?? this.seoSlug,
      aliases: aliases ?? this.aliases,
      attributes: attributes ?? this.attributes,
    );
  }

  // JSON serialization
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'icon': icon,
      'imageUrl': imageUrl,
      'color': color?.value,
      'children': children.map((c) => c.toJson()).toList(),
      'metadata': metadata,
      'isActive': isActive,
      'sortOrder': sortOrder,
      'seoSlug': seoSlug,
      'aliases': aliases,
      'attributes': attributes,
    };
  }

  // JSON deserialization
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      icon: json['icon'],
      imageUrl: json['imageUrl'],
      color: json['color'] != null ? Color(json['color']) : null,
      children: (json['children'] as List?)
          ?.map((c) => Category.fromJson(c))
          .toList() ?? [],
      metadata: json['metadata'],
      isActive: json['isActive'] ?? true,
      sortOrder: json['sortOrder'] ?? 0,
      seoSlug: json['seoSlug'],
      aliases: json['aliases'] != null 
          ? List<String>.from(json['aliases'])
          : null,
      attributes: json['attributes'],
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Category && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'Category(id: $id, title: $title, children: ${children.length})';
  }
}

// Category filter model for advanced filtering
class CategoryFilter {
  final String? searchQuery;
  final List<String>? categoryIds;
  final bool? isTrending;
  final bool? isFeatured;
  final bool? isActive;
  final int? minProductCount;
  final int? maxProductCount;
  final String? sortBy;
  final bool? sortAscending;

  CategoryFilter({
    this.searchQuery,
    this.categoryIds,
    this.isTrending,
    this.isFeatured,
    this.isActive,
    this.minProductCount,
    this.maxProductCount,
    this.sortBy,
    this.sortAscending,
  });

  CategoryFilter copyWith({
    String? searchQuery,
    List<String>? categoryIds,
    bool? isTrending,
    bool? isFeatured,
    bool? isActive,
    int? minProductCount,
    int? maxProductCount,
    String? sortBy,
    bool? sortAscending,
  }) {
    return CategoryFilter(
      searchQuery: searchQuery ?? this.searchQuery,
      categoryIds: categoryIds ?? this.categoryIds,
      isTrending: isTrending ?? this.isTrending,
      isFeatured: isFeatured ?? this.isFeatured,
      isActive: isActive ?? this.isActive,
      minProductCount: minProductCount ?? this.minProductCount,
      maxProductCount: maxProductCount ?? this.maxProductCount,
      sortBy: sortBy ?? this.sortBy,
      sortAscending: sortAscending ?? this.sortAscending,
    );
  }
}

// Category navigation state for breadcrumbs
class CategoryNavigationState {
  final List<Category> breadcrumbPath;
  final Category currentCategory;
  final List<Category> siblings;
  final Category? parent;

  CategoryNavigationState({
    required this.breadcrumbPath,
    required this.currentCategory,
    required this.siblings,
    this.parent,
  });

  // Helper to get breadcrumb titles
  List<String> get breadcrumbTitles {
    return breadcrumbPath.map((c) => c.title).toList();
  }

  // Helper to check if we can go back
  bool get canGoBack => breadcrumbPath.length > 1;

  // Helper to get previous category
  Category? get previousCategory {
    if (breadcrumbPath.length > 1) {
      return breadcrumbPath[breadcrumbPath.length - 2];
    }
    return null;
  }
} 