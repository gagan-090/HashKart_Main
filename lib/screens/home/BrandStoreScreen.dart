import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../models/product_model.dart';
import '../../data/all_products.dart';

class BrandStoreScreen extends StatefulWidget {
  final String? selectedBrand;

  const BrandStoreScreen({
    super.key,
    this.selectedBrand,
  });

  @override
  State<BrandStoreScreen> createState() => _BrandStoreScreenState();
}

class _BrandStoreScreenState extends State<BrandStoreScreen> {
  List<String> brands = [
    'Apple',
    'Samsung',
    'Nike',
    'Adidas',
    'Puma',
    'Sony',
    'LG',
    'Canon',
    'Nikon',
    'Dell',
    'HP',
    'Lenovo',
  ];

  String? selectedBrand;
  List<Product> brandProducts = [];

  @override
  void initState() {
    super.initState();
    selectedBrand = widget.selectedBrand;
    if (selectedBrand != null) {
      _loadBrandProducts();
    }
  }

  void _loadBrandProducts() {
    if (selectedBrand != null) {
      brandProducts = allProducts.where((product) {
        return product.name.toLowerCase().contains(selectedBrand!.toLowerCase());
      }).toList();
    }
  }

  void _selectBrand(String brand) {
    setState(() {
      selectedBrand = brand;
      _loadBrandProducts();
    });
  }

  Widget _buildBrandGrid() {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: brands.length,
      itemBuilder: (context, index) {
        final brand = brands[index];
        final isSelected = selectedBrand == brand;
        
        return GestureDetector(
          onTap: () => _selectBrand(brand),
          child: Card(
            elevation: isSelected ? 4 : 2,
            color: isSelected ? AppTheme.primaryColor.withValues(alpha: 0.1) : Colors.white,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: isSelected
                    ? Border.all(color: AppTheme.primaryColor, width: 2)
                    : null,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: AppTheme.backgroundColor,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Icon(
                      Icons.branding_watermark,
                      size: 32,
                      color: isSelected ? AppTheme.primaryColor : AppTheme.textLight,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    brand,
                    style: AppTheme.bodyMedium.copyWith(
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                      color: isSelected ? AppTheme.primaryColor : AppTheme.textPrimary,
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
      },
    );
  }

  Widget _buildBrandProducts() {
    if (brandProducts.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.inventory_2_outlined,
              size: 64,
              color: AppTheme.textLight,
            ),
            const SizedBox(height: 16),
            Text(
              'No products found for $selectedBrand',
              style: AppTheme.heading3,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              'Try selecting a different brand',
              style: AppTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  '$selectedBrand Products',
                  style: AppTheme.heading3,
                ),
              ),
              Text(
                '${brandProducts.length} items',
                style: AppTheme.bodyMedium,
              ),
            ],
          ),
        ),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.75,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: brandProducts.length,
            itemBuilder: (context, index) {
              return _buildProductCard(brandProducts[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildProductCard(Product product) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            '/product-details',
            arguments: product,
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                  image: DecorationImage(
                    image: NetworkImage(product.imageUrls.first),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: AppTheme.bodyMedium,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          product.price,
                          style: AppTheme.heading3.copyWith(color: AppTheme.primaryColor),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          product.originalPrice,
                          style: AppTheme.bodySmall.copyWith(
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.star, size: 16, color: AppTheme.warningColor),
                        Text(
                          ' ${product.rating}',
                          style: AppTheme.bodySmall,
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedBrand ?? 'Brands'),
        actions: [
          if (selectedBrand != null)
            IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                setState(() {
                  selectedBrand = null;
                  brandProducts.clear();
                });
              },
            ),
        ],
      ),
      body: selectedBrand == null ? _buildBrandGrid() : _buildBrandProducts(),
    );
  }
} 