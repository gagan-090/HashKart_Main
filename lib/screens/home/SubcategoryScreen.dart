import 'package:flutter/material.dart';
import '../../models/category_model.dart';
import '../../services/category_service.dart';
import '../../routes/navigation_helper.dart';
import '../../theme/app_theme.dart';
import '../../widgets/common_widgets.dart';
import '../../widgets/breadcrumb_widget.dart';

class SubcategoryScreen extends StatefulWidget {
  final String? categoryName;
  final String? subcategoryName;
  final String? categoryId;

  const SubcategoryScreen({
    super.key,
    this.categoryName,
    this.subcategoryName,
    this.categoryId,
  });

  @override
  State<SubcategoryScreen> createState() => _SubcategoryScreenState();
}

class _SubcategoryScreenState extends State<SubcategoryScreen> {
  final CategoryService _categoryService = CategoryService();
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  
  Category? _currentCategory;
  List<Category> _subcategories = [];
  List<Category> _filteredSubcategories = [];
  CategoryNavigationState? _navigationState;
  bool _isSearching = false;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _loadCategoryData();
  }

  void _loadCategoryData() {
    if (widget.categoryId != null) {
      _loadCategoryById(widget.categoryId!);
    } else if (widget.categoryName != null) {
      _loadCategoryByName(widget.categoryName!);
    }
  }

  void _loadCategoryById(String categoryId) {
    final category = _categoryService.findCategoryById(categoryId);
    if (category != null) {
      setState(() {
        _currentCategory = category;
        _subcategories = category.children;
        _filteredSubcategories = category.children;
        _navigationState = _categoryService.getNavigationState(categoryId);
      });
    }
  }

  void _loadCategoryByName(String categoryName) {
    final categories = _categoryService.getAllCategories();
    final category = categories.firstWhere(
      (c) => c.title.toLowerCase() == categoryName.toLowerCase(),
      orElse: () => categories.first,
    );
    
    setState(() {
      _currentCategory = category;
      _subcategories = category.children;
      _filteredSubcategories = category.children;
      _navigationState = _categoryService.getNavigationState(category.id);
    });
  }

  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query;
      _isSearching = query.isNotEmpty;
      
      if (query.isEmpty) {
        _filteredSubcategories = _subcategories;
      } else {
        _filteredSubcategories = _subcategories
            .where((subcategory) => subcategory.title.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  void _onSubcategoryTap(Category subcategory) {
    if (subcategory.hasChildren) {
      // Navigate to next level subcategories
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SubcategoryScreen(
            categoryId: subcategory.id,
            categoryName: subcategory.title,
          ),
        ),
      );
    } else {
      // Navigate to product listing
      NavigationHelper.goToProductListing(
        category: _currentCategory?.title ?? '',
        subCategory: subcategory.title,
      );
    }
  }

  void _onBreadcrumbTap(Category category) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => SubcategoryScreen(
          categoryId: category.id,
          categoryName: category.title,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_currentCategory == null) {
      return Scaffold(
        backgroundColor: AppTheme.backgroundColor,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: AppTheme.textPrimary),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            'Category Not Found',
            style: AppTheme.heading3.copyWith(color: AppTheme.textPrimary),
          ),
        ),
        body: const Center(
          child: Text('Category not found'),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          _buildSearchBar(),
          if (_navigationState != null) _buildBreadcrumb(),
          _buildCategoryHeader(),
          Expanded(
            child: _isSearching 
                ? _buildSearchResults()
                : _buildSubcategoriesGrid(),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      scrolledUnderElevation: 2,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: AppTheme.textPrimary),
        onPressed: () => Navigator.pop(context),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _currentCategory?.title ?? 'Subcategories',
            style: AppTheme.heading3.copyWith(
              color: AppTheme.textPrimary,
              fontSize: 18,
            ),
          ),
          if (_currentCategory?.description != null)
            Text(
              _currentCategory!.description!,
              style: AppTheme.bodySmall.copyWith(
                color: AppTheme.textSecondary,
              ),
            ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.search, color: AppTheme.textPrimary),
          onPressed: () => _searchFocusNode.requestFocus(),
        ),
        IconButton(
          icon: const Icon(Icons.view_list, color: AppTheme.textPrimary),
          onPressed: () {
            // Navigate to product listing for current category
            NavigationHelper.goToProductListing(
              category: _currentCategory?.title ?? '',
            );
          },
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
              child: TextField(
          controller: _searchController,
          focusNode: _searchFocusNode,
          onChanged: _onSearchChanged,
        decoration: InputDecoration(
          hintText: 'Search subcategories...',
          prefixIcon: const Icon(Icons.search, color: AppTheme.textSecondary),
          suffixIcon: _searchQuery.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear, color: AppTheme.textSecondary),
                  onPressed: () {
                    _searchController.clear();
                    _onSearchChanged('');
                  },
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppTheme.borderColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppTheme.borderColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppTheme.primaryColor, width: 2),
          ),
          filled: true,
          fillColor: AppTheme.backgroundColor,
        ),
      ),
    );
  }

  Widget _buildBreadcrumb() {
    return CategoryBreadcrumb(
      navigationState: _navigationState!,
      onBreadcrumbTap: _onBreadcrumbTap,
    );
  }

  Widget _buildCategoryHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: _currentCategory!.displayColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              _currentCategory!.displayIcon,
              color: _currentCategory!.displayColor,
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _currentCategory!.title,
                  style: AppTheme.heading3.copyWith(fontSize: 18),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      '${_currentCategory!.totalProductCount} Products',
                      style: AppTheme.bodySmall.copyWith(
                        color: AppTheme.textSecondary,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      '${_subcategories.length} Subcategories',
                      style: AppTheme.bodySmall.copyWith(
                        color: AppTheme.textSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (_currentCategory!.isTrending)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
        ],
      ),
    );
  }

  Widget _buildSubcategoriesGrid() {
    if (_filteredSubcategories.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.category_outlined, size: 64, color: AppTheme.textLight),
            const SizedBox(height: 16),
            Text(
              'No subcategories available',
              style: AppTheme.heading3.copyWith(color: AppTheme.textSecondary),
            ),
            const SizedBox(height: 8),
            Text(
              'This category doesn\'t have any subcategories yet',
              style: AppTheme.bodyMedium.copyWith(color: AppTheme.textLight),
            ),
          ],
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.85,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: _filteredSubcategories.length,
      itemBuilder: (context, index) {
        final subcategory = _filteredSubcategories[index];
        return _buildSubcategoryCard(subcategory);
      },
    );
  }

  Widget _buildSearchResults() {
    if (_filteredSubcategories.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.search_off, size: 64, color: AppTheme.textLight),
            const SizedBox(height: 16),
            Text(
              'No subcategories found',
              style: AppTheme.heading3.copyWith(color: AppTheme.textSecondary),
            ),
            const SizedBox(height: 8),
            Text(
              'Try searching with different keywords',
              style: AppTheme.bodyMedium.copyWith(color: AppTheme.textLight),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _filteredSubcategories.length,
      itemBuilder: (context, index) {
        final subcategory = _filteredSubcategories[index];
        return _buildSearchResultCard(subcategory);
      },
    );
  }

  Widget _buildSubcategoryCard(Category subcategory) {
    return GestureDetector(
      onTap: () => _onSubcategoryTap(subcategory),
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
                child: subcategory.imageUrl != null
                    ? Image.network(
                        subcategory.imageUrl!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return _buildSubcategoryPlaceholder(subcategory);
                        },
                      )
                    : _buildSubcategoryPlaceholder(subcategory),
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
            if (subcategory.isTrending)
              Positioned(
                top: 12,
                right: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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

            // Subcategory Info
            Positioned(
              bottom: 16,
              left: 16,
              right: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    subcategory.title,
                    style: AppTheme.bodyMedium.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          '${subcategory.totalProductCount} Products',
                          style: AppTheme.bodySmall.copyWith(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                        ),
                      ),
                      if (subcategory.hasChildren) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            '${subcategory.children.length} Subcategories',
                            style: AppTheme.bodySmall.copyWith(
                              color: Colors.white,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchResultCard(Category subcategory) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
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
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: subcategory.displayColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            subcategory.displayIcon,
            color: subcategory.displayColor,
            size: 24,
          ),
        ),
        title: Text(
          subcategory.title,
          style: AppTheme.bodyMedium.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (subcategory.description != null) ...[
              const SizedBox(height: 4),
              Text(
                subcategory.description!,
                style: AppTheme.bodySmall.copyWith(
                  color: AppTheme.textSecondary,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  '${subcategory.totalProductCount} Products',
                  style: AppTheme.bodySmall.copyWith(
                    color: AppTheme.textLight,
                  ),
                ),
                if (subcategory.hasChildren) ...[
                  const SizedBox(width: 16),
                  Text(
                    '${subcategory.children.length} Subcategories',
                    style: AppTheme.bodySmall.copyWith(
                      color: AppTheme.textLight,
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
        trailing: const Icon(
          Icons.chevron_right,
          color: AppTheme.textLight,
        ),
        onTap: () => _onSubcategoryTap(subcategory),
      ),
    );
  }

  Widget _buildSubcategoryPlaceholder(Category subcategory) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            subcategory.displayColor.withOpacity(0.1),
            subcategory.displayColor.withOpacity(0.05),
          ],
        ),
      ),
      child: Center(
        child: Icon(
          subcategory.displayIcon,
          size: 50,
          color: subcategory.displayColor,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }
}
