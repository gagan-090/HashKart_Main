import 'package:flutter/material.dart';
import '../../routes/navigation_helper.dart';
import '../../theme/app_theme.dart';
import '../product/ProductListingScreen.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen>
    with TickerProviderStateMixin {
  int _selectedCategoryIndex = 0;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
        length: 4, vsync: this); // Mobile, Electronics, Fashion, View All
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        setState(() {
          if (_tabController.index == 3) {
            // "View All" tab clicked - navigate to product listing for current category
            NavigationHelper.goToProductListing(
              category: _primaryCategories[_selectedCategoryIndex].name,
            );
          } else if (_tabController.index < _primaryCategories.length) {
            _selectedCategoryIndex = _tabController.index;
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  final List<PrimaryCategory> _primaryCategories = [
    PrimaryCategory(
      id: 'mobile',
      name: 'Mobile',
      icon: Icons.phone_android,
      subCategories: [
        SubCategory(
          id: 'smartphones',
          name: 'Smartphones',
          imageUrl:
              'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=300',
          isTrending: true,
        ),
        SubCategory(
          id: 'tablets',
          name: 'Tablets',
          imageUrl:
              'https://images.unsplash.com/photo-1544244015-0df4b3ffc6b0?w=300',
          isTrending: false,
        ),
        SubCategory(
          id: 'accessories',
          name: 'Accessories',
          imageUrl:
              'https://images.unsplash.com/photo-1583394838336-acd977736f90?w=300',
          isTrending: false,
        ),
        SubCategory(
          id: 'cases',
          name: 'Cases & Covers',
          imageUrl:
              'https://images.unsplash.com/photo-1556656793-08538906a9f8?w=300',
          isTrending: false,
        ),
      ],
    ),
    PrimaryCategory(
      id: 'electronics',
      name: 'Electronics',
      icon: Icons.devices,
      subCategories: [
        SubCategory(
          id: 'smartphones_elec',
          name: 'Smartphones',
          imageUrl:
              'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=300',
          isTrending: true,
        ),
        SubCategory(
          id: 'laptops',
          name: 'Laptops',
          imageUrl:
              'https://images.unsplash.com/photo-1496181133206-80ce9b88a853?w=300',
          isTrending: true,
        ),
        SubCategory(
          id: 'headphones',
          name: 'Headphones',
          imageUrl:
              'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=300',
          isTrending: false,
        ),
        SubCategory(
          id: 'tablets_elec',
          name: 'Tablets',
          imageUrl:
              'https://images.unsplash.com/photo-1544244015-0df4b3ffc6b0?w=300',
          isTrending: false,
        ),
        SubCategory(
          id: 'smartwatches',
          name: 'Smartwatches',
          imageUrl:
              'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=300',
          isTrending: true,
        ),
        SubCategory(
          id: 'gaming_consoles',
          name: 'Gaming Consoles',
          imageUrl:
              'https://images.unsplash.com/photo-1606144042614-b2417e99c4e3?w=300',
          isTrending: false,
        ),
        SubCategory(
          id: 'cameras',
          name: 'Cameras',
          imageUrl:
              'https://images.unsplash.com/photo-1502920917128-1aa500764cbd?w=300',
          isTrending: false,
        ),
        SubCategory(
          id: 'televisions',
          name: 'Televisions',
          imageUrl:
              'https://images.unsplash.com/photo-1593359677879-a4bb92f829d1?w=300',
          isTrending: true,
        ),
      ],
    ),
    PrimaryCategory(
      id: 'fashion',
      name: 'Fashion',
      icon: Icons.checkroom,
      subCategories: [
        SubCategory(
          id: 'men',
          name: 'Men',
          imageUrl:
              'https://images.unsplash.com/photo-1516257984-b1b4d707412e?w=300',
          isTrending: false,
        ),
        SubCategory(
          id: 'women',
          name: 'Women',
          imageUrl:
              'https://images.unsplash.com/photo-1445205170230-053b83016050?w=300',
          isTrending: true,
        ),
        SubCategory(
          id: 'girls',
          name: 'Girls',
          imageUrl:
              'https://images.unsplash.com/photo-1503944168849-4d4f0b4b0e8e?w=300',
          isTrending: false,
        ),
        SubCategory(
          id: 'boys',
          name: 'Boys',
          imageUrl:
              'https://images.unsplash.com/photo-1519238263530-99bdd11df2ea?w=300',
          isTrending: false,
        ),
        SubCategory(
          id: 'kids',
          name: 'Kids',
          imageUrl:
              'https://images.unsplash.com/photo-1514090458221-65bb69cf63e6?w=300',
          isTrending: false,
        ),
        SubCategory(
          id: 'casual_wear',
          name: 'Casual Wear',
          imageUrl:
              'https://images.unsplash.com/photo-1441986300917-64674bd600d8?w=300',
          isTrending: false,
        ),
        SubCategory(
          id: 'formal_wear',
          name: 'Formal Wear',
          imageUrl:
              'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=300',
          isTrending: false,
        ),
        SubCategory(
          id: 'aesthetics',
          name: 'Aesthetics',
          imageUrl:
              'https://images.unsplash.com/photo-1469334031218-e382a71b716b?w=300',
          isTrending: true,
        ),
        SubCategory(
          id: 'accessories_fashion',
          name: 'Accessories',
          imageUrl:
              'https://images.unsplash.com/photo-1492707892479-7bc8d5a4ee93?w=300',
          isTrending: false,
        ),
        SubCategory(
          id: 'footwear',
          name: 'Footwear',
          imageUrl:
              'https://images.unsplash.com/photo-1549298916-b41d501d3772?w=300',
          isTrending: false,
        ),
      ],
    ),
    PrimaryCategory(
      id: 'home_garden',
      name: 'Home & Garden',
      icon: Icons.home,
      subCategories: [
        SubCategory(
          id: 'furniture',
          name: 'Furniture',
          imageUrl:
              'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?w=300',
          isTrending: false,
        ),
        SubCategory(
          id: 'decor',
          name: 'Decor',
          imageUrl:
              'https://images.unsplash.com/photo-1513475382585-d06e58bcb0e0?w=300',
          isTrending: false,
        ),
        SubCategory(
          id: 'kitchenware',
          name: 'Kitchenware',
          imageUrl:
              'https://images.unsplash.com/photo-1556909114-f6e7ad7d3136?w=300',
          isTrending: true,
        ),
        SubCategory(
          id: 'gardening_tools',
          name: 'Gardening Tools',
          imageUrl:
              'https://images.unsplash.com/photo-1416879595882-3373a0480b5b?w=300',
          isTrending: false,
        ),
        SubCategory(
          id: 'appliances',
          name: 'Appliances',
          imageUrl:
              'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=300',
          isTrending: false,
        ),
        SubCategory(
          id: 'lighting',
          name: 'Lighting',
          imageUrl:
              'https://images.unsplash.com/photo-1524484485831-a92ffc0de03f?w=300',
          isTrending: false,
        ),
      ],
    ),
    PrimaryCategory(
      id: 'sports',
      name: 'Sports',
      icon: Icons.sports_soccer,
      subCategories: [
        SubCategory(
          id: 'fitness_equipment',
          name: 'Fitness Equipment',
          imageUrl:
              'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=300',
          isTrending: false,
        ),
        SubCategory(
          id: 'outdoor_sports',
          name: 'Outdoor Sports',
          imageUrl:
              'https://images.unsplash.com/photo-1551698618-1dfe5d97d256?w=300',
          isTrending: true,
        ),
        SubCategory(
          id: 'team_sports',
          name: 'Team Sports',
          imageUrl:
              'https://images.unsplash.com/photo-1579952363873-27d3bfad9c0d?w=300',
          isTrending: false,
        ),
        SubCategory(
          id: 'water_sports',
          name: 'Water Sports',
          imageUrl:
              'https://images.unsplash.com/photo-1544551763-46a013bb70d5?w=300',
          isTrending: false,
        ),
        SubCategory(
          id: 'winter_sports',
          name: 'Winter Sports',
          imageUrl:
              'https://images.unsplash.com/photo-1551524164-6cf2ac8c2b8b?w=300',
          isTrending: false,
        ),
        SubCategory(
          id: 'cycling',
          name: 'Cycling',
          imageUrl:
              'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=300',
          isTrending: false,
        ),
      ],
    ),
    PrimaryCategory(
      id: 'books',
      name: 'Books',
      icon: Icons.menu_book,
      subCategories: [
        SubCategory(
          id: 'fiction',
          name: 'Fiction',
          imageUrl:
              'https://images.unsplash.com/photo-1481627834876-b7833e8f5570?w=300',
          isTrending: false,
        ),
        SubCategory(
          id: 'non_fiction',
          name: 'Non-Fiction',
          imageUrl:
              'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=300',
          isTrending: true,
        ),
        SubCategory(
          id: 'educational',
          name: 'Educational',
          imageUrl:
              'https://images.unsplash.com/photo-1497633762265-9d179a990aa6?w=300',
          isTrending: false,
        ),
        SubCategory(
          id: 'children_books',
          name: 'Children\'s Books',
          imageUrl:
              'https://images.unsplash.com/photo-1544716278-ca5e3f4abd8c?w=300',
          isTrending: false,
        ),
        SubCategory(
          id: 'comics',
          name: 'Comics & Graphic Novels',
          imageUrl:
              'https://images.unsplash.com/photo-1609342122563-a43ac8917a3a?w=300',
          isTrending: false,
        ),
        SubCategory(
          id: 'magazines',
          name: 'Magazines',
          imageUrl:
              'https://images.unsplash.com/photo-1586953208448-b95a79798f07?w=300',
          isTrending: false,
        ),
      ],
    ),
    PrimaryCategory(
      id: 'beauty',
      name: 'Beauty',
      icon: Icons.face_retouching_natural,
      subCategories: [
        SubCategory(
          id: 'skincare',
          name: 'Skincare',
          imageUrl:
              'https://images.unsplash.com/photo-1596462502278-27bfdc403348?w=300',
          isTrending: true,
        ),
        SubCategory(
          id: 'makeup',
          name: 'Makeup',
          imageUrl:
              'https://images.unsplash.com/photo-1522335789203-aabd1fc54bc9?w=300',
          isTrending: false,
        ),
        SubCategory(
          id: 'hair_care',
          name: 'Hair Care',
          imageUrl:
              'https://images.unsplash.com/photo-1519699047748-de8e457a634e?w=300',
          isTrending: false,
        ),
        SubCategory(
          id: 'fragrance',
          name: 'Fragrance',
          imageUrl:
              'https://images.unsplash.com/photo-1541643600914-78b084683601?w=300',
          isTrending: false,
        ),
        SubCategory(
          id: 'beauty_tools',
          name: 'Beauty Tools',
          imageUrl:
              'https://images.unsplash.com/photo-1560472354-b33ff0c44a43?w=300',
          isTrending: false,
        ),
        SubCategory(
          id: 'mens_grooming',
          name: 'Men\'s Grooming',
          imageUrl:
              'https://images.unsplash.com/photo-1503951914875-452162b0f3f1?w=300',
          isTrending: false,
        ),
      ],
    ),
    PrimaryCategory(
      id: 'automotive',
      name: 'Automotive',
      icon: Icons.directions_car,
      subCategories: [
        SubCategory(
          id: 'car_parts',
          name: 'Car Parts',
          imageUrl:
              'https://images.unsplash.com/photo-1486262715619-67b85e0b08d3?w=300',
          isTrending: false,
        ),
        SubCategory(
          id: 'car_accessories',
          name: 'Car Accessories',
          imageUrl:
              'https://images.unsplash.com/photo-1449824913935-59a10b8d2000?w=300',
          isTrending: false,
        ),
        SubCategory(
          id: 'car_care',
          name: 'Car Care',
          imageUrl:
              'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=300',
          isTrending: false,
        ),
        SubCategory(
          id: 'tools_equipment',
          name: 'Tools & Equipment',
          imageUrl:
              'https://images.unsplash.com/photo-1581833971358-2c8b550f87b3?w=300',
          isTrending: true,
        ),
      ],
    ),
    PrimaryCategory(
      id: 'health_wellness',
      name: 'Health & Wellness',
      icon: Icons.health_and_safety,
      subCategories: [
        SubCategory(
          id: 'vitamins_supplements',
          name: 'Supplements',
          imageUrl:
              'https://images.unsplash.com/photo-1559757148-5c350d0d3c56?w=300',
          isTrending: false,
        ),
        SubCategory(
          id: 'fitness',
          name: 'Fitness',
          imageUrl:
              'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=300',
          isTrending: true,
        ),
        SubCategory(
          id: 'personal_care',
          name: 'Personal Care',
          imageUrl:
              'https://images.unsplash.com/photo-1556228578-8c89e6adf883?w=300',
          isTrending: false,
        ),
        SubCategory(
          id: 'medical_devices',
          name: 'Medical Devices',
          imageUrl:
              'https://images.unsplash.com/photo-1559757175-0eb30cd8c063?w=300',
          isTrending: false,
        ),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 2,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppTheme.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Categories',
          style: AppTheme.heading3.copyWith(color: AppTheme.textPrimary),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search_rounded, color: AppTheme.textPrimary),
            onPressed: () => NavigationHelper.goToSearch(),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.03),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
              labelColor: AppTheme.primaryColor,
              unselectedLabelColor: AppTheme.textSecondary,
              indicatorColor: AppTheme.primaryColor,
              indicatorWeight: 3,
              indicatorSize: TabBarIndicatorSize.label,
              dividerColor: Colors.transparent,
              labelStyle: AppTheme.bodyMedium.copyWith(fontWeight: FontWeight.w600),
              unselectedLabelStyle: AppTheme.bodyMedium,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              tabs: const [
                Tab(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.phone_android_rounded, size: 20),
                      SizedBox(width: 8),
                      Text('Mobile'),
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.devices_rounded, size: 20),
                      SizedBox(width: 8),
                      Text('Electronics'),
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.checkroom_rounded, size: 20),
                      SizedBox(width: 8),
                      Text('Fashion'),
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.grid_view_rounded, size: 20),
                      SizedBox(width: 8),
                      Text('View All'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Row(
        children: [
          // Left Vertical Navigation (Primary Categories)
          _buildPrimaryCategoryList(),

          // Right Content Grid (Sub-Category Previews)
          Expanded(
            child: Container(
              color: AppTheme.backgroundColor,
              padding: const EdgeInsets.all(16),
              child: _buildSubCategoryGrid(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubCategoryGrid() {
    final currentCategory = _primaryCategories[_selectedCategoryIndex];
    final subCategories = currentCategory.subCategories;

    if (subCategories.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.category_outlined, size: 64, color: AppTheme.textLight),
            const SizedBox(height: 16),
            Text(
              'No subcategories available',
              style: AppTheme.bodyMedium.copyWith(color: AppTheme.textSecondary),
            ),
          ],
        ),
      );
    }

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.85,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      padding: const EdgeInsets.all(16),
      physics: const BouncingScrollPhysics(),
      itemCount: subCategories.length,
      itemBuilder: (context, index) {
        final subCategory = subCategories[index];
        return _buildSubCategoryCard(subCategory);
      },
    );
  }

  Widget _buildSubCategoryCard(SubCategory subCategory) {
    return Hero(
      tag: 'subcategory_${subCategory.id ?? subCategory.name}',
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          splashColor: AppTheme.primaryColor.withOpacity(0.1),
          highlightColor: AppTheme.primaryColor.withOpacity(0.05),
          onTap: () {
            // Navigate to full product listing screen for specific sub-category
            NavigationHelper.goToProductListing(
              category: _primaryCategories[_selectedCategoryIndex].name,
              subCategory: subCategory.name,
            );
          },
          borderRadius: BorderRadius.circular(16),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Stack(
              children: [
                // Sub-Category Image with shimmer loading effect
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: Image.network(
                      subCategory.imageUrl,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.grey[300]!,
                                Colors.grey[100]!,
                                Colors.grey[300]!,
                              ],
                              stops: const [0.1, 0.3, 0.4],
                              begin: const Alignment(-1.0, -0.3),
                              end: const Alignment(1.0, 0.3),
                              tileMode: TileMode.clamp,
                            ),
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: AppTheme.primaryColor.withOpacity(0.1),
                          child: const Icon(
                            Icons.image_outlined,
                            size: 50,
                            color: AppTheme.primaryColor,
                          ),
                        );
                      },
                    ),
                  ),
                ),

                // Gradient Overlay for text readability
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.7),
                      ],
                    ),
                  ),
                ),

                // Trending Badge
                if (subCategory.isTrending)
                  Positioned(
                    top: 12,
                    right: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppTheme.accentColor,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: AppTheme.accentColor.withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.local_fire_department_rounded,
                            color: Colors.white,
                            size: 14,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'TRENDING',
                            style: AppTheme.bodySmall.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                // Sub-Category Label
                Positioned(
                  bottom: 16,
                  left: 16,
                  right: 16,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        subCategory.name,
                        style: AppTheme.bodyMedium.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          '${(subCategory.name.length * 3) % 20 + 5} Products', // Simulated product count
                          style: AppTheme.bodySmall.copyWith(
                             color: Colors.white,
                             fontSize: 10,
                           ),
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
     );
   }
                    // Build the primary category list with modern UI
  Widget _buildPrimaryCategoryList() {
    return Container(
      width: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(2, 0),
          ),
        ],
      ),
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 16),
        itemCount: _primaryCategories.length,
        itemBuilder: (context, index) {
          final category = _primaryCategories[index];
          final isSelected = index == _selectedCategoryIndex;
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedCategoryIndex = index;
              });
              // Sync tab controller if within the first 3 categories
              if (index < 3) {
                _tabController.animateTo(index);
              }
              // Show subcategories in side screen for the selected category
              _showSubcategoriesSideScreen(context, category);
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
              decoration: BoxDecoration(
                color: isSelected ? AppTheme.primaryColor.withOpacity(0.1) : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
                border: isSelected
                    ? Border.all(color: AppTheme.primaryColor, width: 1.5)
                    : null,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: isSelected ? AppTheme.primaryColor : Colors.grey[100],
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      _getCategoryIcon(_primaryCategories[index].name),
                      color: isSelected ? Colors.white : Colors.grey[600],
                      size: 24,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _primaryCategories[index].name,
                    style: AppTheme.bodySmall.copyWith(
                      color: isSelected ? AppTheme.primaryColor : AppTheme.textSecondary,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // Helper method to get category icons
  IconData _getCategoryIcon(String categoryName) {
    switch (categoryName.toLowerCase()) {
      case 'mobile':
        return Icons.smartphone_rounded;
      case 'electronics':
        return Icons.devices_rounded;
      case 'fashion':
        return Icons.shopping_bag_rounded;
      case 'home & furniture':
        return Icons.chair_rounded;
      case 'beauty':
        return Icons.face_retouching_natural_rounded;
      case 'toys & baby':
        return Icons.toys_rounded;
      case 'sports':
        return Icons.sports_soccer_rounded;
      case 'automotive':
        return Icons.directions_car_rounded;
      case 'health & wellness':
        return Icons.favorite_rounded;
      default:
        return Icons.category_rounded;
    }
  }
  // This is a placeholder for the closing brackets of the _getCategoryIcon method
  

  void _showSubcategoriesSideScreen(BuildContext context, PrimaryCategory category) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.4,
        maxChildSize: 0.9,
        builder: (context, scrollController) {
          return Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              children: [
                // Handle bar
                Container(
                  margin: const EdgeInsets.only(top: 12, bottom: 20),
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                // Header
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Icon(category.icon,
                          color: AppTheme.primaryColor, size: 24),
                      const SizedBox(width: 12),
                      Text(
                        category.name,
                        style: AppTheme.heading2.copyWith(
                          color: AppTheme.textPrimary,
                        ),
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          NavigationHelper.goToProductListing(
                            category: category.name,
                          );
                        },
                        child: Text(
                          'View All',
                          style: AppTheme.bodyMedium.copyWith(
                            color: AppTheme.primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                // Subcategories Grid
                Expanded(
                  child: GridView.builder(
                    controller: scrollController,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.85,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemCount: category.subCategories.length,
                    itemBuilder: (context, index) {
                      final subCategory = category.subCategories[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          NavigationHelper.goToProductListing(
                            category: category.name,
                            subCategory: subCategory.name,
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Stack(
                            children: [
                              // Subcategory Image
                              ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: SizedBox(
                                  width: double.infinity,
                                  height: double.infinity,
                                  child: Image.network(
                                    subCategory.imageUrl,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        color: AppTheme.primaryColor
                                            .withOpacity(0.1),
                                        child: Icon(
                                          category.icon,
                                          size: 50,
                                          color: AppTheme.primaryColor,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              // Gradient Overlay
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.transparent,
                                      Colors.black.withOpacity(0.7),
                                    ],
                                  ),
                                ),
                              ),
                              // Trending Badge
                              if (index % 3 == 0)
                                Positioned(
                                  top: 12,
                                  right: 12,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: AppTheme.accentColor,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      'TRENDING',
                                      style: AppTheme.bodySmall.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ),
                                ),
                              // Subcategory Label
                              Positioned(
                                bottom: 16,
                                left: 16,
                                right: 16,
                                child: Text(
                                  subCategory.name,
                                  style: AppTheme.bodyMedium.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    shadows: [
                                      Shadow(
                                        color:
                                            Colors.black.withOpacity(0.5),
                                        blurRadius: 4,
                                      ),
                                    ],
                                  ),
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
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
          );
        },
      ),
    );
  }

  void _showProductListingSideScreen(BuildContext context, String category, String? subCategory) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.9,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        builder: (context, scrollController) {
          return Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: ProductListingScreen(
              category: category,
              subCategory: subCategory,
            ),
          );
        },
      ),
    );
  }
}

class PrimaryCategory {
  final String id;
  final String name;
  final IconData icon;
  final List<SubCategory> subCategories;

  PrimaryCategory({
    required this.id,
    required this.name,
    required this.icon,
    required this.subCategories,
  });
}

class SubCategory {
  final String id;
  final String name;
  final String imageUrl;
  final bool isTrending;

  SubCategory({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.isTrending,
  });
}
