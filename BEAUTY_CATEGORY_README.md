# Beauty Category Screen - HashKart E-commerce App

## Overview

The Beauty Category Screen is a stunning, responsive beauty category interface that mirrors the design aesthetic from the provided image. It features soft pink gradients, rounded corners, clean typography, and modern layout flow tailored for the HashKart e-commerce app.

## Features

### 🎨 Design Elements
- **Soft Pink Color Palette**: Uses `#FECFD6` (blush pink) and `#FF6F91` (rose red)
- **Rounded Corners**: Consistent 12-20px border radius throughout
- **Clean Typography**: Inter font family for modern, readable text
- **Subtle Shadows**: Box shadows for depth and elevation
- **Gradient Backgrounds**: Soft pink gradients for visual appeal

### 📱 Screen Structure

#### 1. Header Section
- **Greeting**: "Welcome, Aida" in top-left corner
- **Search Bar**: Rounded with light pink background and search/filter icons
- **Profile Icon**: Circular avatar in top-right corner

#### 2. Search Tags/Filters
- **Active Filters**: "facial" and "makeup" chips with remove functionality
- **Removable Tags**: Tap 'x' to remove filters

#### 3. Tab Navigation
- **Category Tabs**: "Face", "Body", "Hair", "Gifts"
- **Active Tab Styling**: Bold pink underline for selected tab
- **Smooth Transitions**: Animated tab switching

#### 4. Featured Products Carousel
- **Horizontal Scroll**: Smooth scrolling product cards
- **Product Cards**: White rounded containers with drop shadows
- **Product Info**: Name, price, and heart icon
- **Error Handling**: Fallback icons for failed image loads

#### 5. Popular Products Section
- **Grid Layout**: 2-column responsive grid
- **Product Details**: Name, description, price, and add button
- **Consistent Styling**: Matches featured products design

## 🚀 Implementation Details

### Files Created/Modified

1. **`lib/screens/home/BeautyCategoryScreen.dart`** - Main beauty category screen
2. **`lib/data/all_products.dart`** - Added beauty-specific products
3. **`lib/routes/app_routes.dart`** - Added beauty category route
4. **`lib/routes/navigation_helper.dart`** - Added navigation method
5. **`lib/screens/home/HomeScreen.dart`** - Added beauty quick action button
6. **`lib/screens/auth/SplashScreen.dart`** - Updated with beauty theme
7. **`lib/screens/auth/OnboardingScreen.dart`** - Updated with beauty aesthetic

### Navigation

To navigate to the beauty category screen:

```dart
// From any screen
NavigationHelper.goToBeautyCategory();

// Or directly
Navigator.pushNamed(context, AppRoutes.beautyCategory);
```

### Quick Access

The beauty category is accessible from the home screen via the "Beauty" quick action button in the Quick Actions section.

## 🎯 Product Data

The beauty category includes sample products:

### Featured Products
- Facial Cleanser - $9.90
- Micellar Water - $8.90
- Hydrating Toner - $12.50
- Vitamin C Serum - $24.90

### Popular Products
- Cream Cleanser - $15.90
- Bath Bomb - $6.50
- Lipstick - $18.90
- Herbal Scrub - $14.90

## 🎨 Color Scheme

```dart
// Primary Colors
Color(0xFFFECFD6) // Blush pink
Color(0xFFFF6F91) // Rose red
Color(0xFFFEEFF4) // Light pink background
Color(0xFFFFFEFE) // Off-white

// Text Colors
Color(0xFF2D3436) // Primary text
Color(0xFF636E72) // Secondary text
Color(0xFFB8B8B8) // Placeholder text
```

## 📱 Responsive Design

- **CustomScrollView**: Full-page scrolling with slivers
- **SliverAppBar**: Collapsible header with gradient background
- **SliverPersistentHeader**: Pinned tab navigation
- **ListView.builder**: Horizontal scrolling for featured products
- **GridView.builder**: Responsive grid for popular products

## 🔧 Customization

### Adding New Products

Add beauty products to `lib/data/all_products.dart`:

```dart
Product(
  name: 'Your Product',
  price: '\$19.90',
  originalPrice: '\$24.90',
  rating: 4.5,
  imageUrls: ['your_image_url'],
  description: 'Product description',
),
```

### Modifying Colors

Update the color constants in `BeautyCategoryScreen.dart`:

```dart
// Primary beauty colors
static const Color beautyPrimary = Color(0xFFFF6F91);
static const Color beautySecondary = Color(0xFFFECFD6);
```

### Adding New Tabs

Modify the TabBar in the beauty category screen:

```dart
tabs: const [
  Tab(text: 'Face'),
  Tab(text: 'Body'),
  Tab(text: 'Hair'),
  Tab(text: 'Gifts'),
  Tab(text: 'New Tab'), // Add new tab
],
```

## 🎭 Animations

- **Page Transitions**: Smooth fade and scale animations
- **Tab Switching**: Animated tab indicator movement
- **Product Cards**: Subtle hover effects and tap feedback
- **Loading States**: Graceful error handling with fallback icons

## 📦 Dependencies

The beauty category screen uses standard Flutter widgets and doesn't require additional dependencies beyond the existing app structure.

## 🚀 Getting Started

1. **Run the app**: `flutter run`
2. **Navigate to Home**: The app starts with the splash screen
3. **Tap Beauty Button**: In the Quick Actions section on the home screen
4. **Explore**: Browse featured and popular beauty products

## 🎯 Future Enhancements

- **Product Details**: Navigate to detailed product pages
- **Shopping Cart**: Add products to cart functionality
- **Wishlist**: Save favorite products
- **Search**: Implement search functionality
- **Filters**: Advanced filtering options
- **Reviews**: Product rating and review system

---

**HashKart Beauty Category** - Where beauty meets technology! ✨ 