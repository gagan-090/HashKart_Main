import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'dart:async';

// Import all home screens
import 'CategoriesScreen.dart';
import 'CategoryScreen.dart';
import 'MobileScreen.dart';
import 'BeautyCategoryScreen.dart';
import 'BrandStoreScreen.dart';
import 'DealsScreen.dart';
import 'FlashSaleScreen.dart';
import 'OffersScreen.dart';

// Import cart and profile screens
import '../cart/CartScreen.dart';
import '../account/AccountScreen.dart';
import '../../theme/app_theme.dart';
import '../../models/product_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  int _currentBottomIndex = 0;
  
  final FocusNode _searchFocusNode = FocusNode();
  int _currentBannerIndex = 0;
  bool _isSearchFocused = false;
  late PageController _pageController;
  
  // Animation controllers
  late AnimationController _searchAnimationController;
  late AnimationController _categoryIndicatorController;
  late AnimationController _countdownController;
  late AnimationController _floatingTagController;
  late Animation<double> _searchWidthAnimation;
  late Animation<double> _searchShadowAnimation;
  late Animation<double> _categoryIndicatorAnimation;
  late Animation<double> _floatingTagAnimation;
  
  // Countdown timer
  Timer? _countdownTimer;
  Duration _countdownDuration = const Duration(days: 2, hours: 12, minutes: 30, seconds: 45);
  
  int _selectedCategoryIndex = 0;
  
  final List<String> _bannerImages = [
    'https://picsum.photos/seed/banner1/800/400',
    'https://picsum.photos/seed/banner2/800/400',
    'https://picsum.photos/seed/banner3/800/400',
  ];

  final List<Map<String, dynamic>> _categories = [
    {'name': 'Mobiles', 'icon': Icons.smartphone, 'color': const Color(0xFF2196F3)},
    {'name': 'Fashion', 'icon': Icons.checkroom, 'color': const Color(0xFFE91E63)},
    {'name': 'Electronics', 'icon': Icons.electrical_services, 'color': const Color(0xFF9C27B0)},
    {'name': 'Appliances', 'icon': Icons.kitchen, 'color': const Color(0xFF4CAF50)},
    {'name': 'Grocery', 'icon': Icons.local_grocery_store, 'color': const Color(0xFFFF9800)},
    {'name': 'Beauty', 'icon': Icons.face, 'color': const Color(0xFFE91E63)},
    {'name': 'Sports', 'icon': Icons.sports_soccer, 'color': const Color(0xFF795548)},
    {'name': 'Books', 'icon': Icons.menu_book, 'color': const Color(0xFF607D8B)},
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _initializeAnimations();
    _startCountdownTimer();
    _setupSearchFocus();
    _startAutoSlide();
  }

  void _initializeAnimations() {
    _searchAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    
    _categoryIndicatorController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    
    _countdownController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    
    _floatingTagController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    
    _searchWidthAnimation = Tween<double>(
      begin: 0.9,
      end: 0.95,
    ).animate(CurvedAnimation(
      parent: _searchAnimationController,
      curve: Curves.easeInOut,
    ));
    
    _searchShadowAnimation = Tween<double>(
      begin: 0.05,
      end: 0.15,
    ).animate(CurvedAnimation(
      parent: _searchAnimationController,
      curve: Curves.easeInOut,
    ));
    
    _categoryIndicatorAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _categoryIndicatorController,
      curve: Curves.elasticOut,
    ));
    
    _floatingTagAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _floatingTagController,
      curve: Curves.easeInOut,
    ));
    
    _floatingTagController.repeat(reverse: true);
  }

  void _setupSearchFocus() {
    _searchFocusNode.addListener(() {
      setState(() {
        _isSearchFocused = _searchFocusNode.hasFocus;
      });
      
      if (_isSearchFocused) {
        _searchAnimationController.forward();
      } else {
        _searchAnimationController.reverse();
      }
    });
  }
  
  void _startCountdownTimer() {
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          if (_countdownDuration.inSeconds > 0) {
            _countdownDuration = Duration(seconds: _countdownDuration.inSeconds - 1);
            _countdownController.forward().then((_) {
              _countdownController.reverse();
            });
          }
        });
      }
    });
  }

  void _startAutoSlide() {
    Timer.periodic(const Duration(seconds: 4), (timer) {
      if (mounted && _pageController.hasClients) {
        int nextPage = (_currentBannerIndex + 1) % _bannerImages.length;
        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 800),
          curve: Curves.fastOutSlowIn,
        );
      }
    });
  }
  
  void _onCategoryTap(int index) {
    setState(() {
      _selectedCategoryIndex = index;
    });
    _categoryIndicatorController.forward().then((_) {
      _categoryIndicatorController.reverse();
    });
    HapticFeedback.lightImpact();
    
    // Navigate to appropriate screen based on category
    _navigateToCategory(index);
  }

  void _navigateToCategory(int index) {
    final category = _categories[index];
    switch (category['name']) {
      case 'Mobiles':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MobileScreen()),
        );
        break;
      case 'Beauty':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const BeautyCategoryScreen()),
        );
        break;
      case 'Fashion':
      case 'Electronics':
      case 'Appliances':
      case 'Grocery':
      case 'Sports':
      case 'Books':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const CategoryScreen(),
          ),
        );
        break;
      default:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CategoriesScreen()),
        );
    }
  }

  void _navigateToDeals() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const DealsScreen()),
    );
  }

  void _navigateToOffers() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const OffersScreen()),
    );
  }

  void _navigateToFlashSale() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const FlashSaleScreen()),
    );
  }

  void _navigateToBrandStore() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const BrandStoreScreen()),
    );
  }

  void _handleBottomNavigation(int index) {
    if (_currentBottomIndex == index) return;
    
    setState(() {
      _currentBottomIndex = index;
    });
    
    HapticFeedback.lightImpact();
    
    switch (index) {
      case 0:
        // Home - already on home screen
        break;
      case 1:
        // Categories
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CategoriesScreen()),
        );
        break;
      case 2:
        // Deals
        _navigateToDeals();
        break;
      case 3:
        // Cart
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CartScreen()),
        );
        break;
      case 4:
        // Profile
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AccountScreen()),
        );
        break;
    }
  }

  void _navigateToSearchCategory(String categoryName) {
    switch (categoryName.toLowerCase()) {
      case 'smartphones':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MobileScreen()),
        );
        break;
      case 'laptops':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const CategoryScreen(),
          ),
        );
        break;
      default:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const CategoryScreen(),
          ),
        );
    }
  }

  void _navigateToProductDetail(Product product) {
    Navigator.pushNamed(
      context,
      '/product-details',
      arguments: product,
    );
  }

  void _handleSearch(String query) {
    if (query.trim().isEmpty) return;
    
    HapticFeedback.lightImpact();
    
    // Navigate to appropriate screen based on search query
    String searchQuery = query.toLowerCase();
    if (searchQuery.contains('mobile') || searchQuery.contains('phone') || searchQuery.contains('iphone') || searchQuery.contains('samsung')) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MobileScreen()),
      );
    } else if (searchQuery.contains('beauty') || searchQuery.contains('cosmetic') || searchQuery.contains('makeup')) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const BeautyCategoryScreen()),
      );
    } else if (searchQuery.contains('deal') || searchQuery.contains('offer') || searchQuery.contains('discount')) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const DealsScreen()),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const CategoriesScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top App Bar (Header Section)
              _buildTopAppBar(),
              
              // Search Bar
              _buildSearchBar(),
              
              // Top Category Navigation Bar
              _buildCategoryNavigation(),
              
              // Hero Banner Section ("Freedom Sale")
              _buildHeroBanner(),
              
              // "Still Looking For These?" Section
              _buildStillLookingSection(),
              
              // "Upcoming: Top Deals" Section
              _buildTopDealsSection(),
              
              // Sponsored Section
              _buildSponsoredSection(),
              
              // "Suggested For You" Section
              _buildSuggestedSection(),
              
              // "Upcoming: Hero Deals" Section
              _buildHeroDealsSection(),
              
              // "Upcoming: Bargain Buys" Section
              _buildBargainBuysSection(),
              
              const SizedBox(height: 100), // Bottom padding for navigation bar
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToFlashSale,
        backgroundColor: const Color(0xFF2874F0),
        child: const Icon(
          Icons.flash_on,
          color: Colors.white,
        ),
      ),
    );
  }

  // Top App Bar (Header Section) - Fully Responsive
  Widget _buildTopAppBar() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        final isTablet = screenWidth > 600;
        
        return Container(
          width: screenWidth,
          padding: EdgeInsets.symmetric(
            horizontal: isTablet ? 24 : 16, 
            vertical: isTablet ? 16 : 12
          ),
          decoration: BoxDecoration(
            gradient: AppTheme.primaryGradient,
            boxShadow: [
              BoxShadow(
                color: AppTheme.primaryColor.withValues(alpha: 0.3),
                offset: const Offset(0, 4),
                blurRadius: 12,
                spreadRadius: 0,
              ),
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                offset: const Offset(0, 2),
                blurRadius: 8,
                spreadRadius: 0,
              ),
            ],
          ),
          child: Row(
            children: [
              // App Logo
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.shopping_bag_rounded,
                      color: Colors.white,
                      size: isTablet ? 20 : 16,
                    ),
                  ),
                  SizedBox(width: isTablet ? 12 : 8),
                  Text(
                    'HashKart',
                    style: GoogleFonts.playfairDisplay(
                      fontSize: isTablet ? 26 : 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              // Profile Icon
              _buildAnimatedIcon(
                Icons.person_rounded, 
                isTablet ? 28 : 24,
                () {
                  HapticFeedback.lightImpact();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AccountScreen()),
                  );
                }
              ),
              SizedBox(width: isTablet ? 16 : 12),
              // Notification Icon
              Stack(
                children: [
                  _buildAnimatedIcon(
                    Icons.notifications_rounded, 
                    isTablet ? 28 : 24,
                    () {
                      HapticFeedback.lightImpact();
                      _navigateToOffers();
                    }
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      width: isTablet ? 10 : 8,
                      height: isTablet ? 10 : 8,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFF6B6B),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFFF6B6B).withValues(alpha: 0.4),
                            offset: const Offset(0, 1),
                            blurRadius: 2,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(width: isTablet ? 20 : 16),
              // Cart Icon with Badge
              Stack(
                children: [
                  _buildAnimatedIcon(
                    Icons.shopping_cart_rounded, 
                    isTablet ? 28 : 24,
                    () {
                      HapticFeedback.lightImpact();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const CartScreen()),
                      );
                    }
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFFF6B6B), Color(0xFFFF8E53)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFFF6B6B).withValues(alpha: 0.4),
                            offset: const Offset(0, 2),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      constraints: BoxConstraints(
                        minWidth: isTablet ? 20 : 18,
                        minHeight: isTablet ? 20 : 18,
                      ),
                      child: Text(
                        '3',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: isTablet ? 12 : 10,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAnimatedIcon(IconData icon, double size, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedScale(
        scale: 1.0,
        duration: const Duration(milliseconds: 150),
        child: Icon(
          icon,
          color: Colors.white,
          size: size,
        ),
      ),
    );
  }

  // Search Bar - Fully Responsive
  Widget _buildSearchBar() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        final isTablet = screenWidth > 600;
        
        return AnimatedBuilder(
          animation: _searchAnimationController,
          builder: (context, child) {
            return Container(
              width: screenWidth,
              padding: EdgeInsets.all(isTablet ? 20 : 16),
              decoration: BoxDecoration(
                gradient: AppTheme.primaryGradient,
              ),
              child: Center(
                child: Container(
                  width: screenWidth * _searchWidthAnimation.value,
                  height: isTablet ? 52 : 44,
                  constraints: BoxConstraints(
                    maxWidth: isTablet ? 800 : double.infinity,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: _searchShadowAnimation.value * 0.15),
                        offset: const Offset(0, 4),
                        blurRadius: 12,
                        spreadRadius: 0,
                      ),
                      BoxShadow(
                        color: AppTheme.primaryColor.withValues(alpha: _searchShadowAnimation.value * 0.1),
                        offset: const Offset(0, 2),
                        blurRadius: 8,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: TextField(
                    focusNode: _searchFocusNode,
                    onSubmitted: _handleSearch,
                    decoration: InputDecoration(
                      hintText: 'Search for products, brands and more',
                      hintStyle: GoogleFonts.inter(
                        color: Colors.grey[500],
                        fontSize: isTablet ? 16 : 14,
                        fontWeight: FontWeight.w400,
                      ),
                      prefixIcon: Container(
                        padding: const EdgeInsets.all(12),
                        child: Icon(
                          Icons.search_rounded,
                          color: AppTheme.primaryColor.withValues(alpha: 0.7),
                          size: isTablet ? 24 : 20,
                        ),
                      ),
                      suffixIcon: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _buildSearchIcon(Icons.mic_rounded, isTablet ? 22 : 18, () {
                            HapticFeedback.lightImpact();
                          }),
                          const SizedBox(width: 8),
                          _buildSearchIcon(Icons.camera_alt_rounded, isTablet ? 22 : 18, () {
                            HapticFeedback.lightImpact();
                          }),
                          const SizedBox(width: 12),
                        ],
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        vertical: isTablet ? 16 : 12,
                        horizontal: 4,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildSearchIcon(IconData icon, double size, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppTheme.primaryColor.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: AnimatedScale(
          scale: 1.0,
          duration: const Duration(milliseconds: 150),
          child: Icon(
            icon,
            color: AppTheme.primaryColor,
            size: size,
          ),
        ),
      ),
    );
  }

  // Top Category Navigation Bar - Fully Responsive
  Widget _buildCategoryNavigation() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        final isTablet = screenWidth > 600;
        
        return Container(
          height: isTablet ? 100 : 80,
          color: Colors.white,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: isTablet ? 12 : 8),
            itemCount: _categories.length,
            itemBuilder: (context, index) {
              final category = _categories[index];
              final isSelected = _selectedCategoryIndex == index;
              
              return GestureDetector(
                onTap: () => _onCategoryTap(index),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: EdgeInsets.symmetric(
                    horizontal: isTablet ? 12 : 8, 
                    vertical: isTablet ? 12 : 8
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: isTablet ? 16 : 12, 
                    vertical: isTablet ? 12 : 8
                  ),
                  decoration: BoxDecoration(
                    color: isSelected 
                        ? category['color'].withValues(alpha: 0.1) 
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                    border: isSelected 
                        ? Border.all(color: category['color'], width: 1) 
                        : null,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedScale(
                        scale: isSelected ? 1.1 : 1.0,
                        duration: const Duration(milliseconds: 200),
                        child: Icon(
                          category['icon'],
                          color: isSelected ? category['color'] : Colors.grey[600],
                          size: isTablet ? 28 : 24,
                        ),
                      ),
                      SizedBox(height: isTablet ? 6 : 4),
                      Text(
                        category['name'],
                        style: GoogleFonts.roboto(
                          fontSize: isTablet ? 14 : 12,
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                          color: isSelected ? category['color'] : Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  // Elegant Hero Banner Section - Classic & Glossy
  Widget _buildHeroBanner() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        final isTablet = screenWidth > 600;
        final bannerHeight = isTablet ? 280.0 : 220.0;
        
        return Container(
          margin: EdgeInsets.symmetric(
            horizontal: isTablet ? 24 : 16,
            vertical: isTablet ? 20 : 16,
          ),
          child: Column(
            children: [
              Container(
                height: bannerHeight,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.primaryColor.withValues(alpha: 0.3),
                      offset: const Offset(0, 8),
                      blurRadius: 24,
                      spreadRadius: 0,
                    ),
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      offset: const Offset(0, 4),
                      blurRadius: 12,
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() {
                        _currentBannerIndex = index;
                      });
                    },
                    itemCount: _bannerImages.length,
                    itemBuilder: (context, index) {
                      return _buildElegantBannerSlide(index, screenWidth, bannerHeight, isTablet);
                    },
                  ),
                ),
              ),
              SizedBox(height: isTablet ? 20 : 16),
              AnimatedSmoothIndicator(
                activeIndex: _currentBannerIndex,
                count: _bannerImages.length,
                effect: ExpandingDotsEffect(
                  dotHeight: isTablet ? 8 : 6,
                  dotWidth: isTablet ? 8 : 6,
                  expansionFactor: 4,
                  spacing: 8,
                  activeDotColor: AppTheme.primaryColor,
                  dotColor: AppTheme.primaryColor.withValues(alpha: 0.3),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildElegantBannerSlide(int index, double screenWidth, double bannerHeight, bool isTablet) {
    final bannerData = [
      {
        'title': 'Premium Collection',
        'subtitle': 'Discover luxury at its finest',
        'gradient': const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF667eea),
            Color(0xFF764ba2),
          ],
        ),
      },
      {
        'title': 'Exclusive Deals',
        'subtitle': 'Limited time offers await',
        'gradient': const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFf093fb),
            Color(0xFFf5576c),
          ],
        ),
      },
      {
        'title': 'New Arrivals',
        'subtitle': 'Fresh styles, endless possibilities',
        'gradient': const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF4facfe),
            Color(0xFF00f2fe),
          ],
        ),
      },
    ];

    final data = bannerData[index % bannerData.length];
    
    return Container(
      decoration: BoxDecoration(
        gradient: data['gradient'] as LinearGradient,
      ),
      child: Stack(
        children: [
          // Glossy overlay effect
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white.withValues(alpha: 0.1),
                  Colors.transparent,
                  Colors.black.withValues(alpha: 0.2),
                ],
                stops: const [0.0, 0.5, 1.0],
              ),
            ),
          ),
          
          // Decorative elements
          Positioned(
            top: -50,
            right: -50,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.1),
              ),
            ),
          ),
          
          Positioned(
            bottom: -30,
            left: -30,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.05),
              ),
            ),
          ),
          
          // Content
          Positioned(
            left: isTablet ? 40 : 24,
            bottom: isTablet ? 40 : 24,
            right: isTablet ? 40 : 24,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  data['title'] as String,
                  style: GoogleFonts.playfairDisplay(
                    color: Colors.white,
                    fontSize: isTablet ? 32 : 24,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                    shadows: [
                      Shadow(
                        offset: const Offset(0, 2),
                        blurRadius: 8,
                        color: Colors.black.withValues(alpha: 0.3),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: isTablet ? 12 : 8),
                Text(
                  data['subtitle'] as String,
                  style: GoogleFonts.inter(
                    color: Colors.white.withValues(alpha: 0.9),
                    fontSize: isTablet ? 16 : 14,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.3,
                    shadows: [
                      Shadow(
                        offset: const Offset(0, 1),
                        blurRadius: 4,
                        color: Colors.black.withValues(alpha: 0.2),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: isTablet ? 20 : 16),
                GestureDetector(
                  onTap: _navigateToDeals,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: isTablet ? 24 : 20,
                      vertical: isTablet ? 12 : 10,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.3),
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          offset: const Offset(0, 4),
                          blurRadius: 12,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Shop Now',
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: isTablet ? 16 : 14,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                          ),
                        ),
                        SizedBox(width: isTablet ? 8 : 6),
                        Icon(
                          Icons.arrow_forward_rounded,
                          color: Colors.white,
                          size: isTablet ? 20 : 18,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCountdownTimer(bool isTablet) {
    final days = _countdownDuration.inDays;
    final hours = _countdownDuration.inHours % 24;
    final minutes = _countdownDuration.inMinutes % 60;
    final seconds = _countdownDuration.inSeconds % 60;

    return AnimatedBuilder(
      animation: _countdownController,
      builder: (context, child) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _buildTimeUnit(days.toString().padLeft(2, '0'), 'DD', isTablet),
              _buildTimeSeparator(isTablet),
              _buildTimeUnit(hours.toString().padLeft(2, '0'), 'HH', isTablet),
              _buildTimeSeparator(isTablet),
              _buildTimeUnit(minutes.toString().padLeft(2, '0'), 'MM', isTablet),
              _buildTimeSeparator(isTablet),
              _buildTimeUnit(seconds.toString().padLeft(2, '0'), 'SS', isTablet),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTimeUnit(String value, String label, bool isTablet) {
    return AnimatedScale(
      scale: 1.0 + (_countdownController.value * 0.1),
      duration: const Duration(milliseconds: 100),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: isTablet ? 10 : 6, 
          vertical: isTablet ? 4 : 3
        ),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.7),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: GoogleFonts.roboto(
                color: Colors.white,
                fontSize: isTablet ? 20 : 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              label,
              style: GoogleFonts.roboto(
                color: Colors.white70,
                fontSize: isTablet ? 12 : 10,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeSeparator(bool isTablet) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isTablet ? 4 : 2),
      child: Text(
        ':',
        style: GoogleFonts.roboto(
          color: Colors.white,
          fontSize: isTablet ? 20 : 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // "Still Looking For These?" Section - Fully Responsive
  Widget _buildStillLookingSection() {
    final lookingItems = [
      {'image': 'https://picsum.photos/seed/phone1/150/150', 'title': 'Smartphones'},
      {'image': 'https://picsum.photos/seed/laptop1/150/150', 'title': 'Laptops'},
      {'image': 'https://picsum.photos/seed/watch1/150/150', 'title': 'Watches'},
      {'image': 'https://picsum.photos/seed/headphone1/150/150', 'title': 'Headphones'},
      {'image': 'https://picsum.photos/seed/camera1/150/150', 'title': 'Cameras'},
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        final isTablet = screenWidth > 600;
        
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isTablet ? 20 : 16, 
                  vertical: isTablet ? 16 : 12
                ),
                child: Text(
                  'Still looking for these?',
                  style: GoogleFonts.roboto(
                    fontSize: isTablet ? 22 : 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ),
              SizedBox(
                height: isTablet ? 160 : 120,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: isTablet ? 16 : 12),
                  itemCount: lookingItems.length,
                  itemBuilder: (context, index) {
                    final item = lookingItems[index];
                    return _buildLookingItem(
                      item['image']!, 
                      item['title']!, 
                      isTablet
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLookingItem(String imageUrl, String title, bool isTablet) {
    final itemWidth = isTablet ? 140.0 : 100.0;
    final imageSize = isTablet ? 100.0 : 80.0;
    
    return Container(
      width: itemWidth,
      margin: EdgeInsets.symmetric(horizontal: isTablet ? 6 : 4),
      child: GestureDetector(
        onTap: () {
          HapticFeedback.lightImpact();
          _navigateToSearchCategory(title);
        },
        child: AnimatedScale(
          scale: 1.0,
          duration: const Duration(milliseconds: 150),
          child: Column(
            children: [
              Container(
                width: imageSize,
                height: imageSize,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      offset: const Offset(0, 2),
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      color: Colors.grey[300],
                      child: const Center(
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      color: Colors.grey[300],
                      child: const Icon(Icons.error),
                    ),
                  ),
                ),
              ),
              SizedBox(height: isTablet ? 12 : 8),
              Text(
                title,
                style: GoogleFonts.roboto(
                  fontSize: isTablet ? 14 : 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Product Sections - Fully Responsive
  Widget _buildTopDealsSection() {
    final topDeals = [
      {
        'image': 'https://picsum.photos/seed/deal1/200/200',
        'title': 'iPhone 15 Pro',
        'originalPrice': '₹1,29,900',
        'discountedPrice': '₹1,19,900',
        'rating': 4.5,
        'tag': 'Min. Lowest Price Ever'
      },
      {
        'image': 'https://picsum.photos/seed/deal2/200/200',
        'title': 'Samsung Galaxy S24',
        'originalPrice': '₹89,999',
        'discountedPrice': '₹79,999',
        'rating': 4.3,
        'tag': 'Great Deal'
      },
      {
        'image': 'https://picsum.photos/seed/deal3/200/200',
        'title': 'OnePlus 12',
        'originalPrice': '₹64,999',
        'discountedPrice': '₹59,999',
        'rating': 4.4,
        'tag': 'Limited Time'
      },
    ];

    return _buildProductSection(
      title: 'Upcoming: Top deals',
      products: topDeals,
      showFloatingTag: true,
      onSeeAllTap: _navigateToDeals,
    );
  }

  Widget _buildSponsoredSection() {
    final sponsoredProducts = [
      {
        'image': 'https://picsum.photos/seed/sponsor1/200/200',
        'title': 'Wireless Earbuds',
        'originalPrice': '₹4,999',
        'discountedPrice': '₹2,499',
        'rating': 4.2,
        'tag': 'Sponsored'
      },
      {
        'image': 'https://picsum.photos/seed/sponsor2/200/200',
        'title': 'Smart Watch',
        'originalPrice': '₹12,999',
        'discountedPrice': '₹8,999',
        'rating': 4.1,
        'tag': 'Sponsored'
      },
    ];

    return _buildProductSection(
      title: 'Sponsored',
      products: sponsoredProducts,
      showFloatingTag: false,
      onSeeAllTap: _navigateToOffers,
    );
  }

  Widget _buildProductSection({
    required String title,
    required List<Map<String, dynamic>> products,
    required bool showFloatingTag,
    VoidCallback? onSeeAllTap,
  }) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        final isTablet = screenWidth > 600;
        
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isTablet ? 20 : 16, 
                  vertical: isTablet ? 16 : 12
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.roboto(
                        fontSize: isTablet ? 22 : 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    if (onSeeAllTap != null)
                      GestureDetector(
                        onTap: onSeeAllTap,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: isTablet ? 12 : 8,
                            vertical: isTablet ? 6 : 4,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF2874F0),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            'See All',
                            style: GoogleFonts.roboto(
                              fontSize: isTablet ? 14 : 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              SizedBox(
                height: isTablet ? 340 : 280,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: isTablet ? 16 : 12),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return _buildProductCard(
                      product: product,
                      showFloatingTag: showFloatingTag,
                      isTablet: isTablet,
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildProductCard({
    required Map<String, dynamic> product,
    required bool showFloatingTag,
    required bool isTablet,
  }) {
    final cardWidth = isTablet ? 200.0 : 160.0;
    final imageHeight = isTablet ? 180.0 : 140.0;
    
    return Container(
      width: cardWidth,
      margin: EdgeInsets.symmetric(horizontal: isTablet ? 6 : 4),
      child: GestureDetector(
        onTap: () => HapticFeedback.lightImpact(),
        child: AnimatedScale(
          scale: 1.0,
          duration: const Duration(milliseconds: 150),
          child: Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Image
                Stack(
                  children: [
                    SizedBox(
                      height: imageHeight,
                      width: double.infinity,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(8),
                        ),
                        child: CachedNetworkImage(
                          imageUrl: product['image'],
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                            color: Colors.grey[300],
                            child: const Center(
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                          ),
                          errorWidget: (context, url, error) => Container(
                            color: Colors.grey[300],
                            child: const Icon(Icons.error),
                          ),
                        ),
                      ),
                    ),
                    if (showFloatingTag && product['tag'] == 'Min. Lowest Price Ever')
                      Positioned(
                        top: 8,
                        left: 8,
                        child: AnimatedBuilder(
                          animation: _floatingTagAnimation,
                          builder: (context, child) {
                            return Transform.translate(
                              offset: Offset(0, _floatingTagAnimation.value * 2),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: isTablet ? 8 : 6,
                                  vertical: isTablet ? 3 : 2,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  product['tag'],
                                  style: GoogleFonts.roboto(
                                    color: Colors.white,
                                    fontSize: isTablet ? 10 : 8,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                  ],
                ),
                // Product Details
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(isTablet ? 12 : 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product['title'],
                          style: GoogleFonts.roboto(
                            fontSize: isTablet ? 16 : 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: isTablet ? 6 : 4),
                        Row(
                          children: [
                            ...List.generate(5, (index) {
                              return Icon(
                                index < product['rating'].floor()
                                    ? Icons.star
                                    : Icons.star_border,
                                color: Colors.orange,
                                size: isTablet ? 14 : 12,
                              );
                            }),
                            SizedBox(width: isTablet ? 6 : 4),
                            Text(
                              product['rating'].toString(),
                              style: GoogleFonts.roboto(
                                fontSize: isTablet ? 12 : 10,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: isTablet ? 6 : 4),
                        Row(
                          children: [
                            Text(
                              product['discountedPrice'],
                              style: GoogleFonts.roboto(
                                fontSize: isTablet ? 16 : 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            SizedBox(width: isTablet ? 6 : 4),
                            Expanded(
                              child: Text(
                                product['originalPrice'],
                                style: GoogleFonts.roboto(
                                  fontSize: isTablet ? 14 : 12,
                                  color: Colors.grey[600],
                                  decoration: TextDecoration.lineThrough,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: isTablet ? 6 : 4),
                        Text(
                          'Free delivery',
                          style: GoogleFonts.roboto(
                            fontSize: isTablet ? 12 : 10,
                            color: Colors.green,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // "Suggested For You" Section - Fully Responsive Grid
  Widget _buildSuggestedSection() {
    final suggestedProducts = [
      {
        'image': 'https://picsum.photos/seed/suggest1/200/200',
        'title': 'Bluetooth Speaker',
        'originalPrice': '₹2,999',
        'discountedPrice': '₹1,999',
        'rating': 4.0,
      },
      {
        'image': 'https://picsum.photos/seed/suggest2/200/200',
        'title': 'Power Bank',
        'originalPrice': '₹1,999',
        'discountedPrice': '₹1,299',
        'rating': 4.2,
      },
      {
        'image': 'https://picsum.photos/seed/suggest3/200/200',
        'title': 'Phone Case',
        'originalPrice': '₹799',
        'discountedPrice': '₹499',
        'rating': 3.9,
      },
      {
        'image': 'https://picsum.photos/seed/suggest4/200/200',
        'title': 'Wireless Charger',
        'originalPrice': '₹1,499',
        'discountedPrice': '₹999',
        'rating': 4.1,
      },
      {
        'image': 'https://picsum.photos/seed/suggest5/200/200',
        'title': 'USB Cable',
        'originalPrice': '₹299',
        'discountedPrice': '₹199',
        'rating': 4.3,
      },
      {
        'image': 'https://picsum.photos/seed/suggest6/200/200',
        'title': 'Screen Protector',
        'originalPrice': '₹499',
        'discountedPrice': '₹299',
        'rating': 4.0,
      },
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        final isTablet = screenWidth > 600;
        final crossAxisCount = isTablet ? 4 : 2;
        final childAspectRatio = isTablet ? 0.8 : 0.85;
        
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isTablet ? 20 : 16, 
                  vertical: isTablet ? 16 : 12
                ),
                child: Text(
                  'Suggested For You',
                  style: GoogleFonts.roboto(
                    fontSize: isTablet ? 22 : 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: isTablet ? 20 : 16),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  childAspectRatio: childAspectRatio,
                  crossAxisSpacing: isTablet ? 12 : 8,
                  mainAxisSpacing: isTablet ? 12 : 8,
                ),
                itemCount: suggestedProducts.length,
                itemBuilder: (context, index) {
                  final product = suggestedProducts[index];
                  return _buildGridProductCard(product, isTablet);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildGridProductCard(Map<String, dynamic> product, bool isTablet) {
    return GestureDetector(
      onTap: () => HapticFeedback.lightImpact(),
      child: AnimatedScale(
        scale: 1.0,
        duration: const Duration(milliseconds: 150),
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image
              Expanded(
                flex: 3,
                child: SizedBox(
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(8),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: product['image'],
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        color: Colors.grey[300],
                        child: const Center(
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: Colors.grey[300],
                        child: const Icon(Icons.error),
                      ),
                    ),
                  ),
                ),
              ),
              // Product Details
              Expanded(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.all(isTablet ? 12 : 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product['title'],
                        style: GoogleFonts.roboto(
                          fontSize: isTablet ? 14 : 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: isTablet ? 4 : 2),
                      Row(
                        children: [
                          ...List.generate(5, (index) {
                            return Icon(
                              index < product['rating'].floor()
                                  ? Icons.star
                                  : Icons.star_border,
                              color: Colors.orange,
                              size: isTablet ? 12 : 10,
                            );
                          }),
                          SizedBox(width: isTablet ? 4 : 2),
                          Text(
                            product['rating'].toString(),
                            style: GoogleFonts.roboto(
                              fontSize: isTablet ? 10 : 8,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: isTablet ? 4 : 2),
                      Text(
                        product['discountedPrice'],
                        style: GoogleFonts.roboto(
                          fontSize: isTablet ? 14 : 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        product['originalPrice'],
                        style: GoogleFonts.roboto(
                          fontSize: isTablet ? 12 : 10,
                          color: Colors.grey[600],
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // "Upcoming: Hero Deals" Section - Fully Responsive
  Widget _buildHeroDealsSection() {
    final heroDeals = [
      {
        'image': 'https://picsum.photos/seed/hero1/250/200',
        'title': 'MacBook Pro M3',
        'originalPrice': '₹1,99,900',
        'discountedPrice': '₹1,79,900',
        'rating': 4.8,
        'tag': 'Hero Deal'
      },
      {
        'image': 'https://picsum.photos/seed/hero2/250/200',
        'title': 'iPad Air',
        'originalPrice': '₹59,900',
        'discountedPrice': '₹54,900',
        'rating': 4.6,
        'tag': 'Hero Deal'
      },
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        final isTablet = screenWidth > 600;
        
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isTablet ? 20 : 16, 
                  vertical: isTablet ? 16 : 12
                ),
                child: Text(
                  'Upcoming: Hero deals',
                  style: GoogleFonts.roboto(
                    fontSize: isTablet ? 22 : 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ),
              SizedBox(
                height: isTablet ? 380 : 320,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: isTablet ? 16 : 12),
                  itemCount: heroDeals.length,
                  itemBuilder: (context, index) {
                    final product = heroDeals[index];
                    return _buildHeroCard(product, isTablet);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHeroCard(Map<String, dynamic> product, bool isTablet) {
    final cardWidth = isTablet ? 260.0 : 200.0;
    final imageHeight = isTablet ? 220.0 : 180.0;
    
    return Container(
      width: cardWidth,
      margin: EdgeInsets.symmetric(horizontal: isTablet ? 6 : 4),
      child: GestureDetector(
        onTap: () => HapticFeedback.lightImpact(),
        child: AnimatedScale(
          scale: 1.0,
          duration: const Duration(milliseconds: 150),
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Image with Parallax Effect
                SizedBox(
                  height: imageHeight,
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(12),
                    ),
                    child: Stack(
                      children: [
                        CachedNetworkImage(
                          imageUrl: product['image'],
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                          placeholder: (context, url) => Container(
                            color: Colors.grey[300],
                            child: const Center(
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                          ),
                          errorWidget: (context, url, error) => Container(
                            color: Colors.grey[300],
                            child: const Icon(Icons.error),
                          ),
                        ),
                        Positioned(
                          top: isTablet ? 16 : 12,
                          right: isTablet ? 16 : 12,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: isTablet ? 10 : 8,
                              vertical: isTablet ? 6 : 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.orange,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              product['tag'],
                              style: GoogleFonts.roboto(
                                color: Colors.white,
                                fontSize: isTablet ? 12 : 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Product Details
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(isTablet ? 16 : 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product['title'],
                          style: GoogleFonts.roboto(
                            fontSize: isTablet ? 18 : 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: isTablet ? 8 : 6),
                        Row(
                          children: [
                            ...List.generate(5, (index) {
                              return Icon(
                                index < product['rating'].floor()
                                    ? Icons.star
                                    : Icons.star_border,
                                color: Colors.orange,
                                size: isTablet ? 16 : 14,
                              );
                            }),
                            SizedBox(width: isTablet ? 6 : 4),
                            Text(
                              product['rating'].toString(),
                              style: GoogleFonts.roboto(
                                fontSize: isTablet ? 14 : 12,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: isTablet ? 8 : 6),
                        Row(
                          children: [
                            Text(
                              product['discountedPrice'],
                              style: GoogleFonts.roboto(
                                fontSize: isTablet ? 18 : 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            SizedBox(width: isTablet ? 8 : 6),
                            Expanded(
                              child: Text(
                                product['originalPrice'],
                                style: GoogleFonts.roboto(
                                  fontSize: isTablet ? 14 : 12,
                                  color: Colors.grey[600],
                                  decoration: TextDecoration.lineThrough,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: isTablet ? 6 : 4),
                        Text(
                          'Free delivery',
                          style: GoogleFonts.roboto(
                            fontSize: isTablet ? 13 : 11,
                            color: Colors.green,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // "Upcoming: Bargain Buys" Section - Fully Responsive
  Widget _buildBargainBuysSection() {
    final bargainBuys = [
      {
        'image': 'https://picsum.photos/seed/bargain1/150/150',
        'title': 'Phone Stand',
        'originalPrice': '₹299',
        'discountedPrice': '₹99',
        'rating': 3.8,
      },
      {
        'image': 'https://picsum.photos/seed/bargain2/150/150',
        'title': 'Car Charger',
        'originalPrice': '₹499',
        'discountedPrice': '₹199',
        'rating': 4.0,
      },
      {
        'image': 'https://picsum.photos/seed/bargain3/150/150',
        'title': 'Earphone Case',
        'originalPrice': '₹199',
        'discountedPrice': '₹79',
        'rating': 3.9,
      },
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        final isTablet = screenWidth > 600;
        
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isTablet ? 20 : 16, 
                  vertical: isTablet ? 16 : 12
                ),
                child: Text(
                  'Upcoming: Bargain buys',
                  style: GoogleFonts.roboto(
                    fontSize: isTablet ? 22 : 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ),
              SizedBox(
                height: isTablet ? 240 : 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: isTablet ? 16 : 12),
                  itemCount: bargainBuys.length,
                  itemBuilder: (context, index) {
                    final product = bargainBuys[index];
                    return _buildBargainCard(product, isTablet);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBargainCard(Map<String, dynamic> product, bool isTablet) {
    final cardWidth = isTablet ? 180.0 : 140.0;
    final imageHeight = isTablet ? 120.0 : 100.0;
    
    return Container(
      width: cardWidth,
      margin: EdgeInsets.symmetric(horizontal: isTablet ? 6 : 4),
      child: GestureDetector(
        onTap: () => HapticFeedback.lightImpact(),
        child: AnimatedScale(
          scale: 1.0,
          duration: const Duration(milliseconds: 150),
          child: Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Image
                SizedBox(
                  height: imageHeight,
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(8),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: product['image'],
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        color: Colors.grey[300],
                        child: const Center(
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: Colors.grey[300],
                        child: const Icon(Icons.error),
                      ),
                    ),
                  ),
                ),
                // Product Details
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(isTablet ? 12 : 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product['title'],
                          style: GoogleFonts.roboto(
                            fontSize: isTablet ? 14 : 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: isTablet ? 6 : 4),
                        Row(
                          children: [
                            Text(
                              product['discountedPrice'],
                              style: GoogleFonts.roboto(
                                fontSize: isTablet ? 14 : 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            SizedBox(width: isTablet ? 6 : 4),
                            Text(
                              product['originalPrice'],
                              style: GoogleFonts.roboto(
                                fontSize: isTablet ? 12 : 10,
                                color: Colors.grey[600],
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: isTablet ? 4 : 2),
                        Row(
                          children: [
                            ...List.generate(5, (index) {
                              return Icon(
                                index < product['rating'].floor()
                                    ? Icons.star
                                    : Icons.star_border,
                                color: Colors.orange,
                                size: isTablet ? 12 : 10,
                              );
                            }),
                            SizedBox(width: isTablet ? 4 : 2),
                            Text(
                              product['rating'].toString(),
                              style: GoogleFonts.roboto(
                                fontSize: isTablet ? 10 : 8,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Enhanced Bottom Navigation Bar - Elegant & Modern
  Widget _buildBottomNavigationBar() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        final isTablet = screenWidth > 600;
        
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: AppTheme.primaryColor.withValues(alpha: 0.1),
                offset: const Offset(0, -4),
                blurRadius: 20,
                spreadRadius: 0,
              ),
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                offset: const Offset(0, -2),
                blurRadius: 10,
                spreadRadius: 0,
              ),
            ],
          ),
          child: SafeArea(
            child: Container(
              height: isTablet ? 85 : 75,
              padding: EdgeInsets.symmetric(
                horizontal: isTablet ? 20 : 16,
                vertical: isTablet ? 12 : 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavItem(0, Icons.home_rounded, 'Home', isTablet),
                  _buildNavItem(1, Icons.grid_view_rounded, 'Categories', isTablet),
                  _buildNavItem(2, Icons.local_fire_department_rounded, 'Deals', isTablet),
                  _buildNavItem(3, Icons.shopping_cart_rounded, 'Cart', isTablet),
                  _buildNavItem(4, Icons.person_rounded, 'Profile', isTablet),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label, bool isTablet) {
    final isSelected = _currentBottomIndex == index;
    
    return GestureDetector(
      onTap: () => _handleBottomNavigation(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: EdgeInsets.symmetric(
          horizontal: isTablet ? 16 : 10,
          vertical: isTablet ? 6 : 4,
        ),
        decoration: BoxDecoration(
          color: isSelected 
              ? AppTheme.primaryColor.withValues(alpha: 0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: isSelected 
              ? Border.all(
                  color: AppTheme.primaryColor.withValues(alpha: 0.3),
                  width: 1,
                )
              : null,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: EdgeInsets.all(isTablet ? 6 : 4),
              decoration: BoxDecoration(
                color: isSelected 
                    ? AppTheme.primaryColor
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
                boxShadow: isSelected ? [
                  BoxShadow(
                    color: AppTheme.primaryColor.withValues(alpha: 0.3),
                    offset: const Offset(0, 2),
                    blurRadius: 8,
                    spreadRadius: 0,
                  ),
                ] : null,
              ),
              child: AnimatedScale(
                scale: isSelected ? 1.1 : 1.0,
                duration: const Duration(milliseconds: 200),
                child: Icon(
                  icon,
                  color: isSelected ? Colors.white : AppTheme.textSecondary,
                  size: isTablet ? 24 : 20,
                ),
              ),
            ),
            SizedBox(height: isTablet ? 3 : 1),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              style: GoogleFonts.inter(
                fontSize: isTablet ? 11 : 9,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: isSelected ? AppTheme.primaryColor : AppTheme.textSecondary,
                letterSpacing: 0.2,
              ),
              child: Text(label),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchAnimationController.dispose();
    _categoryIndicatorController.dispose();
    _countdownController.dispose();
    _floatingTagController.dispose();
    _searchFocusNode.dispose();
    _pageController.dispose();
    _countdownTimer?.cancel();
    super.dispose();
  }
}