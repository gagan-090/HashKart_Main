import 'package:flutter/material.dart';
import '../models/category_model.dart';

// Global category tree for HashKart e-commerce platform
final List<Category> globalCategoryTree = [
  Category(
    id: 'electronics',
    title: 'Electronics & Technology',
    description: 'Latest gadgets, computers, and smart devices',
    iconData: Icons.devices,
    imageUrl: 'https://images.unsplash.com/photo-1496181133206-80ce9b88a853?w=300',
    metadata: {
      'productCount': 15420,
      'isTrending': true,
      'isFeatured': true,
    },
    children: [
      Category(
        id: 'computers-accessories',
        title: 'Computers & Accessories',
        metadata: {'productCount': 3240, 'isTrending': true},
        children: [
          Category(id: 'laptops', title: 'Laptops', metadata: {'productCount': 890}),
          Category(id: 'desktops', title: 'Desktops', metadata: {'productCount': 456}),
          Category(id: 'monitors', title: 'Monitors', metadata: {'productCount': 234}),
          Category(id: 'keyboards', title: 'Keyboards', metadata: {'productCount': 189}),
          Category(id: 'mice', title: 'Mice & Pointing Devices', metadata: {'productCount': 156}),
          Category(id: 'storage', title: 'Storage Devices', metadata: {'productCount': 445}),
          Category(id: 'networking', title: 'Networking', metadata: {'productCount': 67}),
        ],
      ),
      Category(
        id: 'smartphones-wearables',
        title: 'Smartphones & Wearables',
        metadata: {'productCount': 5670, 'isTrending': true},
        children: [
          Category(id: 'smartphones', title: 'Smartphones', metadata: {'productCount': 1234}),
          Category(id: 'smartwatches', title: 'Smartwatches', metadata: {'productCount': 567}),
          Category(id: 'fitness-trackers', title: 'Fitness Trackers', metadata: {'productCount': 234}),
          Category(id: 'mobile-accessories', title: 'Mobile Accessories', metadata: {'productCount': 890}),
          Category(id: 'cases-covers', title: 'Cases & Covers', metadata: {'productCount': 1234}),
          Category(id: 'screen-protectors', title: 'Screen Protectors', metadata: {'productCount': 567}),
        ],
      ),
      Category(
        id: 'audio-video',
        title: 'Audio & Video',
        metadata: {'productCount': 2340},
        children: [
          Category(id: 'headphones', title: 'Headphones', metadata: {'productCount': 567}),
          Category(id: 'speakers', title: 'Speakers', metadata: {'productCount': 234}),
          Category(id: 'televisions', title: 'Televisions', metadata: {'productCount': 123}),
          Category(id: 'home-theater', title: 'Home Theater', metadata: {'productCount': 89}),
          Category(id: 'microphones', title: 'Microphones', metadata: {'productCount': 156}),
        ],
      ),
      Category(
        id: 'gaming',
        title: 'Gaming',
        metadata: {'productCount': 1890, 'isTrending': true},
        children: [
          Category(id: 'gaming-consoles', title: 'Gaming Consoles', metadata: {'productCount': 45}),
          Category(id: 'gaming-laptops', title: 'Gaming Laptops', metadata: {'productCount': 123}),
          Category(id: 'gaming-accessories', title: 'Gaming Accessories', metadata: {'productCount': 567}),
          Category(id: 'gaming-chairs', title: 'Gaming Chairs', metadata: {'productCount': 89}),
          Category(id: 'vr-ar', title: 'VR & AR', metadata: {'productCount': 67}),
        ],
      ),
      Category(
        id: 'cameras-photography',
        title: 'Cameras & Photography',
        metadata: {'productCount': 890},
        children: [
          Category(id: 'digital-cameras', title: 'Digital Cameras', metadata: {'productCount': 234}),
          Category(id: 'lenses', title: 'Lenses', metadata: {'productCount': 156}),
          Category(id: 'tripods', title: 'Tripods & Supports', metadata: {'productCount': 89}),
          Category(id: 'lighting', title: 'Lighting Equipment', metadata: {'productCount': 123}),
          Category(id: 'drones', title: 'Drones', metadata: {'productCount': 78}),
        ],
      ),
    ],
  ),
  
  Category(
    id: 'fashion',
    title: 'Fashion & Apparel',
    description: 'Trendy clothing, footwear, and accessories',
    iconData: Icons.checkroom,
    imageUrl: 'https://images.unsplash.com/photo-1445205170230-053b83016050?w=300',
    metadata: {
      'productCount': 23450,
      'isTrending': true,
      'isFeatured': true,
    },
    children: [
      Category(
        id: 'mens-fashion',
        title: "Men's Fashion",
        metadata: {'productCount': 5670},
        children: [
          Category(id: 'mens-clothing', title: "Men's Clothing", metadata: {'productCount': 2340}),
          Category(id: 'mens-shoes', title: "Men's Shoes", metadata: {'productCount': 890}),
          Category(id: 'mens-accessories', title: "Men's Accessories", metadata: {'productCount': 1234}),
          Category(id: 'mens-watches', title: "Men's Watches", metadata: {'productCount': 567}),
          Category(id: 'mens-bags', title: "Men's Bags", metadata: {'productCount': 234}),
        ],
      ),
      Category(
        id: 'womens-fashion',
        title: "Women's Fashion",
        metadata: {'productCount': 8900, 'isTrending': true},
        children: [
          Category(id: 'womens-clothing', title: "Women's Clothing", metadata: {'productCount': 4560}),
          Category(id: 'womens-shoes', title: "Women's Shoes", metadata: {'productCount': 1234}),
          Category(id: 'womens-accessories', title: "Women's Accessories", metadata: {'productCount': 1890}),
          Category(id: 'womens-jewelry', title: "Women's Jewelry", metadata: {'productCount': 890}),
          Category(id: 'womens-bags', title: "Women's Bags", metadata: {'productCount': 567}),
        ],
      ),
      Category(
        id: 'kids-fashion',
        title: "Kids' Fashion",
        metadata: {'productCount': 3450},
        children: [
          Category(id: 'boys-clothing', title: "Boys' Clothing", metadata: {'productCount': 1234}),
          Category(id: 'girls-clothing', title: "Girls' Clothing", metadata: {'productCount': 1234}),
          Category(id: 'kids-shoes', title: "Kids' Shoes", metadata: {'productCount': 567}),
          Category(id: 'kids-accessories', title: "Kids' Accessories", metadata: {'productCount': 234}),
        ],
      ),
      Category(
        id: 'sports-fashion',
        title: 'Sports & Activewear',
        metadata: {'productCount': 2340},
        children: [
          Category(id: 'sports-clothing', title: 'Sports Clothing', metadata: {'productCount': 890}),
          Category(id: 'sports-shoes', title: 'Sports Shoes', metadata: {'productCount': 567}),
          Category(id: 'athletic-wear', title: 'Athletic Wear', metadata: {'productCount': 456}),
          Category(id: 'swimwear', title: 'Swimwear', metadata: {'productCount': 234}),
        ],
      ),
    ],
  ),
  
  Category(
    id: 'home-garden',
    title: 'Home, Kitchen & Bath',
    description: 'Everything for your home and garden',
    iconData: Icons.home,
    imageUrl: 'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?w=300',
    metadata: {
      'productCount': 15670,
      'isFeatured': true,
    },
    children: [
      Category(
        id: 'furniture',
        title: 'Furniture',
        metadata: {'productCount': 3450},
        children: [
          Category(id: 'vases', title: 'Vases', metadata: {'productCount': 234}),
          Category(id: 'clocks', title: 'Clocks', metadata: {'productCount': 156}),
          Category(id: 'decorative-pillows', title: 'Decorative Pillows', metadata: {'productCount': 189}),
          Category(id: 'housekeeping', title: 'Housekeeping & Organization', metadata: {'productCount': 345}),
          Category(id: 'dining', title: 'Dining', metadata: {'productCount': 267}),
          Category(id: 'glassware', title: 'Glassware', metadata: {'productCount': 123}),
          Category(id: 'kitchen-organization', title: 'Kitchen Organization', metadata: {'productCount': 234}),
          Category(id: 'bedding-sets', title: 'Bedding Sets & Collections', metadata: {'productCount': 178}),
          Category(id: 'sheets-pillowcases', title: 'Sheets & Pillowcases', metadata: {'productCount': 145}),
          Category(id: 'bath-rugs', title: 'Bath Rugs', metadata: {'productCount': 89}),
          Category(id: 'towels', title: 'Towels', metadata: {'productCount': 156}),
          Category(id: 'shelves-caddies', title: 'Shelves & Caddies', metadata: {'productCount': 134}),
          Category(id: 'cookware', title: 'Cookware', metadata: {'productCount': 267}),
          Category(id: 'coffee-tea', title: 'Coffee, Tea & Espresso', metadata: {'productCount': 189}),
          Category(id: 'bathroom-accessories', title: 'Bathroom Accessory Sets', metadata: {'productCount': 123}),
        ],
      ),
      Category(
        id: 'home-decor',
        title: 'Home Decor',
        metadata: {'productCount': 4560},
        children: [
          Category(id: 'wall-art', title: 'Wall Art', metadata: {'productCount': 890}),
          Category(id: 'cushions-pillows', title: 'Cushions & Pillows', metadata: {'productCount': 567}),
          Category(id: 'candles-fragrances', title: 'Candles & Fragrances', metadata: {'productCount': 234}),
          Category(id: 'mirrors', title: 'Mirrors', metadata: {'productCount': 123}),
          Category(id: 'clocks', title: 'Clocks', metadata: {'productCount': 89}),
        ],
      ),
      Category(
        id: 'kitchen-dining',
        title: 'Kitchen & Dining',
        metadata: {'productCount': 2340},
        children: [
          Category(id: 'cookware', title: 'Cookware', metadata: {'productCount': 567}),
          Category(id: 'dinnerware', title: 'Dinnerware', metadata: {'productCount': 234}),
          Category(id: 'kitchen-appliances', title: 'Kitchen Appliances', metadata: {'productCount': 456}),
          Category(id: 'storage-containers', title: 'Storage Containers', metadata: {'productCount': 123}),
        ],
      ),
      Category(
        id: 'garden-outdoor',
        title: 'Garden & Outdoor',
        metadata: {'productCount': 1890},
        children: [
          Category(id: 'gardening-tools', title: 'Gardening Tools', metadata: {'productCount': 234}),
          Category(id: 'plants-seeds', title: 'Plants & Seeds', metadata: {'productCount': 456}),
          Category(id: 'outdoor-lighting', title: 'Outdoor Lighting', metadata: {'productCount': 123}),
          Category(id: 'bbq-grills', title: 'BBQ & Grills', metadata: {'productCount': 89}),
        ],
      ),
    ],
  ),
  
  Category(
    id: 'beauty-health',
    title: 'Beauty & Personal Care',
    description: 'Beauty products and personal care essentials',
    iconData: Icons.face_retouching_natural,
    imageUrl: 'https://images.unsplash.com/photo-1596462502278-27bfdc403348?w=300',
    metadata: {
      'productCount': 12340,
      'isTrending': true,
    },
    children: [
      Category(
        id: 'skincare',
        title: 'Skincare',
        metadata: {'productCount': 3450, 'isTrending': true},
        children: [
          Category(id: 'cleansers', title: 'Cleansers', metadata: {'productCount': 567}),
          Category(id: 'moisturizers', title: 'Moisturizers', metadata: {'productCount': 456}),
          Category(id: 'serums', title: 'Serums', metadata: {'productCount': 234}),
          Category(id: 'sunscreen', title: 'Sunscreen', metadata: {'productCount': 123}),
          Category(id: 'masks', title: 'Face Masks', metadata: {'productCount': 89}),
        ],
      ),
      Category(
        id: 'makeup',
        title: 'Makeup',
        metadata: {'productCount': 2340},
        children: [
          Category(id: 'foundation', title: 'Foundation', metadata: {'productCount': 234}),
          Category(id: 'lipstick', title: 'Lipstick', metadata: {'productCount': 456}),
          Category(id: 'eyeshadow', title: 'Eyeshadow', metadata: {'productCount': 123}),
          Category(id: 'mascara', title: 'Mascara', metadata: {'productCount': 89}),
          Category(id: 'brushes-tools', title: 'Brushes & Tools', metadata: {'productCount': 234}),
        ],
      ),
      Category(
        id: 'haircare',
        title: 'Hair Care',
        metadata: {'productCount': 1890},
        children: [
          Category(id: 'shampoo-conditioner', title: 'Shampoo & Conditioner', metadata: {'productCount': 456}),
          Category(id: 'hair-styling', title: 'Hair Styling', metadata: {'productCount': 234}),
          Category(id: 'hair-tools', title: 'Hair Tools', metadata: {'productCount': 123}),
          Category(id: 'hair-accessories', title: 'Hair Accessories', metadata: {'productCount': 89}),
        ],
      ),
      Category(
        id: 'fragrances',
        title: 'Fragrances',
        metadata: {'productCount': 890},
        children: [
          Category(id: 'perfumes', title: 'Perfumes', metadata: {'productCount': 234}),
          Category(id: 'colognes', title: 'Colognes', metadata: {'productCount': 123}),
          Category(id: 'body-sprays', title: 'Body Sprays', metadata: {'productCount': 89}),
        ],
      ),
    ],
  ),
  
  Category(
    id: 'sports-outdoors',
    title: 'Sports, Outdoors & Hobbies',
    description: 'Sports equipment and outdoor activities',
    iconData: Icons.sports_soccer,
    imageUrl: 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=300',
    metadata: {
      'productCount': 8900,
    },
    children: [
      Category(
        id: 'fitness-equipment',
        title: 'Fitness Equipment',
        metadata: {'productCount': 2340},
        children: [
          Category(id: 'cardio-equipment', title: 'Cardio Equipment', metadata: {'productCount': 456}),
          Category(id: 'strength-training', title: 'Strength Training', metadata: {'productCount': 234}),
          Category(id: 'yoga-pilates', title: 'Yoga & Pilates', metadata: {'productCount': 123}),
          Category(id: 'fitness-accessories', title: 'Fitness Accessories', metadata: {'productCount': 89}),
        ],
      ),
      Category(
        id: 'outdoor-sports',
        title: 'Outdoor Sports',
        metadata: {'productCount': 1890},
        children: [
          Category(id: 'hiking-camping', title: 'Hiking & Camping', metadata: {'productCount': 456}),
          Category(id: 'cycling', title: 'Cycling', metadata: {'productCount': 234}),
          Category(id: 'fishing', title: 'Fishing', metadata: {'productCount': 123}),
          Category(id: 'hunting', title: 'Hunting', metadata: {'productCount': 89}),
        ],
      ),
      Category(
        id: 'team-sports',
        title: 'Team Sports',
        metadata: {'productCount': 1230},
        children: [
          Category(id: 'football-soccer', title: 'Football/Soccer', metadata: {'productCount': 234}),
          Category(id: 'basketball', title: 'Basketball', metadata: {'productCount': 123}),
          Category(id: 'cricket', title: 'Cricket', metadata: {'productCount': 89}),
          Category(id: 'tennis', title: 'Tennis', metadata: {'productCount': 67}),
        ],
      ),
    ],
  ),
  
  Category(
    id: 'books-media',
    title: 'Books, Media & Entertainment',
    description: 'Books, movies, music, and entertainment',
    iconData: Icons.menu_book,
    imageUrl: 'https://images.unsplash.com/photo-1481627834876-b7833e8f5570?w=300',
    metadata: {
      'productCount': 5670,
    },
    children: [
      Category(
        id: 'books',
        title: 'Books',
        metadata: {'productCount': 2340},
        children: [
          Category(id: 'fiction', title: 'Fiction', metadata: {'productCount': 567}),
          Category(id: 'non-fiction', title: 'Non-Fiction', metadata: {'productCount': 456}),
          Category(id: 'educational', title: 'Educational', metadata: {'productCount': 234}),
          Category(id: 'children-books', title: "Children's Books", metadata: {'productCount': 123}),
          Category(id: 'comics-graphic-novels', title: 'Comics & Graphic Novels', metadata: {'productCount': 89}),
        ],
      ),
      Category(
        id: 'movies-tv',
        title: 'Movies & TV',
        metadata: {'productCount': 1230},
        children: [
          Category(id: 'dvds-bluray', title: 'DVDs & Blu-ray', metadata: {'productCount': 234}),
          Category(id: 'streaming-devices', title: 'Streaming Devices', metadata: {'productCount': 123}),
        ],
      ),
      Category(
        id: 'music',
        title: 'Music',
        metadata: {'productCount': 890},
        children: [
          Category(id: 'vinyl-records', title: 'Vinyl Records', metadata: {'productCount': 123}),
          Category(id: 'cds', title: 'CDs', metadata: {'productCount': 89}),
          Category(id: 'musical-instruments', title: 'Musical Instruments', metadata: {'productCount': 234}),
        ],
      ),
    ],
  ),
  
  Category(
    id: 'automotive',
    title: 'Automotive & Industrial',
    description: 'Car parts, accessories, and industrial supplies',
    iconData: Icons.directions_car,
    imageUrl: 'https://images.unsplash.com/photo-1486262715619-67b85e0b08d3?w=300',
    metadata: {
      'productCount': 4560,
    },
    children: [
      Category(
        id: 'car-parts',
        title: 'Car Parts',
        metadata: {'productCount': 1890},
        children: [
          Category(id: 'engine-parts', title: 'Engine Parts', metadata: {'productCount': 234}),
          Category(id: 'brake-system', title: 'Brake System', metadata: {'productCount': 123}),
          Category(id: 'suspension', title: 'Suspension', metadata: {'productCount': 89}),
          Category(id: 'electrical', title: 'Electrical', metadata: {'productCount': 156}),
        ],
      ),
      Category(
        id: 'car-accessories',
        title: 'Car Accessories',
        metadata: {'productCount': 1230},
        children: [
          Category(id: 'interior-accessories', title: 'Interior Accessories', metadata: {'productCount': 234}),
          Category(id: 'exterior-accessories', title: 'Exterior Accessories', metadata: {'productCount': 123}),
          Category(id: 'car-electronics', title: 'Car Electronics', metadata: {'productCount': 89}),
          Category(id: 'car-care', title: 'Car Care', metadata: {'productCount': 156}),
        ],
      ),
    ],
  ),
  
  Category(
    id: 'toys-baby',
    title: 'Toys, Kids & Baby',
    description: 'Toys, baby products, and children essentials',
    iconData: Icons.toys,
    imageUrl: 'https://images.unsplash.com/photo-1544716278-ca5e3f4abd8c?w=300',
    metadata: {
      'productCount': 7890,
    },
    children: [
      Category(
        id: 'toys-games',
        title: 'Toys & Games',
        metadata: {'productCount': 3450},
        children: [
          Category(id: 'action-figures', title: 'Action Figures', metadata: {'productCount': 234}),
          Category(id: 'board-games', title: 'Board Games', metadata: {'productCount': 123}),
          Category(id: 'building-blocks', title: 'Building Blocks', metadata: {'productCount': 89}),
          Category(id: 'educational-toys', title: 'Educational Toys', metadata: {'productCount': 156}),
        ],
      ),
      Category(
        id: 'baby-products',
        title: 'Baby Products',
        metadata: {'productCount': 2340},
        children: [
          Category(id: 'baby-clothing', title: 'Baby Clothing', metadata: {'productCount': 456}),
          Category(id: 'diapers-wipes', title: 'Diapers & Wipes', metadata: {'productCount': 234}),
          Category(id: 'baby-feeding', title: 'Baby Feeding', metadata: {'productCount': 123}),
          Category(id: 'baby-care', title: 'Baby Care', metadata: {'productCount': 89}),
        ],
      ),
          ],
    ),
    
    Category(
      id: 'others',
      title: 'Others',
      description: 'Miscellaneous products and services',
      iconData: Icons.more_horiz,
      imageUrl: 'https://images.unsplash.com/photo-1556742049-0cfed4f6a45d?w=300',
      metadata: {
        'productCount': 2340,
      },
      children: [
        Category(id: 'gift-cards', title: 'Gift Cards', metadata: {'productCount': 123}),
        Category(id: 'subscriptions', title: 'Subscriptions', metadata: {'productCount': 89}),
        Category(id: 'digital-products', title: 'Digital Products', metadata: {'productCount': 156}),
        Category(id: 'services', title: 'Services', metadata: {'productCount': 234}),
      ],
    ),
  ];

// Helper function to get all categories
List<Category> getAllCategories() {
  return globalCategoryTree;
}

// Helper function to find category by ID
Category? findCategoryById(String id) {
  for (var category in globalCategoryTree) {
    final found = category.findById(id);
    if (found != null) return found;
  }
  return null;
}

// Helper function to get trending categories
List<Category> getTrendingCategories() {
  List<Category> trending = [];
  for (var category in globalCategoryTree) {
    if (category.isTrending) trending.add(category);
    for (var child in category.children) {
      if (child.isTrending) trending.add(child);
    }
  }
  return trending;
}

// Helper function to get featured categories
List<Category> getFeaturedCategories() {
  List<Category> featured = [];
  for (var category in globalCategoryTree) {
    if (category.isFeatured) featured.add(category);
  }
  return featured;
}

// Helper function to search categories
List<Category> searchCategories(String query) {
  List<Category> results = [];
  query = query.toLowerCase();
  
  for (var category in globalCategoryTree) {
    if (category.title.toLowerCase().contains(query) ||
        category.description?.toLowerCase().contains(query) == true) {
      results.add(category);
    }
    
    for (var child in category.children) {
      if (child.title.toLowerCase().contains(query)) {
        results.add(child);
      }
    }
  }
  
  return results;
} 