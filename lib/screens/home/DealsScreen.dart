import 'package:flutter/material.dart';
import 'dart:async';
import '../../theme/app_theme.dart';
import '../../models/product_model.dart';
import '../../data/all_products.dart';

class DealsScreen extends StatefulWidget {
  const DealsScreen({super.key});

  @override
  State<DealsScreen> createState() => _DealsScreenState();
}

class _DealsScreenState extends State<DealsScreen> {
  List<Deal> deals = [];
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _loadDeals();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _loadDeals() {
    deals = [
      Deal(
        id: '1',
        title: 'Flash Sale - Electronics',
        description: 'Up to 50% off on smartphones and laptops',
        discount: 50,
        endTime: DateTime.now().add(const Duration(hours: 2, minutes: 30)),
        products: allProducts.take(6).toList(),
        imageUrl: 'https://via.placeholder.com/300x150/6C5CE7/FFFFFF?text=Electronics+Sale',
      ),
      Deal(
        id: '2',
        title: 'Fashion Bonanza',
        description: 'Get 40% off on all clothing and accessories',
        discount: 40,
        endTime: DateTime.now().add(const Duration(hours: 5, minutes: 15)),
        products: allProducts.skip(6).take(4).toList(),
        imageUrl: 'https://via.placeholder.com/300x150/FF7675/FFFFFF?text=Fashion+Sale',
      ),
      Deal(
        id: '3',
        title: 'Home & Living',
        description: '30% off on furniture and home decor',
        discount: 30,
        endTime: DateTime.now().add(const Duration(hours: 8, minutes: 45)),
        products: allProducts.skip(10).take(3).toList(),
        imageUrl: 'https://via.placeholder.com/300x150/00B894/FFFFFF?text=Home+Sale',
      ),
    ];
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        // Update countdown timers
        for (var deal in deals) {
          deal.updateTimeRemaining();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Deals & Offers'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // TODO: Navigate to notifications
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Featured Deal Banner
          if (deals.isNotEmpty) _buildFeaturedDeal(deals.first),
          const SizedBox(height: 24),
          
          // All Deals
          Text(
            'All Deals',
            style: AppTheme.heading2,
          ),
          const SizedBox(height: 16),
          
          ...deals.map((deal) => _buildDealCard(deal)),
        ],
      ),
    );
  }

  Widget _buildFeaturedDeal(Deal deal) {
    return Card(
      elevation: 4,
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: const LinearGradient(
            colors: [AppTheme.primaryColor, AppTheme.secondaryColor],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Stack(
          children: [
            // Background image
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  deal.imageUrl,
                  fit: BoxFit.cover,
                  color: Colors.black.withOpacity(0.3),
                  colorBlendMode: BlendMode.darken,
                ),
              ),
            ),
            // Content
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppTheme.accentColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${deal.discount}% OFF',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    deal.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    deal.description,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  const Spacer(),
                  _buildCountdownTimer(deal),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDealCard(Deal deal) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: () {
          // TODO: Navigate to deal details
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Deal image
            Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                image: DecorationImage(
                  image: NetworkImage(deal.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  // Discount badge
                  Positioned(
                    top: 12,
                    left: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppTheme.accentColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '${deal.discount}% OFF',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  // Countdown timer
                  Positioned(
                    bottom: 12,
                    right: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: _buildCountdownTimer(deal, isCompact: true),
                    ),
                  ),
                ],
              ),
            ),
            // Deal info
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    deal.title,
                    style: AppTheme.heading3,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    deal.description,
                    style: AppTheme.bodyMedium,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(Icons.access_time, size: 16, color: AppTheme.textLight),
                      const SizedBox(width: 4),
                      Text(
                        'Ends in ${deal.timeRemaining}',
                        style: AppTheme.bodySmall.copyWith(color: AppTheme.accentColor),
                      ),
                      const Spacer(),
                      Text(
                        '${deal.products.length} items',
                        style: AppTheme.bodySmall,
                      ),
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

  Widget _buildCountdownTimer(Deal deal, {bool isCompact = false}) {
    final timeParts = deal.timeRemaining.split(':');
    final hours = timeParts[0];
    final minutes = timeParts[1];
    final seconds = timeParts[2];

    if (isCompact) {
      return Text(
        '$hours:$minutes:$seconds',
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      );
    }

    return Row(
      children: [
        _buildTimeUnit(hours, 'H'),
        const SizedBox(width: 8),
        _buildTimeUnit(minutes, 'M'),
        const SizedBox(width: 8),
        _buildTimeUnit(seconds, 'S'),
      ],
    );
  }

  Widget _buildTimeUnit(String value, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

class Deal {
  final String id;
  final String title;
  final String description;
  final int discount;
  final DateTime endTime;
  final List<Product> products;
  final String imageUrl;
  String timeRemaining = '';

  Deal({
    required this.id,
    required this.title,
    required this.description,
    required this.discount,
    required this.endTime,
    required this.products,
    required this.imageUrl,
  }) {
    updateTimeRemaining();
  }

  void updateTimeRemaining() {
    final now = DateTime.now();
    final difference = endTime.difference(now);

    if (difference.isNegative) {
      timeRemaining = '00:00:00';
      return;
    }

    final hours = difference.inHours.toString().padLeft(2, '0');
    final minutes = (difference.inMinutes % 60).toString().padLeft(2, '0');
    final seconds = (difference.inSeconds % 60).toString().padLeft(2, '0');

    timeRemaining = '$hours:$minutes:$seconds';
  }
} 