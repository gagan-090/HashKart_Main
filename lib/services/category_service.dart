import 'dart:convert';
import 'package:flutter/material.dart';
import '../models/category_model.dart';
import '../data/category_data.dart';

class CategoryService {
  static final CategoryService _instance = CategoryService._internal();
  factory CategoryService() => _instance;
  CategoryService._internal();

  // Cache for category data
  List<Category>? _cachedCategories;
  Map<String, Category>? _categoryMap;
  List<Category>? _trendingCategories;
  List<Category>? _featuredCategories;

  // Navigation state
  CategoryNavigationState? _currentNavigationState;

  // Get all categories with caching
  List<Category> getAllCategories() {
    if (_cachedCategories == null) {
      _cachedCategories = globalCategoryTree;
      _buildCategoryMap();
    }
    return _cachedCategories!;
  }

  // Build category map for quick lookup
  void _buildCategoryMap() {
    _categoryMap = {};
    for (var category in _cachedCategories!) {
      _addToMap(category);
    }
  }

  void _addToMap(Category category) {
    _categoryMap![category.id] = category;
    for (var child in category.children) {
      _addToMap(child);
    }
  }

  // Find category by ID
  Category? findCategoryById(String id) {
    if (_categoryMap == null) {
      _buildCategoryMap();
    }
    return _categoryMap![id];
  }

  // Get trending categories
  List<Category> getTrendingCategories() {
    if (_trendingCategories == null) {
      _trendingCategories = getTrendingCategories();
    }
    return _trendingCategories!;
  }

  // Get featured categories
  List<Category> getFeaturedCategories() {
    if (_featuredCategories == null) {
      _featuredCategories = getFeaturedCategories();
    }
    return _featuredCategories!;
  }

  // Search categories
  List<Category> searchCategories(String query) {
    if (query.isEmpty) return [];
    
    List<Category> results = [];
    query = query.toLowerCase();
    
    for (var category in getAllCategories()) {
      if (_matchesSearch(category, query)) {
        results.add(category);
      }
      
      for (var child in category.children) {
        if (_matchesSearch(child, query)) {
          results.add(child);
        }
      }
    }
    
    return results;
  }

  bool _matchesSearch(Category category, String query) {
    return category.title.toLowerCase().contains(query) ||
           category.description?.toLowerCase().contains(query) == true ||
           category.aliases?.any((alias) => alias.toLowerCase().contains(query)) == true;
  }

  // Get breadcrumb navigation
  CategoryNavigationState getNavigationState(String categoryId) {
    final category = findCategoryById(categoryId);
    if (category == null) {
      throw Exception('Category not found: $categoryId');
    }

    final breadcrumbPath = _getBreadcrumbPath(categoryId);
    final parent = breadcrumbPath.length > 1 ? breadcrumbPath[breadcrumbPath.length - 2] : null;
    final siblings = parent?.children ?? getAllCategories();

    return CategoryNavigationState(
      breadcrumbPath: breadcrumbPath,
      currentCategory: category,
      siblings: siblings,
      parent: parent,
    );
  }

  List<Category> _getBreadcrumbPath(String categoryId) {
    for (var rootCategory in getAllCategories()) {
      final path = rootCategory.getBreadcrumbPath(categoryId);
      if (path.isNotEmpty) {
        return path;
      }
    }
    return [];
  }

  // Get subcategories for a category
  List<Category> getSubcategories(String categoryId) {
    final category = findCategoryById(categoryId);
    return category?.children ?? [];
  }

  // Get all subcategories recursively
  List<Category> getAllSubcategories(String categoryId) {
    final category = findCategoryById(categoryId);
    return category?.getAllSubcategories() ?? [];
  }

  // Filter categories
  List<Category> filterCategories(CategoryFilter filter) {
    List<Category> categories = getAllCategories();
    
    // Apply search filter
    if (filter.searchQuery != null && filter.searchQuery!.isNotEmpty) {
      categories = searchCategories(filter.searchQuery!);
    }
    
    // Apply trending filter
    if (filter.isTrending == true) {
      categories = categories.where((c) => c.isTrending).toList();
    }
    
    // Apply featured filter
    if (filter.isFeatured == true) {
      categories = categories.where((c) => c.isFeatured).toList();
    }
    
    // Apply active filter
    if (filter.isActive == true) {
      categories = categories.where((c) => c.isActive).toList();
    }
    
    // Apply product count filters
    if (filter.minProductCount != null) {
      categories = categories.where((c) => c.totalProductCount >= filter.minProductCount!).toList();
    }
    
    if (filter.maxProductCount != null) {
      categories = categories.where((c) => c.totalProductCount <= filter.maxProductCount!).toList();
    }
    
    // Apply sorting
    if (filter.sortBy != null) {
      categories = _sortCategories(categories, filter.sortBy!, filter.sortAscending ?? true);
    }
    
    return categories;
  }

  List<Category> _sortCategories(List<Category> categories, String sortBy, bool ascending) {
    switch (sortBy) {
      case 'title':
        categories.sort((a, b) => ascending 
          ? a.title.compareTo(b.title)
          : b.title.compareTo(a.title));
        break;
      case 'productCount':
        categories.sort((a, b) => ascending
          ? a.totalProductCount.compareTo(b.totalProductCount)
          : b.totalProductCount.compareTo(a.totalProductCount));
        break;
      case 'sortOrder':
        categories.sort((a, b) => ascending
          ? a.sortOrder.compareTo(b.sortOrder)
          : b.sortOrder.compareTo(a.sortOrder));
        break;
      default:
        // Default sort by title
        categories.sort((a, b) => a.title.compareTo(b.title));
    }
    return categories;
  }

  // Get category suggestions for search
  List<Category> getCategorySuggestions(String query, {int limit = 5}) {
    final results = searchCategories(query);
    return results.take(limit).toList();
  }

  // Get related categories
  List<Category> getRelatedCategories(String categoryId) {
    final category = findCategoryById(categoryId);
    if (category == null) return [];
    
    final parent = _getParentCategory(categoryId);
    if (parent != null) {
      return parent.children.where((c) => c.id != categoryId).toList();
    }
    
    return [];
  }

  Category? _getParentCategory(String categoryId) {
    for (var rootCategory in getAllCategories()) {
      for (var child in rootCategory.children) {
        if (child.children.any((c) => c.id == categoryId)) {
          return child;
        }
      }
    }
    return null;
  }

  // Get category statistics
  Map<String, dynamic> getCategoryStats() {
    final categories = getAllCategories();
    int totalCategories = 0;
    int totalProducts = 0;
    int trendingCategories = 0;
    int featuredCategories = 0;
    
    for (var category in categories) {
      totalCategories += 1 + category.getAllSubcategories().length;
      totalProducts += category.totalProductCount;
      if (category.isTrending) trendingCategories++;
      if (category.isFeatured) featuredCategories++;
    }
    
    return {
      'totalCategories': totalCategories,
      'totalProducts': totalProducts,
      'trendingCategories': trendingCategories,
      'featuredCategories': featuredCategories,
    };
  }

  // Clear cache
  void clearCache() {
    _cachedCategories = null;
    _categoryMap = null;
    _trendingCategories = null;
    _featuredCategories = null;
  }

  // Export categories to JSON
  String exportCategoriesToJson() {
    final categories = getAllCategories();
    final jsonList = categories.map((c) => c.toJson()).toList();
    return jsonEncode(jsonList);
  }

  // Import categories from JSON
  void importCategoriesFromJson(String jsonString) {
    try {
      final jsonList = jsonDecode(jsonString) as List;
      final categories = jsonList.map((json) => Category.fromJson(json)).toList();
      _cachedCategories = categories;
      _buildCategoryMap();
    } catch (e) {
      throw Exception('Failed to import categories: $e');
    }
  }

  // Get category path as string
  String getCategoryPath(String categoryId) {
    final navigationState = getNavigationState(categoryId);
    return navigationState.breadcrumbTitles.join(' > ');
  }

  // Check if category is a leaf (no children)
  bool isLeafCategory(String categoryId) {
    final category = findCategoryById(categoryId);
    return category?.children.isEmpty ?? true;
  }

  // Get category depth level
  int getCategoryDepth(String categoryId) {
    final navigationState = getNavigationState(categoryId);
    return navigationState.breadcrumbPath.length;
  }

  // Get categories by level (0 = root, 1 = first level, etc.)
  List<Category> getCategoriesByLevel(int level) {
    if (level == 0) return getAllCategories();
    
    List<Category> result = [];
    for (var category in getAllCategories()) {
      result.addAll(_getCategoriesAtLevel(category, level, 0));
    }
    return result;
  }

  List<Category> _getCategoriesAtLevel(Category category, int targetLevel, int currentLevel) {
    if (currentLevel == targetLevel) {
      return [category];
    }
    
    List<Category> result = [];
    for (var child in category.children) {
      result.addAll(_getCategoriesAtLevel(child, targetLevel, currentLevel + 1));
    }
    return result;
  }
} 