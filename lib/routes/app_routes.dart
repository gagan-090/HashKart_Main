import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../models/order_model.dart';

// Auth Screens

import '../screens/auth/SplashScreen.dart';
import '../screens/auth/OnboardingScreen.dart';
import '../screens/auth/LoginScreen.dart';
import '../screens/auth/SignupScreen.dart';
import '../screens/auth/ForgotPasswordScreen.dart';
import '../screens/auth/ResetPasswordScreen.dart';
import '../screens/auth/OTPVerificationScreen.dart';

// Home Screens
import '../screens/home/HomeScreen.dart';
import '../screens/home/CategoriesScreen.dart';
import '../screens/home/CategorySelectionScreen.dart';
import '../screens/home/SubcategoryScreen.dart';
import '../screens/home/MobileScreen.dart';
import '../screens/home/BrandScreen.dart';
import '../screens/home/BrandStoreScreen.dart';
import '../screens/home/FlashSaleScreen.dart';
import '../screens/home/OffersScreen.dart';
import '../screens/home/DealsScreen.dart';
import '../screens/home/BeautyCategoryScreen.dart';

// Product Screens
import '../screens/product/ProductDetailsScreen.dart';
import '../screens/product/SearchScreen.dart';
import '../screens/product/SearchResultsScreen.dart';
import '../screens/product/FilterScreen.dart';
import '../screens/product/WishlistScreen.dart';
import '../screens/product/SavedItemsScreen.dart';
import '../screens/product/RecentlyViewedScreen.dart';
import '../screens/product/ReviewsScreen.dart';
import '../screens/product/AddReviewScreen.dart';
import '../screens/product/ImageZoomScreen.dart';

// Cart Screens
import '../screens/cart/CartScreen.dart';
import '../screens/cart/EmptyCartScreen.dart';
import '../screens/checkout/checkout_screen.dart';
import '../screens/checkout/payment_processing_screen.dart';
import '../screens/checkout/order_success_screen.dart';
import '../screens/address/add_address_screen.dart';
import '../screens/payment/payment_method_screen.dart';

// Orders Screens
import '../screens/orders/orders_screen.dart';
import '../screens/orders/order_tracking_screen.dart';

// Account Screens
import '../screens/account/AccountScreen.dart';
import '../screens/account/MyDetailsScreen.dart';
import '../screens/account/ProfileEditScreen.dart';
import '../screens/account/AddressListScreen.dart';
import '../screens/account/AddEditAddressScreen.dart';
import '../screens/account/LogoutScreen.dart';

// Settings Screens
import '../screens/settings/SettingsScreen.dart';
import '../screens/settings/NotificationSettingsScreen.dart';
import '../screens/settings/NotificationsScreen.dart';

// Support Screens
import '../screens/support/HelpCenterScreen.dart';
import '../screens/support/CustomerServiceScreen.dart';
import '../screens/support/FAQsScreen.dart';

// Misc Screens
import '../screens/misc/PrivacyPolicyScreen.dart';
import '../screens/misc/TermsConditionsScreen.dart';
import '../screens/product/ProductListingScreen.dart';

class AppRoutes {
  // Route Names
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String forgotPassword = '/forgot-password';
  static const String resetPassword = '/reset-password';
  static const String otpVerification = '/otp-verification';
  
  static const String home = '/home';
  static const String category = '/category';
  static const String categories = '/categories';
  static const String categorySelection = '/category-selection';
  static const String subcategory = '/subcategory';
  static const String mobile = '/mobile';
  static const String brand = '/brand';
  static const String brandStore = '/brand-store';
  static const String flashSale = '/flash-sale';
  static const String offers = '/offers';
  static const String deals = '/deals';
  static const String beautyCategory = '/beauty-category';
  
  static const String productDetails = '/product-details';
  static const String search = '/search';
  static const String searchResults = '/search-results';
  static const String filter = '/filter';
  static const String wishlist = '/wishlist';
  static const String savedItems = '/saved-items';
  static const String recentlyViewed = '/recently-viewed';
  static const String reviews = '/reviews';
  static const String addReview = '/add-review';
  static const String imageZoom = '/image-zoom';
  
  static const String cart = '/cart';
  static const String emptyCart = '/empty-cart';
  static const String checkout = '/checkout';
  static const String paymentProcessing = '/payment-processing';
  static const String paymentMethod = '/payment-method';
  static const String addAddress = '/add-address';
  static const String orderSuccess = '/order-success';
  
  static const String orders = '/orders';
  static const String trackOrder = '/track-order';
  
  static const String account = '/account';
  static const String myDetails = '/my-details';
  static const String profileEdit = '/profile-edit';
  static const String addressList = '/address-list';
  static const String addEditAddress = '/add-edit-address';
  static const String logout = '/logout';
  
  static const String settings = '/settings';
  static const String notificationSettings = '/notification-settings';
  static const String notifications = '/notifications';
  
  static const String helpCenter = '/help-center';
  static const String customerService = '/customer-service';
  static const String faqs = '/faqs';
  
  static const String privacyPolicy = '/privacy-policy';
  static const String termsConditions = '/terms-conditions';
  static const String productListing = '/product-listing';

  // Route Generator
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // Auth Routes
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case onboarding:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case signup:
        return MaterialPageRoute(builder: (_) => const SignupScreen());
      case forgotPassword:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordScreen());
      case resetPassword:
        return MaterialPageRoute(builder: (_) => const ResetPasswordScreen());
      case otpVerification:
        return MaterialPageRoute(builder: (_) => const OTPVerificationScreen());
      
      // Home Routes
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case category:
        return MaterialPageRoute(builder: (_) => const CategoriesScreen());
      case categories:
        return MaterialPageRoute(builder: (_) => const CategoriesScreen());
      case categorySelection:
        return MaterialPageRoute(builder: (_) => const CategorySelectionScreen());
      case subcategory:
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => SubcategoryScreen(
            categoryName: args?['categoryName'],
            subcategoryName: args?['subcategoryName'],
          ),
        );
      case mobile:
        return MaterialPageRoute(builder: (_) => const MobileScreen());
      case brand:
        return MaterialPageRoute(builder: (_) => const BrandScreen());
      case brandStore:
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => BrandStoreScreen(
            selectedBrand: args?['selectedBrand'],
          ),
        );
      case flashSale:
        return MaterialPageRoute(builder: (_) => const FlashSaleScreen());
      case offers:
        return MaterialPageRoute(builder: (_) => const OffersScreen());
      case deals:
        return MaterialPageRoute(builder: (_) => const DealsScreen());
      case beautyCategory:
        return MaterialPageRoute(builder: (_) => const BeautyCategoryScreen());
      
      // Product Routes
      case productDetails:
        final product = settings.arguments as Product;
        return MaterialPageRoute(
            builder: (_) => ProductDetailsScreen(product: product));

      case search:
        return MaterialPageRoute(builder: (_) => const SearchScreen());
      case searchResults:
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => SearchResultsScreen(
            query: args?['query'] ?? '',
          ),
        );
      case filter:
        return MaterialPageRoute(builder: (_) => const FilterScreen());
      case wishlist:
        return MaterialPageRoute(builder: (_) => const WishlistScreen());
      case savedItems:
        return MaterialPageRoute(builder: (_) => const SavedItemsScreen());
      case recentlyViewed:
        return MaterialPageRoute(builder: (_) => const RecentlyViewedScreen());
      case reviews:
        return MaterialPageRoute(builder: (_) => const ReviewsScreen());
      case addReview:
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => AddReviewScreen(
            productName: args?['productName'] ?? '',
          ),
        );
      case imageZoom:
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => ImageZoomScreen(
            imageUrl: args?['imageUrl'] ?? '',
            title: args?['title'],
          ),
        );
      
      // Cart Routes
      case cart:
        return MaterialPageRoute(builder: (_) => const CartScreen());
      case emptyCart:
        return MaterialPageRoute(builder: (_) => const EmptyCartScreen());
      case checkout:
        return MaterialPageRoute(builder: (_) => const CheckoutScreen());
      case paymentProcessing:
        return MaterialPageRoute(builder: (_) => const PaymentProcessingScreen());
      case paymentMethod:
        return MaterialPageRoute(builder: (_) => const PaymentMethodScreen());
      case addAddress:
        final address = settings.arguments as DeliveryAddress?;
        return MaterialPageRoute(
          builder: (_) => AddAddressScreen(address: address),
        );
      case orderSuccess:
        return MaterialPageRoute(builder: (_) => const OrderSuccessScreen());
      
      // Orders Routes
      case orders:
        return MaterialPageRoute(builder: (_) => const OrdersScreen());
      case trackOrder:
        final orderId = settings.arguments as String?;
        return MaterialPageRoute(
          builder: (_) => OrderTrackingScreen(orderId: orderId),
        );
      
      // Account Routes
      case account:
        return MaterialPageRoute(builder: (_) => const AccountScreen());
      case myDetails:
        return MaterialPageRoute(builder: (_) => const MyDetailsScreen());
      case profileEdit:
        return MaterialPageRoute(builder: (_) => const ProfileEditScreen());
      case addressList:
        return MaterialPageRoute(builder: (_) => const AddressListScreen());
      case addEditAddress:
        return MaterialPageRoute(builder: (_) => const AddEditAddressScreen());
      case logout:
        return MaterialPageRoute(builder: (_) => const LogoutScreen());
      
      // Settings Routes
      case 'settings':
        return MaterialPageRoute(builder: (_) => const SettingsScreen());
      case notificationSettings:
        return MaterialPageRoute(builder: (_) => const NotificationSettingsScreen());
      case notifications:
        return MaterialPageRoute(builder: (_) => const NotificationsScreen());
      
      // Support Routes
      case helpCenter:
        return MaterialPageRoute(builder: (_) => const HelpCenterScreen());
      case customerService:
        return MaterialPageRoute(builder: (_) => const CustomerServiceScreen());
      case faqs:
        return MaterialPageRoute(builder: (_) => const FAQsScreen());
      
      // Misc Routes
      case privacyPolicy:
        return MaterialPageRoute(builder: (_) => const PrivacyPolicyScreen());
      case termsConditions:
        return MaterialPageRoute(builder: (_) => const TermsConditionsScreen());
      
      // Product Listing Route
      case productListing:
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => ProductListingScreen(
            category: args?['category'] ?? 'All',
            subCategory: args?['subCategory'],
          ),
        );
      
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(title: const Text('Page Not Found')),
            body: const Center(
              child: Text('404 - Page Not Found'),
            ),
          ),
        );
    }
  }
}
