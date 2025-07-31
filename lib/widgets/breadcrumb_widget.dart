import 'package:flutter/material.dart';
import '../models/category_model.dart';
import '../theme/app_theme.dart';

class BreadcrumbWidget extends StatelessWidget {
  final List<Category> breadcrumbPath;
  final Function(Category)? onBreadcrumbTap;
  final bool showHome;

  const BreadcrumbWidget({
    super.key,
    required this.breadcrumbPath,
    this.onBreadcrumbTap,
    this.showHome = true,
  });

  @override
  Widget build(BuildContext context) {
    if (breadcrumbPath.isEmpty) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: Colors.white,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            if (showHome) ...[
              _buildBreadcrumbItem(
                'Home',
                Icons.home_rounded,
                isActive: breadcrumbPath.length == 1,
                onTap: () => onBreadcrumbTap?.call(breadcrumbPath.first),
              ),
              if (breadcrumbPath.isNotEmpty) _buildSeparator(),
            ],
            ...breadcrumbPath.asMap().entries.map((entry) {
              final index = entry.key;
              final category = entry.value;
              final isLast = index == breadcrumbPath.length - 1;
              
              return Row(
                children: [
                  _buildBreadcrumbItem(
                    category.title,
                    category.displayIcon,
                    isActive: isLast,
                    onTap: isLast ? null : () => onBreadcrumbTap?.call(category),
                  ),
                  if (!isLast) _buildSeparator(),
                ],
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildBreadcrumbItem(
    String title,
    IconData icon, {
    required bool isActive,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isActive 
              ? AppTheme.primaryColor.withOpacity(0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: isActive
              ? Border.all(color: AppTheme.primaryColor, width: 1)
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 16,
              color: isActive ? AppTheme.primaryColor : AppTheme.textSecondary,
            ),
            const SizedBox(width: 6),
            Text(
              title,
              style: AppTheme.bodySmall.copyWith(
                color: isActive ? AppTheme.primaryColor : AppTheme.textSecondary,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSeparator() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Icon(
        Icons.chevron_right,
        size: 16,
        color: AppTheme.textLight,
      ),
    );
  }
}

class CategoryBreadcrumb extends StatelessWidget {
  final CategoryNavigationState navigationState;
  final Function(Category)? onBreadcrumbTap;

  const CategoryBreadcrumb({
    super.key,
    required this.navigationState,
    this.onBreadcrumbTap,
  });

  @override
  Widget build(BuildContext context) {
    return BreadcrumbWidget(
      breadcrumbPath: navigationState.breadcrumbPath,
      onBreadcrumbTap: onBreadcrumbTap,
    );
  }
}

class CompactBreadcrumb extends StatelessWidget {
  final List<String> breadcrumbTitles;
  final VoidCallback? onBackTap;

  const CompactBreadcrumb({
    super.key,
    required this.breadcrumbTitles,
    this.onBackTap,
  });

  @override
  Widget build(BuildContext context) {
    if (breadcrumbTitles.isEmpty) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: Colors.white,
      child: Row(
        children: [
          if (onBackTap != null) ...[
            IconButton(
              icon: const Icon(Icons.arrow_back_ios, size: 20),
              onPressed: onBackTap,
              color: AppTheme.textPrimary,
            ),
            const SizedBox(width: 8),
          ],
          Expanded(
            child: Text(
              breadcrumbTitles.last,
              style: AppTheme.heading3.copyWith(
                color: AppTheme.textPrimary,
                fontSize: 18,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (breadcrumbTitles.length > 1) ...[
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppTheme.backgroundColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '${breadcrumbTitles.length - 1} levels up',
                style: AppTheme.bodySmall.copyWith(
                  color: AppTheme.textSecondary,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
} 