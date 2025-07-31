import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../models/product_model.dart';

class BeautyCategoryScreen extends StatefulWidget {
  const BeautyCategoryScreen({super.key});

  @override
  State<BeautyCategoryScreen> createState() => _BeautyCategoryScreenState();
}

class _BeautyCategoryScreenState extends State<BeautyCategoryScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  final List<String> _activeFilters = ['skincare', 'makeup'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  // Enhanced Beauty product data with proper images
  final List<Product> _featuredProducts = [
    Product(
      id: 'vitamin_c_serum',
      name: 'Vitamin C Brightening Serum',
      price: 'Rs.1,29',
      originalPrice: 'Rs.1,59',
      rating: 4.8,
      categoryId: 'skincare',
      brand: 'Glow & Co',
      imageUrls: [
        'https://images.unsplash.com/photo-1620916566398-39f1143ab7be?w=400',
      ],
      description: 'Brightening serum with 20% Vitamin C for radiant skin',
      isFeatured: true,
    ),
    Product(
      id: 'hyaluronic_acid',
      name: 'Hyaluronic Acid Serum',
      price: 'Rs.899',
      originalPrice: 'Rs.1,199',
      rating: 4.7,
      categoryId: 'skincare',
      brand: 'HydraGlow',
      imageUrls: [
        'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=400',
      ],
      description: 'Deep hydration serum for plump, youthful skin',
      isFeatured: true,
    ),
    Product(
      id: 'retinol_cream',
      name: 'Anti-Aging Retinol Cream',
      price: 'Rs.1,899',
      originalPrice: 'Rs.2,299',
      rating: 4.6,
      categoryId: 'skincare',
      brand: 'Youth Restore',
      imageUrls: [
        'https://images.unsplash.com/photo-1556228720-195a672e8a03?w=400',
      ],
      description: 'Powerful anti-aging cream with retinol complex',
      isFeatured: true,
    ),
    Product(
      id: 'niacinamide_serum',
      name: 'Niacinamide 10% Serum',
      price: 'Rs.699',
      originalPrice: 'Rs.899',
      rating: 4.5,
      categoryId: 'skincare',
      brand: 'Clear Skin',
      imageUrls: [
        'https://images.unsplash.com/photo-1608248543803-ba4f8c70ae0b?w=400',
      ],
      description: 'Pore-minimizing serum for clearer skin',
      isFeatured: true,
    ),
    Product(
      id: 'sunscreen_spf50',
      name: 'Broad Spectrum SPF 50',
      price: 'Rs.799',
      originalPrice: 'Rs.999',
      rating: 4.9,
      categoryId: 'skincare',
      brand: 'Sun Shield',
      imageUrls: [
        'https://images.unsplash.com/photo-1556228578-8c89e6adf883?w=400',
      ],
      description: 'Lightweight sunscreen with broad spectrum protection',
      isFeatured: true,
    ),
  ];

  final List<Product> _popularProducts = [
    Product(
      id: 'matte_lipstick',
      name: 'Velvet Matte Lipstick',
      price: 'Rs.599',
      originalPrice: 'Rs.799',
      rating: 4.4,
      categoryId: 'makeup',
      brand: 'Luxe Beauty',
      imageUrls: [
        'https://images.unsplash.com/photo-1586495777744-4413f21062fa?w=400',
      ],
      description: 'Long-lasting matte lipstick in 12 stunning shades',
      colors: ['Ruby Red', 'Rose Pink', 'Berry Crush', 'Nude Beige'],
    ),
    Product(
      id: 'foundation_stick',
      name: 'Full Coverage Foundation',
      price: 'Rs.1,299',
      originalPrice: 'Rs.1,599',
      rating: 4.3,
      categoryId: 'makeup',
      brand: 'Perfect Base',
      imageUrls: [
        'https://images.unsplash.com/photo-1596462502278-27bfdc403348?w=400',
      ],
      description: 'Buildable foundation for flawless coverage',
      colors: ['Fair', 'Light', 'Medium', 'Deep'],
    ),
    Product(
      id: 'eyeshadow_palette',
      name: 'Smokey Eyes Palette',
      price: 'Rs.1,899',
      originalPrice: 'Rs.2,299',
      rating: 4.6,
      categoryId: 'makeup',
      brand: 'Color Pop',
      imageUrls: [
        'https://images.unsplash.com/photo-1512496015851-a90fb38ba796?w=400',
      ],
      description: '18 highly pigmented eyeshadows for stunning looks',
    ),
    Product(
      id: 'mascara_volume',
      name: 'Volume Boost Mascara',
      price: 'Rs.899',
      originalPrice: 'Rs.1,199',
      rating: 4.5,
      categoryId: 'makeup',
      brand: 'Lash Perfect',
      imageUrls: [
        'https://images.unsplash.com/photo-1631214540242-3cd8c4b6b9e8?w=400',
      ],
      description: 'Dramatic volume and length for stunning lashes',
    ),
    Product(
      id: 'blush_palette',
      name: 'Blush & Highlight Duo',
      price: 'Rs.1,199',
      originalPrice: 'Rs.1,499',
      rating: 4.7,
      categoryId: 'makeup',
      brand: 'Glow Beauty',
      imageUrls: [
        'https://images.unsplash.com/photo-1522335789203-aabd1fc54bc9?w=400',
      ],
      description: 'Perfect blush and highlighter combination',
    ),
    Product(
      id: 'lip_gloss',
      name: 'Glossy Lip Tint',
      price: 'Rs.499',
      originalPrice: 'Rs.699',
      rating: 4.2,
      categoryId: 'makeup',
      brand: 'Shine Lips',
      imageUrls: [
        'https://images.unsplash.com/photo-1583001931096-959e9a1a6223?w=400',
      ],
      description: 'Hydrating lip gloss with natural tint',
    ),
  ];

  final List<Product> _trendingProducts = [
    Product(
      id: 'face_mask_set',
      name: 'Korean Sheet Mask Set',
      price: 'Rs.999',
      originalPrice: 'Rs.1,299',
      rating: 4.8,
      categoryId: 'skincare',
      brand: 'K-Beauty',
      imageUrls: [
        'https://images.unsplash.com/photo-1570194065650-d99fb4bedf0a?w=400',
      ],
      description: '10-piece sheet mask set for various skin concerns',
      isTrending: true,
    ),
    Product(
      id: 'jade_roller',
      name: 'Jade Facial Roller',
      price: 'Rs.799',
      originalPrice: 'Rs.999',
      rating: 4.4,
      categoryId: 'skincare',
      brand: 'Gua Sha Tools',
      imageUrls: [
        'https://images.unsplash.com/photo-1596755389378-c31d21fd1273?w=400',
      ],
      description:
          'Natural jade roller for facial massage and lymphatic drainage',
      isTrending: true,
    ),
    Product(
      id: 'setting_spray',
      name: 'All-Day Setting Spray',
      price: 'Rs.699',
      originalPrice: 'Rs.899',
      rating: 4.6,
      categoryId: 'makeup',
      brand: 'Lock & Set',
      imageUrls: [
        'https://images.unsplash.com/photo-1596755389378-c31d21fd1273?w=400',
      ],
      description: 'Long-lasting makeup setting spray',
      isTrending: true,
    ),
  ];

  final List<Product> _newArrivals = [
    Product(
      id: 'peptide_cream',
      name: 'Peptide Recovery Cream',
      price: 'Rs.2,299',
      originalPrice: 'Rs.2,799',
      rating: 4.9,
      categoryId: 'skincare',
      brand: 'Advanced Care',
      imageUrls: [
        'https://images.unsplash.com/photo-1556228578-8c89e6adf883?w=400',
      ],
      description: 'Advanced peptide cream for skin repair and renewal',
      isNewArrival: true,
    ),
    Product(
      id: 'liquid_eyeliner',
      name: 'Precision Liquid Eyeliner',
      price: 'Rs.799',
      originalPrice: 'Rs.999',
      rating: 4.5,
      categoryId: 'makeup',
      brand: 'Line Perfect',
      imageUrls: [
        'https://images.unsplash.com/photo-1631214540242-3cd8c4b6b9e8?w=400',
      ],
      description: 'Waterproof liquid eyeliner with precision tip',
      isNewArrival: true,
    ),
  ];

  void _removeFilter(String filter) {
    setState(() {
      _activeFilters.remove(filter);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFEFE),
      body: CustomScrollView(
        slivers: [
          // Enhanced Header Section
          SliverAppBar(
            expandedHeight: 160,
            floating: false,
            pinned: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFFFFFEFE),
                      Color(0xFFFEEFF4),
                      Color(0xFFFECFD6),
                    ],
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                    child: Column(
                      children: [
                        // Enhanced Greeting and Profile
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  'Discover Beauty',
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    color: AppTheme.textPrimary,
                                    fontFamily: 'Inter',
                                  ),
                                ),
                                Text(
                                  'Find your perfect glow ✨',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: AppTheme.textSecondary,
                                    fontFamily: 'Inter',
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              width: 45,
                              height: 45,
                              decoration: const BoxDecoration(
                                // Remove 'const' before LinearGradient
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xFFFF6F91),
                                    Color(0xFFFF8FA3)
                                  ],
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(22.5)),
                                // Remove 'const' before BoxShadow
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0x4DFF6F91),
                                    blurRadius: 8,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.person,
                                color: Colors.white,
                                size: 22,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        // Enhanced Search Bar
                        Container(
                          height: 52,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x14000000),
                                blurRadius: 12,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              const SizedBox(width: 18),
                              const Icon(
                                Icons.search,
                                color: Color(0xFFFF6F91),
                                size: 22,
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: TextField(
                                  controller: _searchController,
                                  decoration: const InputDecoration(
                                    hintText: 'Search beauty products...',
                                    hintStyle: TextStyle(
                                      color: Color(0xFFB8B8B8),
                                      fontSize: 16,
                                    ),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(right: 14),
                                width: 36,
                                height: 36,
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFFFF6F91),
                                      Color(0xFFFF8FA3)
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Icon(
                                  Icons.tune,
                                  color: Colors.white,
                                  size: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Search Tags/Filters
          if (_activeFilters.isNotEmpty)
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
                child: Wrap(
                  spacing: 8,
                  children: _activeFilters.map((filter) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFEEFF4),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: const Color(0xFFFECFD6),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            filter,
                            style: const TextStyle(
                              color: Color(0xFFFF6F91),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(width: 4),
                          GestureDetector(
                            onTap: () => _removeFilter(filter),
                            child: const Icon(
                              Icons.close,
                              size: 14,
                              color: Color(0xFFFF6F91),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),

          // Tab Navigation
          SliverPersistentHeader(
            pinned: true,
            delegate: _SliverAppBarDelegate(
              TabBar(
                controller: _tabController,
                indicatorColor: const Color(0xFFFF6F91),
                indicatorWeight: 3,
                indicatorSize: TabBarIndicatorSize.label,
                labelColor: const Color(0xFFFF6F91),
                unselectedLabelColor: const Color(0xFFB8B8B8),
                labelStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Inter',
                ),
                unselectedLabelStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Inter',
                ),
                tabs: const [
                  Tab(text: 'Face'),
                  Tab(text: 'Body'),
                  Tab(text: 'Hair'),
                  Tab(text: 'Gifts'),
                ],
              ),
            ),
          ),

          // Enhanced Content with Banner and Multiple Sections
          SliverToBoxAdapter(
            child: Column(
              children: [
                // Beauty Banner Section
                Container(
                  margin: const EdgeInsets.all(20),
                  height: 180,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFFFF6F91),
                        Color(0xFFFF8FA3),
                        Color(0xFFFFA8B5),
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        // Use correct method to create a color with alpha
                        color: const Color(0xFFFF6F91).withValues(alpha: 0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        right: -20,
                        top: -20,
                        child: Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            // Use correct method to create a color with alpha
                            color: Colors.white.withValues(alpha: 0.1),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      Positioned(
                        right: 40,
                        bottom: -30,
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            // Use correct method to create a color with alpha
                            color: Colors.white.withValues(alpha: 0.1),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Summer Beauty Sale',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontFamily: 'Inter',
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Up to 50% off on skincare\n& makeup essentials',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontFamily: 'Inter',
                                height: 1.3,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: const Text(
                                'Shop Now',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFFFF6F91),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Featured Products Section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Featured Products',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.textPrimary,
                              fontFamily: 'Inter',
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              'View All',
                              style: TextStyle(
                                color: Color(0xFFFF6F91),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        height: 240,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _featuredProducts.length,
                          itemBuilder: (context, index) {
                            final product = _featuredProducts[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  '/product-details',
                                  arguments: product,
                                );
                              },
                              child: Container(
                                width: 180,
                                margin: const EdgeInsets.only(right: 16),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      // Use correct method to create a color with alpha
                                      color: Colors.black.withValues(alpha: 0.08),
                                      blurRadius: 15,
                                      offset: const Offset(0, 5),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Container(
                                        padding: const EdgeInsets.all(16),
                                        child: Stack(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              child: Image.network(
                                                product.imageUrls.first,
                                                width: double.infinity,
                                                fit: BoxFit.cover,
                                                errorBuilder:
                                                    (context, error, stackTrace) {
                                                  return Container(
                                                    decoration: BoxDecoration(
                                                      color:
                                                          const Color(0xFFFEEFF4),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16),
                                                    ),
                                                    child: const Icon(
                                                      Icons.image,
                                                      color: Color(0xFFFF6F91),
                                                      size: 40,
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                            if (product.isFeatured)
                                              Positioned(
                                                top: 8,
                                                left: 8,
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                    horizontal: 8,
                                                    vertical: 4,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color:
                                                        const Color(0xFFFF6F91),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                  ),
                                                  child: const Text(
                                                    'Featured',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 10,
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            16, 0, 16, 16),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              product.brand,
                                              style: const TextStyle(
                                                fontSize: 12,
                                                color: Color(0xFFFF6F91),
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            const SizedBox(height: 2),
                                            Text(
                                              product.name,
                                              style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: AppTheme.textPrimary,
                                              ),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            const Spacer(),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      product.price,
                                                      style: const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color:
                                                            AppTheme.textPrimary,
                                                      ),
                                                    ),
                                                    Text(
                                                      product.originalPrice,
                                                      style: const TextStyle(
                                                        fontSize: 12,
                                                        color: AppTheme
                                                            .textSecondary,
                                                        decoration: TextDecoration
                                                            .lineThrough,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Container(
                                                  width: 36,
                                                  height: 36,
                                                  decoration: BoxDecoration(
                                                    gradient:
                                                        const LinearGradient(
                                                      colors: [
                                                        Color(0xFFFF6F91),
                                                        Color(0xFFFF8FA3)
                                                      ],
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(18),
                                                  ),
                                                  child: const Icon(
                                                    Icons.favorite_border,
                                                    color: Colors.white,
                                                    size: 18,
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
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                // Trending Now Section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Trending Now 🔥',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.textPrimary,
                              fontFamily: 'Inter',
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              'View All',
                              style: TextStyle(
                                color: Color(0xFFFF6F91),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        height: 200,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _trendingProducts.length,
                          itemBuilder: (context, index) {
                            final product = _trendingProducts[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  '/product-details',
                                  arguments: product,
                                );
                              },
                              child: Container(
                                width: 160,
                                margin: const EdgeInsets.only(right: 16),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(
                                      // Use correct method to create a color with alpha
                                      color: Colors.black.withOpacity(0.08),
                                      blurRadius: 12,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Container(
                                        padding: const EdgeInsets.all(12),
                                        child: Stack(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              child: Image.network(
                                                product.imageUrls.first,
                                                width: double.infinity,
                                                fit: BoxFit.cover,
                                                errorBuilder:
                                                    (context, error, stackTrace) {
                                                  return Container(
                                                    decoration: BoxDecoration(
                                                      color:
                                                          const Color(0xFFFEEFF4),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                    ),
                                                    child: const Icon(
                                                      Icons.image,
                                                      color: Color(0xFFFF6F91),
                                                      size: 30,
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                            Positioned(
                                              top: 6,
                                              right: 6,
                                              child: Container(
                                                padding: const EdgeInsets.all(4),
                                                decoration: const BoxDecoration(
                                                  color: Colors.orange,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: const Icon(
                                                  Icons.local_fire_department,
                                                  color: Colors.white,
                                                  size: 12,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Padding(
                                        padding: const EdgeInsets.all(12),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              product.name,
                                              style: const TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w600,
                                                color: AppTheme.textPrimary,
                                              ),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            const Spacer(),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  product.price,
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    color: AppTheme.textPrimary,
                                                  ),
                                                ),
                                                Container(
                                                  width: 28,
                                                  height: 28,
                                                  decoration: BoxDecoration(
                                                    color:
                                                        const Color(0xFFFECFD6),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            14),
                                                  ),
                                                  child: const Icon(
                                                    Icons.add,
                                                    color: Color(0xFFFF6F91),
                                                    size: 16,
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
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                // Popular Products Grid Section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Popular Products',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.textPrimary,
                          fontFamily: 'Inter',
                        ),
                      ),
                      const SizedBox(height: 16),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.75,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                        ),
                        itemCount: _popularProducts.length,
                        itemBuilder: (context, index) {
                          final product = _popularProducts[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                '/product-details',
                                arguments: product,
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    // Use correct method to create a color with alpha
                                    color: Colors.black.withValues(alpha: 0.08),
                                    blurRadius: 15,
                                    offset: const Offset(0, 5),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Container(
                                      padding: const EdgeInsets.all(16),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(16),
                                        child: Image.network(
                                          product.imageUrls.first,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return Container(
                                              decoration: BoxDecoration(
                                                color: const Color(0xFFFEEFF4),
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                              ),
                                              child: const Icon(
                                                Icons.image,
                                                color: Color(0xFFFF6F91),
                                                size: 40,
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            product.brand,
                                            style: const TextStyle(
                                              fontSize: 11,
                                              color: Color(0xFFFF6F91),
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          const SizedBox(height: 2),
                                          Text(
                                            product.name,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: AppTheme.textPrimary,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const Spacer(),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    product.price,
                                                    style: const TextStyle(
                                                      fontSize: 15,
                                                      fontWeight: FontWeight.bold,
                                                      color: AppTheme.textPrimary,
                                                    ),
                                                  ),
                                                  Text(
                                                    product.originalPrice,
                                                    style: const TextStyle(
                                                      fontSize: 11,
                                                      color:
                                                          AppTheme.textSecondary,
                                                      decoration: TextDecoration
                                                          .lineThrough,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                width: 32,
                                                height: 32,
                                                decoration: BoxDecoration(
                                                  gradient: const LinearGradient(
                                                    colors: [
                                                      Color(0xFFFF6F91),
                                                      Color(0xFFFF8FA3)
                                                    ],
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                ),
                                                child: const Icon(
                                                  Icons.add,
                                                  color: Colors.white,
                                                  size: 18,
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
                          );
                        },
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                // New Arrivals Section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'New Arrivals ✨',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.textPrimary,
                              fontFamily: 'Inter',
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              'View All',
                              style: TextStyle(
                                color: Color(0xFFFF6F91),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        height: 200,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _newArrivals.length,
                          itemBuilder: (context, index) {
                            final product = _newArrivals[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  '/product-details',
                                  arguments: product,
                                );
                              },
                              child: Container(
                                width: 160,
                                margin: const EdgeInsets.only(right: 16),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(
                                      // Use correct method to create a color with alpha
                                      color: Colors.black.withOpacity(0.08),
                                      blurRadius: 12,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Container(
                                        padding: const EdgeInsets.all(12),
                                        child: Stack(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              child: Image.network(
                                                product.imageUrls.first,
                                                width: double.infinity,
                                                fit: BoxFit.cover,
                                                errorBuilder:
                                                    (context, error, stackTrace) {
                                                  return Container(
                                                    decoration: BoxDecoration(
                                                      color:
                                                          const Color(0xFFFEEFF4),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                    ),
                                                    child: const Icon(
                                                      Icons.image,
                                                      color: Color(0xFFFF6F91),
                                                      size: 30,
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                            Positioned(
                                              top: 6,
                                              left: 6,
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 6,
                                                  vertical: 3,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: Colors.green,
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                child: const Text(
                                                  'NEW',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 9,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Padding(
                                        padding: const EdgeInsets.all(12),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              product.name,
                                              style: const TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w600,
                                                color: AppTheme.textPrimary,
                                              ),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            const Spacer(),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  product.price,
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    color: AppTheme.textPrimary,
                                                  ),
                                                ),
                                                Container(
                                                  width: 28,
                                                  height: 28,
                                                  decoration: BoxDecoration(
                                                    color:
                                                        const Color(0xFFFECFD6),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            14),
                                                  ),
                                                  child: const Icon(
                                                    Icons.add,
                                                    color: Color(0xFFFF6F91),
                                                    size: 16,
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
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;

  const _SliverAppBarDelegate(this._tabBar);

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      color: const Color(0xFFFFFEFE),
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}