class Product {
  final int id;
  final String name;
  final String description;
  final String category;
  final String subCategory;
  final double price;
  final double? discount; // optional
  int stock = 1;
  final String imageUrl;
  final List<String> gallery; // additional images
  final double rating;
  final bool isFavorite;
  final bool isFeatured;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int offerPrice;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.subCategory,
    required this.price,
    this.discount,
    required this.stock,
    required this.imageUrl,
    required this.gallery,
    required this.rating,
    this.isFavorite = false,
    this.isFeatured = false,
    required this.createdAt,
    required this.updatedAt,
    required this.offerPrice,
  });

  Product copyWith({
    int? id,
    String? name,
    String? description,
    String? category,
    String? subCategory,
    double? price,
    double? discount,
    int? stock = 1,
    String? imageUrl,
    List<String>? gallery,
    double? rating,
    bool? isFavorite,
    bool? isFeatured,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? offerPrice,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      category: category ?? this.category,
      subCategory: subCategory ?? this.subCategory,
      price: price ?? this.price,
      discount: discount ?? this.discount,
      stock: stock ?? this.stock,
      imageUrl: imageUrl ?? this.imageUrl,
      gallery: gallery ?? this.gallery,
      rating: rating ?? this.rating,
      isFavorite: isFavorite ?? this.isFavorite,
      isFeatured: isFeatured ?? this.isFeatured,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      offerPrice: offerPrice ?? this.offerPrice,
    );
  }

  // From JSON
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      category: json['category'],
      subCategory: json['subCategory'],
      price: (json['price'] as num).toDouble(),
      discount:
          json['discount'] != null
              ? (json['discount'] as num).toDouble()
              : null,
      stock: json['stock'],
      imageUrl: json['imageUrl'],
      gallery: List<String>.from(json['gallery']),
      rating: (json['rating'] as num).toDouble(),
      isFavorite: json['isFavorite'] ?? false,
      isFeatured: json['isFeatured'] ?? false,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      offerPrice: json['offerPrice'],
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'category': category,
      'subCategory': subCategory,
      'price': price,
      'discount': discount,
      'stock': stock,
      'imageUrl': imageUrl,
      'gallery': gallery,
      'rating': rating,
      'isFavorite': isFavorite,
      'isFeatured': isFeatured,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'offerPrice': offerPrice,
    };
  }
}

List<Product> sampleProducts = [
  Product(
    id: 0,
    name: 'Fresh Apple',
    description: 'Crisp and sweet organic apples.',
    category: 'Fruits',
    subCategory: 'Organic',
    price: 120.0,
    discount: 10,
    stock: 50,
    imageUrl:
        'https://media.istockphoto.com/id/834816218/photo/red-apple-fruit-with-half-and-green-leaf-isolated-on-white.jpg?s=612x612&w=0&k=20&c=CAwW2uRYUNm5HyEN4iWTSx-2E9EyqFp-7VS2n7wFnIo=',
    gallery: [
      'https://example.com/images/apple1.jpg',
      'https://example.com/images/apple2.jpg',
    ],
    rating: 4.5,
    isFavorite: false,
    isFeatured: true,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    offerPrice: 100,
  ),
  Product(
    id: 1,
    name: 'Whole Milk',
    description: 'Rich and creamy whole milk.',
    category: 'Dairy',
    subCategory: 'Milk',
    price: 65.0,
    discount: null,
    stock: 120,
    imageUrl:
        'https://media.istockphoto.com/id/1398613299/photo/glass-of-milk-isolated-on-white.jpg?s=612x612&w=0&k=20&c=GBGTeZA9AAqKVf0DmTo2qtY6uSlDorGWDhCK2rFOkdw=',
    gallery: [],
    rating: 4.2,
    isFavorite: false,
    isFeatured: false,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    offerPrice: 100,
  ),
  Product(
    id: 2,
    name: 'Brown Bread',
    description: 'Healthy and fiber-rich brown bread.',
    category: 'Bakery',
    subCategory: 'Bread',
    price: 45.0,
    discount: 5,
    stock: 60,
    imageUrl:
        'https://media.istockphoto.com/id/172782814/photo/slice-of-brown-bread-isolated-on-white-background.jpg?s=612x612&w=0&k=20&c=b1LwstWWUvTHWMN9KTdjMbHL4BqXeer2fSFQ8QJEYlc=',
    gallery: [],
    rating: 4.0,
    isFavorite: false,
    isFeatured: false,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    offerPrice: 100,
  ),
  Product(
    id: 3,
    name: 'Chicken Breast',
    description: 'Fresh and skinless chicken breast.',
    category: 'Meat',
    subCategory: 'Chicken',
    price: 180.0,
    discount: 20,
    stock: 35,
    imageUrl:
        'https://media.istockphoto.com/id/511486326/photo/raw-chicken-fillets-close-up-isolated-on-white.jpg?s=612x612&w=0&k=20&c=ptabozbp4iO9pLZONQqjlUTSUfUl02Df37G19IOIfGU=',
    gallery: [],
    rating: 4.6,
    isFavorite: false,
    isFeatured: true,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    offerPrice: 100,
  ),
  Product(
    id: 4,
    name: 'Banana',
    description: 'Sweet and ripe bananas.',
    category: 'Fruits',
    subCategory: 'Fresh',
    price: 30.0,
    discount: null,
    stock: 200,
    imageUrl:
        'https://media.istockphoto.com/id/173242750/photo/banana-bunch.jpg?s=612x612&w=0&k=20&c=MAc8AXVz5KxwWeEmh75WwH6j_HouRczBFAhulLAtRUU=',
    gallery: [],
    rating: 4.3,
    isFavorite: false,
    isFeatured: true,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    offerPrice: 100,
  ),
  Product(
    id: 5,
    name: 'Tomato',
    description: 'Farm fresh red tomatoes.',
    category: 'Vegetables',
    subCategory: 'Fresh',
    price: 25.0,
    discount: 5,
    stock: 150,
    imageUrl:
        'https://media.istockphoto.com/id/1450576005/photo/tomato-isolated-tomato-on-white-background-perfect-retouched-tomatoe-side-view-with-clipping.jpg?s=612x612&w=0&k=20&c=lkQa_rpaKpc-ELRRGobYVJH-eMJ0ew9BckCqavkSTA0=',
    gallery: [],
    rating: 4.1,
    isFavorite: false,
    isFeatured: false,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    offerPrice: 100,
  ),
  Product(
    id: 6,
    name: 'Chips Pack',
    description: 'Crispy and salty potato chips.',
    category: 'Snacks',
    subCategory: 'Chips',
    price: 20.0,
    discount: null,
    stock: 300,
    imageUrl:
        'https://media.istockphoto.com/id/1740868211/vector/realistic-mockup-package-of-yellow-chips-package-with-label-isolated-on-white-background.jpg?s=612x612&w=0&k=20&c=0BM3UdqcL5zfl2-mBsGFlh69r65Xcn73HCUGOnGOYrg=',
    gallery: [],
    rating: 4.0,
    isFavorite: false,
    isFeatured: false,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    offerPrice: 100,
  ),
  Product(
    id: 7,
    name: 'Orange Juice',
    description: 'Refreshing orange juice with no added sugar.',
    category: 'Beverages',
    subCategory: 'Juice',
    price: 75.0,
    discount: 10,
    stock: 100,
    imageUrl:
        'https://media.istockphoto.com/id/168410143/photo/glass-of-orange-juice.jpg?s=612x612&w=0&k=20&c=nwLC2r-ceY19z6EY4vpGmurO0dlv2BVieR4HOOTAbQw=',
    gallery: [],
    rating: 4.4,
    isFavorite: false,
    isFeatured: true,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    offerPrice: 100,
  ),
  Product(
    id: 8,
    name: 'Cheese Block',
    description: 'Delicious cheddar cheese block.',
    category: 'Dairy',
    subCategory: 'Cheese',
    price: 150.0,
    discount: 15,
    stock: 40,
    imageUrl:
        'https://media.istockphoto.com/id/652385154/photo/piece-of-cheese-on-the-table.jpg?s=612x612&w=0&k=20&c=9iYJWMLxH4ixhYE2tCxn1XL3E8ptbJ-Fj23kHc1Qj4c=',
    gallery: [],
    rating: 4.7,
    isFavorite: false,
    isFeatured: true,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    offerPrice: 100,
  ),
  Product(
    id: 9,
    name: 'Cucumber',
    description: 'Cool and crunchy fresh cucumbers.',
    category: 'Vegetables',
    subCategory: 'Fresh',
    price: 18.0,
    discount: null,
    stock: 90,
    imageUrl:
        'https://media.istockphoto.com/id/895071966/photo/raw-green-cucumbers.webp?s=2048x2048&w=is&k=20&c=3FxYn9jDYDvwhzxw-hj7-6PYrqRjAo_StLb_tvSZDFs=',
    gallery: [],
    rating: 4.2,
    isFavorite: false,
    isFeatured: false,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    offerPrice: 100,
  ),
];
