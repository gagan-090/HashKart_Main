import '../models/product_model.dart';

final List<Product> allProducts = [
  // Products from HomeScreen
  Product(
    id: 'wireless_headphones_001',
    name: 'Wireless Headphones',
    price: 'Rs.8300',
    originalPrice: 'Rs.10800',
    rating: 4.5,
    imageUrls: [
      'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=600',
      'https://images.unsplash.com/photo-1484704849700-f032a568e944?w=600',
      'https://images.unsplash.com/photo-1583394838336-acd977736f90?w=600',
    ],
    description:
        'Experience premium sound quality with these wireless Bluetooth headphones. Featuring advanced noise cancellation technology.',
    categoryId: 'electronics',
  ),
  Product(
    id: 'smart_watch_001',
    name: 'Smart Watch',
    price: 'Rs.1660',
    originalPrice: 'Rs.2080',
    rating: 4.8,
    imageUrls: [
      'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=600',
      'https://images.unsplash.com/photo-1546868871-7041f2a55e12?w=600'
    ],
    description:
        'Stay connected and track your fitness with this advanced smartwatch featuring heart rate monitoring and GPS.',
    categoryId: 'electronics',
  ),
  Product(
    id: 'laptop_backpack_001',
    name: 'Laptop Backpack',
    price: 'Rs.4150',
    originalPrice: 'Rs.5800',
    rating: 4.3,
    imageUrls: [
      'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=600'
    ],
    description:
        'Durable and stylish laptop backpack with multiple compartments and water-resistant material.',
    categoryId: 'accessories',
  ),
  Product(
    id: 'coffee_maker_001',
    name: 'Coffee Maker',
    price: 'Rs.6650',
    originalPrice: 'Rs.8300',
    rating: 4.6,
    imageUrls: [
      'https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?w=600'
    ],
    description:
        'Brew the perfect cup of coffee every morning with this programmable coffee maker.',
    categoryId: 'home_appliances',
  ),
  Product(
    id: 'gaming_mouse_001',
    name: 'Gaming Mouse',
    price: 'Rs.5000',
    originalPrice: 'Rs.6650',
    rating: 4.7,
    imageUrls: [
      'https://images.unsplash.com/photo-1527814050087-3793815479db?w=600'
    ],
    description:
        'High-precision gaming mouse with customizable RGB lighting and programmable buttons.',
    categoryId: 'electronics',
  ),
  Product(
    id: 'bluetooth_speaker_001',
    name: 'Bluetooth Speaker',
    price: 'Rs.7500',
    originalPrice: 'Rs.10000',
    rating: 4.4,
    imageUrls: [
      'https://images.unsplash.com/photo-1608043152269-423dbba4e7e1?w=600'
    ],
    description:
        'Portable Bluetooth speaker with 360-degree sound and waterproof design.',
    categoryId: 'electronics',
  ),
  Product(
    id: 'smartphone_001',
    name: 'Smartphone',
    price: 'Rs.58200',
    originalPrice: 'Rs.66500',
    rating: 4.6,
    imageUrls: [
      'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=600'
    ],
    description:
        'Latest smartphone with advanced camera system, fast processor, and all-day battery life.',
    categoryId: 'mobile_phones',
  ),
  Product(
    id: 'tablet_001',
    name: 'Tablet',
    price: 'Rs.25000',
    originalPrice: 'Rs.33200',
    rating: 4.5,
    imageUrls: [
      'https://images.unsplash.com/photo-1544244015-0df4b3ffc6b0?w=600'
    ],
    description:
        '10-inch tablet perfect for work and entertainment with high-resolution display.',
    categoryId: 'mobile_phones',
  ),
  Product(
    id: 'wireless_earbuds_001',
    name: 'Wireless Earbuds',
    price: 'Rs.12500',
    originalPrice: 'Rs.16600',
    rating: 4.8,
    imageUrls: [
      'https://images.unsplash.com/photo-1590658268037-6bf12165a8df?w=600'
    ],
    description:
        'True wireless earbuds with active noise cancellation and premium sound quality.',
    categoryId: 'electronics',
  ),
  Product(
    id: 'fitness_tracker_001',
    name: 'Fitness Tracker',
    price: 'Rs.10800',
    originalPrice: 'Rs.13300',
    rating: 4.3,
    imageUrls: [
      'https://images.unsplash.com/photo-1575311373937-040b8e1fd5b6?w=600'
    ],
    description:
        'Track your daily activities, heart rate, and sleep patterns with this advanced fitness tracker.',
    categoryId: 'electronics',
  ),
  // Products from SubcategoryScreen
  Product(
    id: 'iphone_15_pro_001',
    name: 'iPhone 15 Pro',
    price: 'Rs.83000',
    originalPrice: 'Rs.91500',
    rating: 4.8,
    imageUrls: [
      'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=300'
    ],
    description: 'Latest iPhone with titanium design',
    categoryId: 'mobile_phones',
  ),
  Product(
    id: 'samsung_galaxy_s24_001',
    name: 'Samsung Galaxy S24',
    price: 'Rs.74800',
    originalPrice: 'Rs.83000',
    rating: 4.6,
    imageUrls: [
      'https://images.unsplash.com/photo-1610945265064-0e34e5519bbf?w=300'
    ],
    description: 'Flagship Android smartphone',
    categoryId: 'mobile_phones',
  ),
  Product(
    id: 'google_pixel_8_001',
    name: 'Google Pixel 8',
    price: 'Rs.58200',
    originalPrice: 'Rs.66500',
    rating: 4.5,
    imageUrls: [
      'https://images.unsplash.com/photo-1598300042247-d088f8ab3a91?w=300'
    ],
    description: 'Pure Android experience',
    categoryId: 'mobile_phones',
  ),
  Product(
    id: 'oneplus_12_001',
    name: 'OnePlus 12',
    price: 'Rs.66500',
    originalPrice: 'Rs.74800',
    rating: 4.4,
    imageUrls: [
      'https://images.unsplash.com/photo-1592750475338-74b7b21085ab?w=300'
    ],
    description: 'Never Settle flagship',
    categoryId: 'mobile_phones',
  ),
  Product(
    id: 'xiaomi_14_001',
    name: 'Xiaomi 14',
    price: 'Rs.54000',
    originalPrice: 'Rs.62300',
    rating: 4.3,
    imageUrls: [
      'https://images.unsplash.com/photo-1574944985070-8f3ebc6b79d2?w=300'
    ],
    description: 'Premium at affordable price',
    categoryId: 'mobile_phones',
  ),
  Product(
    id: 'nothing_phone_2_001',
    name: 'Nothing Phone 2',
    price: 'Rs.20000',
    originalPrice: 'Rs.58200',
    rating: 4.2,
    imageUrls: [
      'https://images.unsplash.com/photo-1605236453806-6ff36851218e?w=300'
    ],
    description: 'Unique transparent design',
    categoryId: 'mobile_phones',
  ),
  
  // Beauty Products
  Product(
    id: 'facial_cleanser_001',
    name: 'Facial Cleanser',
    price: 'Rs.990',
    originalPrice: 'Rs.1290',
    rating: 4.5,
    imageUrls: [
      'https://images.unsplash.com/photo-1556228720-195a672e8a03?w=300',
    ],
    description: 'Gentle daily facial cleanser for all skin types',
    categoryId: 'beauty',
  ),
  Product(
    id: 'micellar_water_001',
    name: 'Micellar Water',
    price: 'Rs.890',
    originalPrice: 'Rs.1190',
    rating: 4.7,
    imageUrls: [
      'https://images.unsplash.com/photo-1556228720-195a672e8a03?w=300',
    ],
    description: 'Makeup remover and skin cleanser in one',
    categoryId: 'beauty',
  ),
  Product(
    id: 'hydrating_toner_001',
    name: 'Hydrating Toner',
    price: 'Rs.1250',
    originalPrice: 'Rs.1590',
    rating: 4.6,
    imageUrls: [
      'https://images.unsplash.com/photo-1556228720-195a672e8a03?w=300',
    ],
    description: 'Alcohol-free toner for sensitive skin',
    categoryId: 'beauty',
  ),
  Product(
    id: 'vitamin_c_serum_001',
    name: 'Vitamin C Serum',
    price: 'Rs.2490',
    originalPrice: 'Rs.2990',
    rating: 4.8,
    imageUrls: [
      'https://images.unsplash.com/photo-1556228720-195a672e8a03?w=300',
    ],
    description: 'Brightening serum with antioxidant protection',
    categoryId: 'beauty',
  ),
  Product(
    id: 'cream_cleanser_001',
    name: 'Cream Cleanser',
    price: 'Rs.1590',
    originalPrice: 'Rs.1990',
    rating: 4.4,
    imageUrls: [
      'https://images.unsplash.com/photo-1556228720-195a672e8a03?w=300',
    ],
    description: 'Hydrolize elixir for dry skin',
    categoryId: 'beauty',
  ),
  Product(
    id: 'bath_bomb_001',
    name: 'Bath Bomb',
    price: 'Rs.650',
    originalPrice: 'Rs.890',
    rating: 4.3,
    imageUrls: [
      'https://images.unsplash.com/photo-1556228720-195a672e8a03?w=300',
    ],
    description: 'Lavender scented relaxing bath bomb',
    categoryId: 'beauty',
  ),
  Product(
    id: 'lipstick_001',
    name: 'Lipstick',
    price: 'Rs.1890',
    originalPrice: 'Rs.2290',
    rating: 4.6,
    imageUrls: [
      'https://images.unsplash.com/photo-1556228720-195a672e8a03?w=300',
    ],
    description: 'Long-lasting matte lipstick',
    categoryId: 'beauty',
  ),
  Product(
    id: 'herbal_scrub_001',
    name: 'Herbal Scrub',
    price: 'Rs.1490',
    originalPrice: 'Rs.1890',
    rating: 4.5,
    imageUrls: [
      'https://images.unsplash.com/photo-1556228720-195a672e8a03?w=300',
    ],
    description: 'Natural exfoliating body scrub',
    categoryId: 'beauty',
  ),
  Product(
    id: 'moisturizer_001',
    name: 'Moisturizer',
    price: 'Rs.2290',
    originalPrice: 'Rs.2890',
    rating: 4.7,
    imageUrls: [
      'https://images.unsplash.com/photo-1556228720-195a672e8a03?w=300',
    ],
    description: '24-hour hydration for all skin types',
    categoryId: 'beauty',
  ),
  Product(
    id: 'sunscreen_spf50_001',
    name: 'Sunscreen SPF 50',
    price: 'Rs.1690',
    originalPrice: 'Rs.2190',
    rating: 4.6,
    imageUrls: [
      'https://images.unsplash.com/photo-1556228720-195a672e8a03?w=300',
    ],
    description: 'Broad spectrum protection with matte finish',
    categoryId: 'beauty',
  ),
  Product(
    id: 'eye_cream_001',
    name: 'Eye Cream',
    price: 'Rs.1990',
    originalPrice: 'Rs.2490',
    rating: 4.5,
    imageUrls: [
      'https://images.unsplash.com/photo-1556228720-195a672e8a03?w=300',
    ],
    description: 'Anti-aging eye treatment with peptides',
    categoryId: 'beauty',
  ),
  Product(
    id: 'face_mask_001',
    name: 'Face Mask',
    price: 'Rs.890',
    originalPrice: 'Rs.1290',
    rating: 4.4,
    imageUrls: [
      'https://images.unsplash.com/photo-1556228720-195a672e8a03?w=300',
    ],
    description: 'Clay mask for deep pore cleansing',
    categoryId: 'beauty',
  ),
];
