import 'package:flutter/material.dart';
import '../../routes/navigation_helper.dart';
import '../../theme/app_theme.dart';
import '../../widgets/common_widgets.dart';

class ProductListingScreen extends StatefulWidget {
  final String category;
  final String? subCategory;

  const ProductListingScreen({
    super.key,
    required this.category,
    this.subCategory,
  });

  @override
  State<ProductListingScreen> createState() => _ProductListingScreenState();
}

class _ProductListingScreenState extends State<ProductListingScreen> {
  bool _isGridView = true;
  String _sortBy = 'popularity';
  List<ProductItem> _products = [];
  List<ProductItem> _filteredProducts = [];

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  void _loadProducts() {
    // Mock data based on category and subcategory
    _products = _generateMockProducts();
    _filteredProducts = List.from(_products);
  }

  List<ProductItem> _generateMockProducts() {
    // Generate products based on category and subcategory
    if (widget.category == 'Electronics') {
      if (widget.subCategory == 'Smartphones') {
        return _getSmartphones();
      } else if (widget.subCategory == 'Laptops') {
        return _getLaptops();
      } else if (widget.subCategory == 'Headphones') {
        return _getHeadphones();
      } else if (widget.subCategory == 'Smartwatches') {
        return _getSmartwatches();
      } else if (widget.subCategory == 'Gaming Consoles') {
        return _getGamingConsoles();
      } else if (widget.subCategory == 'Cameras') {
        return _getCameras();
      } else if (widget.subCategory == 'Televisions') {
        return _getTelevisions();
      } else {
        return _getAllElectronics();
      }
    } else if (widget.category == 'Mobile') {
      return _getMobileProducts();
    } else if (widget.category == 'Fashion') {
      return _getFashionProducts();
    } else if (widget.category == 'Home & Garden') {
      return _getHomeGardenProducts();
    } else if (widget.category == 'Sports') {
      return _getSportsProducts();
    } else if (widget.category == 'Books') {
      return _getBooksProducts();
    } else if (widget.category == 'Beauty') {
      return _getBeautyProducts();
    } else if (widget.category == 'Automotive') {
      return _getAutomotiveProducts();
    } else if (widget.category == 'Health & Wellness') {
      return _getHealthWellnessProducts();
    }
    
    return _getAllProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppTheme.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.subCategory ?? widget.category,
              style: AppTheme.heading3.copyWith(
                color: AppTheme.textPrimary,
                fontSize: 18,
              ),
            ),
            if (widget.subCategory != null)
              Text(
                widget.category,
                style: AppTheme.bodySmall.copyWith(
                  color: AppTheme.textSecondary,
                ),
              ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: AppTheme.textPrimary),
            onPressed: () => NavigationHelper.goToSearch(),
          ),
          IconButton(
            icon: Icon(
              _isGridView ? Icons.view_list : Icons.grid_view,
              color: AppTheme.textPrimary,
            ),
            onPressed: () {
              setState(() {
                _isGridView = !_isGridView;
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Filter and Sort Bar
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Text(
                  '${_filteredProducts.length} Products',
                  style: AppTheme.bodyMedium.copyWith(
                    color: AppTheme.textSecondary,
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () => NavigationHelper.goToFilter(),
                  child: Row(
                    children: [
                      const Icon(Icons.tune, size: 20, color: AppTheme.textSecondary),
                      const SizedBox(width: 4),
                      Text(
                        'Filter',
                        style: AppTheme.bodyMedium.copyWith(
                          color: AppTheme.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                GestureDetector(
                  onTap: _showSortOptions,
                  child: Row(
                    children: [
                      const Icon(Icons.sort, size: 20, color: AppTheme.textSecondary),
                      const SizedBox(width: 4),
                      Text(
                        'Sort',
                        style: AppTheme.bodyMedium.copyWith(
                          color: AppTheme.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Products List/Grid
          Expanded(
            child: _isGridView ? _buildGridView() : _buildListView(),
          ),
        ],
      ),
    );
  }

  Widget _buildGridView() {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: _filteredProducts.length,
      itemBuilder: (context, index) {
        final product = _filteredProducts[index];
        return _buildProductGridCard(product);
      },
    );
  }

  Widget _buildListView() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _filteredProducts.length,
      itemBuilder: (context, index) {
        final product = _filteredProducts[index];
        return _buildProductListCard(product);
      },
    );
  }

  Widget _buildProductGridCard(ProductItem product) {
    return GestureDetector(
      onTap: () => _showProductDetails(product),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: IntrinsicHeight(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                    child: AspectRatio(
                      aspectRatio: 1.2,
                      child: Container(
                        width: double.infinity,
                        color: Colors.grey[100],
                        child: Image.network(
                          product.imageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: AppTheme.primaryColor.withOpacity(0.1),
                              child: const Icon(
                                Icons.image,
                                size: 50,
                                color: AppTheme.primaryColor,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  // Favorite Button
                  Positioned(
                    top: 8,
                    right: 8,
                    child: GestureDetector(
                      onTap: () => _toggleFavorite(product),
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          product.isFavorite ? Icons.favorite : Icons.favorite_border,
                          size: 16,
                          color: product.isFavorite ? AppTheme.accentColor : AppTheme.textLight,
                        ),
                      ),
                    ),
                  ),
                  // Discount Badge
                  if (product.discount > 0)
                    Positioned(
                      top: 8,
                      left: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppTheme.accentColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          '${product.discount}% OFF',
                          style: AppTheme.bodySmall.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              
              // Product Details
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: AppTheme.bodyMedium.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      product.brand,
                      style: AppTheme.bodySmall.copyWith(
                        color: AppTheme.textSecondary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(), // Pushes price and rating to the bottom
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Row(
                        children: [
                          Text(
                            product.price,
                            style: AppTheme.bodyMedium.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppTheme.primaryColor,
                            ),
                          ),
                          if (product.originalPrice.isNotEmpty) ...[
                            const SizedBox(width: 8),
                            Text(
                              product.originalPrice,
                              style: AppTheme.bodySmall.copyWith(
                                decoration: TextDecoration.lineThrough,
                                color: AppTheme.textLight,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    if (product.rating > 0) ...[
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 14),
                          const SizedBox(width: 2),
                          Text(
                            product.rating.toString(),
                            style: AppTheme.bodySmall.copyWith(
                              color: AppTheme.textSecondary,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '(${product.reviewCount})',
                            style: AppTheme.bodySmall.copyWith(
                              color: AppTheme.textLight,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductListCard(ProductItem product) {
    return GestureDetector(
      onTap: () => _showProductDetails(product),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Product Image
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                width: 80,
                height: 80,
                color: Colors.grey[100],
                child: Image.network(
                  product.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: AppTheme.primaryColor.withValues(alpha: 0.1),
                      child: const Icon(
                        Icons.image,
                        size: 30,
                        color: AppTheme.primaryColor,
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(width: 16),
            
            // Product Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: AppTheme.bodyMedium.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product.brand,
                    style: AppTheme.bodySmall.copyWith(
                      color: AppTheme.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    product.shortDescription,
                    style: AppTheme.bodySmall.copyWith(
                      color: AppTheme.textSecondary,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        product.price,
                        style: AppTheme.bodyMedium.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppTheme.primaryColor,
                        ),
                      ),
                      if (product.originalPrice.isNotEmpty) ...[
                        const SizedBox(width: 8),
                        Text(
                          product.originalPrice,
                          style: AppTheme.bodySmall.copyWith(
                            decoration: TextDecoration.lineThrough,
                            color: AppTheme.textLight,
                          ),
                        ),
                      ],
                      if (product.discount > 0) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppTheme.accentColor.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            '${product.discount}% OFF',
                            style: AppTheme.bodySmall.copyWith(
                              color: AppTheme.accentColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  if (product.rating > 0) ...[
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 14),
                        const SizedBox(width: 2),
                        Text(
                          product.rating.toString(),
                          style: AppTheme.bodySmall.copyWith(
                            color: AppTheme.textSecondary,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '(${product.reviewCount})',
                          style: AppTheme.bodySmall.copyWith(
                            color: AppTheme.textLight,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
            
            // Action Buttons
            Column(
              children: [
                GestureDetector(
                  onTap: () => _toggleFavorite(product),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: Icon(
                      product.isFavorite ? Icons.favorite : Icons.favorite_border,
                      size: 20,
                      color: product.isFavorite ? AppTheme.accentColor : AppTheme.textLight,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () => _addToCart(product),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryColor,
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    minimumSize: const Size(80, 32),
                  ),
                  child: Text(
                    'Add to Cart',
                    style: AppTheme.bodySmall.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showProductDetails(ProductItem product) {
    // Navigate to the actual ProductDetailsScreen instead of showing modal
    NavigationHelper.goToProductDetails();
  }

  void _showSortOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Sort By',
              style: AppTheme.heading3,
            ),
            const SizedBox(height: 16),
            _buildSortOption('Popularity', 'popularity'),
            _buildSortOption('Price: Low to High', 'price_low'),
            _buildSortOption('Price: High to Low', 'price_high'),
            _buildSortOption('Customer Rating', 'rating'),
            _buildSortOption('Newest First', 'newest'),
          ],
        ),
      ),
    );
  }

  Widget _buildSortOption(String title, String value) {
    return ListTile(
      title: Text(title),
      trailing: _sortBy == value ? const Icon(Icons.check, color: AppTheme.primaryColor) : null,
      onTap: () {
        setState(() {
          _sortBy = value;
          _sortProducts();
        });
        Navigator.pop(context);
      },
    );
  }

  void _sortProducts() {
    switch (_sortBy) {
      case 'price_low':
        _filteredProducts.sort((a, b) => _parsePrice(a.price).compareTo(_parsePrice(b.price)));
        break;
      case 'price_high':
        _filteredProducts.sort((a, b) => _parsePrice(b.price).compareTo(_parsePrice(a.price)));
        break;
      case 'rating':
        _filteredProducts.sort((a, b) => b.rating.compareTo(a.rating));
        break;
      case 'newest':
        // Assuming newer products have higher IDs
        _filteredProducts.sort((a, b) => b.id.compareTo(a.id));
        break;
      default:
        // Popularity - keep original order
        break;
    }
  }

  double _parsePrice(String price) {
    // Extract numeric value from price string
    final numericString = price.replaceAll(RegExp(r'[^\d.]'), '');
    return double.tryParse(numericString) ?? 0.0;
  }

  void _toggleFavorite(ProductItem product) {
    setState(() {
      product.isFavorite = !product.isFavorite;
    });
  }

  void _addToCart(ProductItem product) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${product.name} added to cart'),
        backgroundColor: AppTheme.successColor,
      ),
    );
  }

  // Mock data generation methods
  List<ProductItem> _getSmartphones() {
    return [
      ProductItem(
        id: '1',
        name: 'iPhone 15 Pro',
        brand: 'Apple',
        price: 'Rs.79,999',
        originalPrice: 'Rs.89,999',
        discount: 9,
        rating: 4.8,
        reviewCount: 1250,
        imageUrl: 'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=300',
        shortDescription: 'Latest iPhone with A17 Pro chip and titanium design',
        detailedDescription: ProductDetailedDescription(
          fullDescription: 'The iPhone 15 Pro features the powerful A17 Pro chip, a titanium design, and an advanced camera system with 5x telephoto zoom.',
          specifications: {
            'Display': '6.1-inch Super Retina XDR',
            'Chip': 'A17 Pro',
            'Storage': '128GB, 256GB, 512GB, 1TB',
            'Camera': '48MP Main, 12MP Ultra Wide, 12MP Telephoto',
            'Battery': 'Up to 23 hours video playback',
            'Material': 'Titanium',
          },
          colors: ['Natural Titanium', 'Blue Titanium', 'White Titanium', 'Black Titanium'],
          reviews: [
            'Amazing camera quality and performance!',
            'The titanium build feels premium',
            'Battery life is excellent',
          ],
          relatedProducts: ['iPhone 15', 'iPhone 15 Pro Max', 'AirPods Pro'],
        ),
      ),
      ProductItem(
        id: '2',
        name: 'Samsung Galaxy S24 Ultra',
        brand: 'Samsung',
        price: 'Rs.69,999',
        originalPrice: 'Rs.89,999',
        discount: 25,
        rating: 4.7,
        reviewCount: 980,
        imageUrl: 'https://images.unsplash.com/photo-1610945265064-0e34e5519bbf?w=300',
        shortDescription: 'Flagship Android phone with S Pen and 200MP camera',
        detailedDescription: ProductDetailedDescription(
          fullDescription: 'The Galaxy S24 Ultra combines the power of the S Pen with a 200MP camera system and AI-enhanced features.',
          specifications: {
            'Display': '6.8-inch Dynamic AMOLED 2X',
            'Processor': 'Snapdragon 8 Gen 3',
            'RAM': '12GB',
            'Storage': '256GB, 512GB, 1TB',
            'Camera': '200MP Main, 50MP Periscope, 12MP Ultra Wide',
            'Battery': '5000mAh',
            'S Pen': 'Built-in',
          },
          colors: ['Titanium Gray', 'Titanium Black', 'Titanium Violet', 'Titanium Yellow'],
          reviews: [
            'S Pen functionality is incredible',
            'Camera zoom is unmatched',
            'Display quality is stunning',
          ],
          relatedProducts: ['Galaxy S24', 'Galaxy S24+', 'Galaxy Buds2 Pro'],
        ),
      ),
      // Add more smartphones...
    ];
  }

  List<ProductItem> _getLaptops() {
    return [
      ProductItem(
        id: '10',
        name: 'MacBook Pro 14"',
        brand: 'Apple',
        price: 'Rs.1,59,999',
        originalPrice: 'Rs.1,79,999',
        discount: 9,
        rating: 4.9,
        reviewCount: 750,
        imageUrl: 'https://images.unsplash.com/photo-1496181133206-80ce9b88a853?w=300',
        shortDescription: 'Professional laptop with M3 Pro chip and Liquid Retina XDR display',
        detailedDescription: ProductDetailedDescription(
          fullDescription: 'The MacBook Pro 14" delivers exceptional performance with the M3 Pro chip, perfect for creative professionals.',
          specifications: {
            'Display': '14.2-inch Liquid Retina XDR',
            'Chip': 'Apple M3 Pro',
            'Memory': '18GB Unified Memory',
            'Storage': '512GB SSD',
            'Battery': 'Up to 18 hours',
            'Ports': '3x Thunderbolt 4, HDMI, SDXC, MagSafe 3',
          },
          colors: ['Space Black', 'Silver'],
          reviews: [
            'Incredible performance for video editing',
            'Display quality is outstanding',
            'Battery life exceeds expectations',
          ],
          relatedProducts: ['MacBook Air', 'Mac Studio', 'Studio Display'],
        ),
      ),
      // Add more laptops...
    ];
  }

  List<ProductItem> _getHeadphones() {
    return [
      ProductItem(
        id: '20',
        name: 'Sony WH-1000XM5',
        brand: 'Sony',
        price: 'Rs.27,999',
        originalPrice: 'Rs.31,999',
        discount: 13,
        rating: 4.6,
        reviewCount: 2100,
        imageUrl: 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=300',
        shortDescription: 'Industry-leading noise canceling wireless headphones',
        detailedDescription: ProductDetailedDescription(
          fullDescription: 'Experience premium sound quality with industry-leading noise cancellation technology.',
          specifications: {
            'Driver': '30mm',
            'Frequency Response': '4Hz-40,000Hz',
            'Battery Life': '30 hours with ANC',
            'Charging': 'USB-C, Quick Charge',
            'Weight': '250g',
            'Connectivity': 'Bluetooth 5.2, NFC',
          },
          colors: ['Black', 'Silver'],
          reviews: [
            'Best noise cancellation I\'ve experienced',
            'Comfortable for long listening sessions',
            'Sound quality is exceptional',
          ],
          relatedProducts: ['WF-1000XM4', 'WH-CH720N', 'LinkBuds S'],
        ),
      ),
      // Add more headphones...
    ];
  }

  // Add more category-specific product generation methods...
  List<ProductItem> _getSmartwatches() {
    return [
      ProductItem(
        id: '30',
        name: 'Apple Watch Series 9',
        brand: 'Apple',
        price: 'Rs.31,999',
        originalPrice: 'Rs.34,999',
        discount: 7,
        rating: 4.7,
        reviewCount: 1800,
        imageUrl: 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=300',
        shortDescription: 'Advanced health monitoring and fitness tracking',
        detailedDescription: ProductDetailedDescription(
          fullDescription: 'The most advanced Apple Watch yet with comprehensive health monitoring and fitness features.',
          specifications: {
            'Display': '45mm Always-On Retina',
            'Chip': 'S9 SiP',
            'Storage': '64GB',
            'Battery': '18 hours',
            'Water Resistance': '50 meters',
            'Health Features': 'ECG, Blood Oxygen, Heart Rate',
          },
          colors: ['Midnight', 'Starlight', 'Silver', 'Product Red'],
          reviews: [
            'Health tracking is incredibly accurate',
            'Battery life is reliable',
            'Seamless integration with iPhone',
          ],
          relatedProducts: ['Apple Watch Ultra 2', 'AirPods Pro', 'iPhone 15'],
        ),
      ),
    ];
  }

  List<ProductItem> _getGamingConsoles() {
    return [
      ProductItem(
        id: '40',
        name: 'PlayStation 5',
        brand: 'Sony',
        price: 'Rs.39,999',
        originalPrice: 'Rs.39,999',
        discount: 0,
        rating: 4.8,
        reviewCount: 3200,
        imageUrl: 'https://images.unsplash.com/photo-1606144042614-b2417e99c4e3?w=300',
        shortDescription: 'Next-gen gaming console with 4K gaming and ray tracing',
        detailedDescription: ProductDetailedDescription(
          fullDescription: 'Experience lightning-fast loading with an ultra-high speed SSD and immersive gaming with ray tracing.',
          specifications: {
            'CPU': 'AMD Zen 2, 8 Cores',
            'GPU': 'AMD RDNA 2',
            'Memory': '16GB GDDR6',
            'Storage': '825GB SSD',
            'Resolution': '4K UHD',
            'Ray Tracing': 'Hardware-accelerated',
          },
          colors: ['White'],
          reviews: [
            'Loading times are incredibly fast',
            'Graphics quality is stunning',
            'DualSense controller is revolutionary',
          ],
          relatedProducts: ['DualSense Controller', 'PlayStation VR2', 'PS5 Games'],
        ),
      ),
    ];
  }

  List<ProductItem> _getCameras() {
    return [
      ProductItem(
        id: '50',
        name: 'Canon EOS R5',
        brand: 'Canon',
        price: 'Rs.3,09,999',
        originalPrice: 'Rs.3,09,999',
        discount: 0,
        rating: 4.9,
        reviewCount: 450,
        imageUrl: 'https://images.unsplash.com/photo-1502920917128-1aa500764cbd?w=300',
        shortDescription: 'Professional mirrorless camera with 45MP sensor and 8K video',
        detailedDescription: ProductDetailedDescription(
          fullDescription: 'Professional-grade mirrorless camera perfect for photographers and videographers.',
          specifications: {
            'Sensor': '45MP Full-Frame CMOS',
            'Video': '8K RAW, 4K 120p',
            'ISO Range': '100-51200',
            'Autofocus': 'Dual Pixel CMOS AF II',
            'Image Stabilization': '5-axis In-Body',
            'Mount': 'Canon RF',
          },
          colors: ['Black'],
          reviews: [
            'Image quality is exceptional',
            '8K video capability is impressive',
            'Autofocus is lightning fast',
          ],
          relatedProducts: ['RF 24-70mm f/2.8L', 'RF 70-200mm f/2.8L', 'Canon Speedlite'],
        ),
      ),
    ];
  }

  List<ProductItem> _getTelevisions() {
    return [
      ProductItem(
        id: '60',
        name: 'Samsung 65" QLED 4K',
        brand: 'Samsung',
        price: 'Rs.1,03,999',
        originalPrice: 'Rs.1,27,999',
        discount: 19,
        rating: 4.5,
        reviewCount: 890,
        imageUrl: 'https://images.unsplash.com/photo-1593359677879-a4bb92f829d1?w=300',
        shortDescription: 'Quantum Dot technology with HDR10+ and smart TV features',
        detailedDescription: ProductDetailedDescription(
          fullDescription: 'Experience brilliant colors and contrast with Quantum Dot technology and comprehensive smart features.',
          specifications: {
            'Screen Size': '65 inches',
            'Resolution': '4K UHD (3840 x 2160)',
            'Display Type': 'QLED',
            'HDR': 'HDR10+',
            'Smart Platform': 'Tizen OS',
            'Refresh Rate': '120Hz',
          },
          colors: ['Titan Gray'],
          reviews: [
            'Picture quality is stunning',
            'Smart features work seamlessly',
            'Great value for the price',
          ],
          relatedProducts: ['Samsung Soundbar', 'HDMI Cables', 'Wall Mount'],
        ),
      ),
    ];
  }

  List<ProductItem> _getAllElectronics() {
    return [
      ..._getSmartphones(),
      ..._getLaptops(),
      ..._getHeadphones(),
      ..._getSmartwatches(),
      ..._getGamingConsoles(),
      ..._getCameras(),
      ..._getTelevisions(),
    ];
  }

  List<ProductItem> _getMobileProducts() {
    return _getSmartphones();
  }

  List<ProductItem> _getFashionProducts() {
    return [
      ProductItem(
        id: '100',
        name: 'Classic Denim Jacket',
        brand: 'Levi\'s',
        price: 'Rs.7,199',
        originalPrice: 'Rs.9,599',
        discount: 26,
        rating: 4.4,
        reviewCount: 650,
        imageUrl: 'https://images.unsplash.com/photo-1551028719-00167b16eac5?w=300',
        shortDescription: 'Timeless denim jacket with classic fit',
        detailedDescription: ProductDetailedDescription(
          fullDescription: 'A timeless piece that never goes out of style, perfect for layering.',
          specifications: {
            'Material': '100% Cotton Denim',
            'Fit': 'Regular',
            'Care': 'Machine Wash Cold',
            'Origin': 'Made in USA',
          },
          colors: ['Blue', 'Black', 'Light Wash'],
          reviews: [
            'Perfect fit and quality',
            'Goes with everything',
            'Durable construction',
          ],
          relatedProducts: ['Levi\'s 501 Jeans', 'White T-Shirt', 'Sneakers'],
        ),
      ),
    ];
  }

  List<ProductItem> _getHomeGardenProducts() {
    return [
      ProductItem(
        id: '200',
        name: 'Modern Coffee Table',
        brand: 'IKEA',
        price: 'Rs.15,999',
        originalPrice: 'Rs.19,999',
        discount: 20,
        rating: 4.2,
        reviewCount: 320,
        imageUrl: 'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?w=300',
        shortDescription: 'Minimalist design coffee table with storage',
        detailedDescription: ProductDetailedDescription(
          fullDescription: 'A modern coffee table that combines style with functionality.',
          specifications: {
            'Material': 'Engineered Wood',
            'Dimensions': '47" x 24" x 16"',
            'Weight': '45 lbs',
            'Assembly': 'Required',
          },
          colors: ['White', 'Black', 'Oak'],
          reviews: [
            'Easy to assemble',
            'Great storage space',
            'Looks expensive',
          ],
          relatedProducts: ['Side Table', 'Table Lamp', 'Decorative Vase'],
        ),
      ),
    ];
  }

  List<ProductItem> _getSportsProducts() {
    return [
      ProductItem(
        id: '300',
        name: 'Professional Yoga Mat',
        brand: 'Manduka',
        price: 'Rs.6,399',
        originalPrice: 'Rs.7,999',
        discount: 20,
        rating: 4.8,
        reviewCount: 1200,
        imageUrl: 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=300',
        shortDescription: 'Premium yoga mat with superior grip and cushioning',
        detailedDescription: ProductDetailedDescription(
          fullDescription: 'Professional-grade yoga mat designed for serious practitioners.',
          specifications: {
            'Material': 'Natural Rubber',
            'Thickness': '6mm',
            'Size': '71" x 24"',
            'Weight': '5.5 lbs',
            'Grip': 'Superior wet/dry traction',
          },
          colors: ['Purple', 'Black', 'Blue', 'Green'],
          reviews: [
            'Best yoga mat I\'ve ever used',
            'Excellent grip even when sweaty',
            'Durable and long-lasting',
          ],
          relatedProducts: ['Yoga Blocks', 'Yoga Strap', 'Water Bottle'],
        ),
      ),
    ];
  }

  List<ProductItem> _getBooksProducts() {
    return [
      ProductItem(
        id: '400',
        name: 'The Psychology of Money',
        brand: 'Morgan Housel',
        price: 'Rs.1,299',
        originalPrice: 'Rs.1,599',
        discount: 20,
        rating: 4.7,
        reviewCount: 2800,
        imageUrl: 'https://images.unsplash.com/photo-1481627834876-b7833e8f5570?w=300',
        shortDescription: 'Timeless lessons on wealth, greed, and happiness',
        detailedDescription: ProductDetailedDescription(
          fullDescription: 'A fascinating exploration of how psychology affects our financial decisions.',
          specifications: {
            'Pages': '256',
            'Publisher': 'Harriman House',
            'Language': 'English',
            'Format': 'Paperback',
            'ISBN': '978-0857197689',
          },
          colors: ['Standard'],
          reviews: [
            'Life-changing perspective on money',
            'Easy to read and understand',
            'Practical advice for everyone',
          ],
          relatedProducts: ['Rich Dad Poor Dad', 'The Intelligent Investor', 'Atomic Habits'],
        ),
      ),
    ];
  }

  List<ProductItem> _getBeautyProducts() {
    return [
      ProductItem(
        id: '500',
        name: 'Vitamin C Serum',
        brand: 'The Ordinary',
        price: 'Rs.1,999',
        originalPrice: 'Rs.2,399',
        discount: 17,
        rating: 4.3,
        reviewCount: 1500,
        imageUrl: 'https://images.unsplash.com/photo-1596462502278-27bfdc403348?w=300',
        shortDescription: 'Brightening serum with 23% Vitamin C + HA Spheres',
        detailedDescription: ProductDetailedDescription(
          fullDescription: 'A potent vitamin C serum that brightens and evens skin tone.',
          specifications: {
            'Volume': '30ml',
            'Key Ingredients': 'L-Ascorbic Acid, Hyaluronic Acid',
            'Skin Type': 'All skin types',
            'Usage': 'Morning routine',
            'Shelf Life': '12 months after opening',
          },
          colors: ['Standard'],
          reviews: [
            'Noticeable brightening effect',
            'Great value for money',
            'Gentle on sensitive skin',
          ],
          relatedProducts: ['Niacinamide Serum', 'Hyaluronic Acid', 'Moisturizer'],
        ),
      ),
    ];
  }

  List<ProductItem> _getAutomotiveProducts() {
    return [
      ProductItem(
        id: '600',
        name: 'Car Phone Mount',
        brand: 'iOttie',
        price: 'Rs.3,199',
        originalPrice: 'Rs.3,999',
        discount: 20,
        rating: 4.6,
        reviewCount: 890,
        imageUrl: 'https://images.unsplash.com/photo-1449824913935-59a10b8d2000?w=300',
        shortDescription: 'Dashboard and windshield car mount for smartphones',
        detailedDescription: ProductDetailedDescription(
          fullDescription: 'Secure and adjustable phone mount for safe hands-free driving.',
          specifications: {
            'Compatibility': 'Smartphones 4-6.5 inches',
            'Mount Type': 'Dashboard/Windshield',
            'Rotation': '360 degrees',
            'Material': 'ABS Plastic',
            'Installation': 'Tool-free',
          },
          colors: ['Black'],
          reviews: [
            'Very stable and secure',
            'Easy to install and adjust',
            'Works with phone cases',
          ],
          relatedProducts: ['Car Charger', 'Dash Cam', 'Air Freshener'],
        ),
      ),
    ];
  }

  List<ProductItem> _getHealthWellnessProducts() {
    return [
      ProductItem(
        id: '700',
        name: 'Multivitamin Gummies',
        brand: 'Vitafusion',
        price: 'Rs.1,599',
        originalPrice: 'Rs.1,999',
        discount: 21,
        rating: 4.4,
        reviewCount: 1100,
        imageUrl: 'https://images.unsplash.com/photo-1559757148-5c350d0d3c56?w=300',
        shortDescription: 'Daily multivitamin with essential nutrients',
        detailedDescription: ProductDetailedDescription(
          fullDescription: 'Delicious gummy vitamins packed with essential nutrients for daily health.',
          specifications: {
            'Serving Size': '2 gummies',
            'Servings Per Container': '75',
            'Key Vitamins': 'A, C, D, E, B6, B12',
            'Flavor': 'Mixed Berry',
            'Sugar': '3g per serving',
          },
          colors: ['Standard'],
          reviews: [
            'Tastes great, easy to take',
            'Good value for the price',
            'No aftertaste',
          ],
          relatedProducts: ['Omega-3 Gummies', 'Vitamin D3', 'Probiotics'],
        ),
      ),
    ];
  }

  List<ProductItem> _getAllProducts() {
    return [
      ..._getAllElectronics(),
      ..._getFashionProducts(),
      ..._getHomeGardenProducts(),
      ..._getSportsProducts(),
      ..._getBooksProducts(),
      ..._getBeautyProducts(),
      ..._getAutomotiveProducts(),
      ..._getHealthWellnessProducts(),
    ];
  }
}

class ProductItem {
  final String id;
  final String name;
  final String brand;
  final String price;
  final String originalPrice;
  final int discount;
  final double rating;
  final int reviewCount;
  final String imageUrl;
  final String shortDescription;
  final ProductDetailedDescription detailedDescription;
  bool isFavorite;

  ProductItem({
    required this.id,
    required this.name,
    required this.brand,
    required this.price,
    this.originalPrice = '',
    this.discount = 0,
    this.rating = 0.0,
    this.reviewCount = 0,
    required this.imageUrl,
    required this.shortDescription,
    required this.detailedDescription,
    this.isFavorite = false,
  });
}

class ProductDetailedDescription {
  final String fullDescription;
  final Map<String, String> specifications;
  final List<String> colors;
  final List<String> reviews;
  final List<String> relatedProducts;

  ProductDetailedDescription({
    required this.fullDescription,
    required this.specifications,
    required this.colors,
    required this.reviews,
    required this.relatedProducts,
  });
}

class ProductDetailsModal extends StatelessWidget {
  final ProductItem product;

  const ProductDetailsModal({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.9,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Handle bar
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  
                  // Product Image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      width: double.infinity,
                      height: 200,
                      color: Colors.grey[100],
                      child: Image.network(
                        product.imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: AppTheme.primaryColor.withValues(alpha: 0.1),
                            child: const Icon(
                              Icons.image,
                              size: 80,
                              color: AppTheme.primaryColor,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // Product Name and Brand
                  Text(
                    product.name,
                    style: AppTheme.heading2,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product.brand,
                    style: AppTheme.bodyMedium.copyWith(
                      color: AppTheme.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // Price and Rating
                  Row(
                    children: [
                      Text(
                        product.price,
                        style: AppTheme.heading3.copyWith(
                          color: AppTheme.primaryColor,
                        ),
                      ),
                      if (product.originalPrice.isNotEmpty) ...[
                        const SizedBox(width: 12),
                        Text(
                          product.originalPrice,
                          style: AppTheme.bodyMedium.copyWith(
                            decoration: TextDecoration.lineThrough,
                            color: AppTheme.textLight,
                          ),
                        ),
                      ],
                      const Spacer(),
                      if (product.rating > 0) ...[
                        const Icon(Icons.star, color: Colors.amber, size: 20),
                        const SizedBox(width: 4),
                        Text(
                          '${product.rating} (${product.reviewCount})',
                          style: AppTheme.bodyMedium,
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 20),
                  
                  // Description
                  Text(
                    'Description',
                    style: AppTheme.heading3.copyWith(fontSize: 18),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    product.detailedDescription.fullDescription,
                    style: AppTheme.bodyMedium.copyWith(
                      height: 1.5,
                      color: AppTheme.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 20),
                  
                  // Specifications
                  Text(
                    'Specifications',
                    style: AppTheme.heading3.copyWith(fontSize: 18),
                  ),
                  const SizedBox(height: 12),
                  ...product.detailedDescription.specifications.entries.map(
                    (entry) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 120,
                            child: Text(
                              entry.key,
                              style: AppTheme.bodyMedium.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              entry.value,
                              style: AppTheme.bodyMedium.copyWith(
                                color: AppTheme.textSecondary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  
                  // Colors
                  if (product.detailedDescription.colors.isNotEmpty) ...[
                    Text(
                      'Available Colors',
                      style: AppTheme.heading3.copyWith(fontSize: 18),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      children: product.detailedDescription.colors.map(
                        (color) => Chip(
                          label: Text(color),
                          backgroundColor: AppTheme.backgroundColor,
                        ),
                      ).toList(),
                    ),
                    const SizedBox(height: 20),
                  ],
                  
                  // Customer Reviews
                  if (product.detailedDescription.reviews.isNotEmpty) ...[
                    Text(
                      'Customer Reviews',
                      style: AppTheme.heading3.copyWith(fontSize: 18),
                    ),
                    const SizedBox(height: 12),
                    ...product.detailedDescription.reviews.map(
                      (review) => Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppTheme.backgroundColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          review,
                          style: AppTheme.bodyMedium.copyWith(
                            color: AppTheme.textSecondary,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                  
                  // Related Products
                  if (product.detailedDescription.relatedProducts.isNotEmpty) ...[
                    Text(
                      'Related Products',
                      style: AppTheme.heading3.copyWith(fontSize: 18),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      children: product.detailedDescription.relatedProducts.map(
                        (relatedProduct) => Chip(
                          label: Text(relatedProduct),
                          backgroundColor: AppTheme.primaryColor.withValues(alpha: 0.1),
                        ),
                      ).toList(),
                    ),
                    const SizedBox(height: 30),
                  ],
                  
                  // Action Buttons
                  Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          text: 'Add to Cart',
                          onPressed: () {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('${product.name} added to cart'),
                                backgroundColor: AppTheme.successColor,
                              ),
                            );
                          },
                          isOutlined: true,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: CustomButton(
                          text: 'Buy Now',
                          onPressed: () {
                            Navigator.pop(context);
                            NavigationHelper.goToCheckout();
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}