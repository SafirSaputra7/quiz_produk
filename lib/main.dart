import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Grid Produk Interaktif',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const ProductCategoryPage(),
    );
  }
}

class ProductCategoryPage extends StatelessWidget {
  const ProductCategoryPage({super.key});

  // Daftar kategori produk utama
  final List<Map<String, dynamic>> categories = const [
    {'icon': Icons.phone_iphone, 'name': 'Smartphone'},
    {'icon': Icons.laptop, 'name': 'Laptop'},
    {'icon': Icons.watch, 'name': 'Smartwatch'},
    {'icon': Icons.tv, 'name': 'Smart TV'},
    {'icon': Icons.keyboard, 'name': 'Keyboard'},
    {'icon': Icons.camera, 'name': 'Camera'},
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final crossAxisCount = screenWidth > 600 ? 3 : 2;

    return Scaffold(
      backgroundColor: Colors.teal.shade50,
      appBar: AppBar(
        title: const Text('Kategori Produk'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          itemCount: categories.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.8,
          ),
          itemBuilder: (context, index) {
            final category = categories[index];
            return CategoryCard(
              icon: category['icon'],
              name: category['name'],
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ProductListPage(categoryName: category['name']),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

// Widget kartu kategori produk
class CategoryCard extends StatefulWidget {
  final IconData icon;
  final String name;
  final VoidCallback onTap;

  const CategoryCard({
    super.key,
    required this.icon,
    required this.name,
    required this.onTap,
  });

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      onHover: (hover) => setState(() => _hovered = hover),
      borderRadius: BorderRadius.circular(16),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: _hovered
                  ? Colors.teal.withOpacity(0.3)
                  : Colors.grey.withOpacity(0.2),
              blurRadius: _hovered ? 12 : 6,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(widget.icon, size: 60, color: Colors.teal.shade400),
            const SizedBox(height: 10),
            Text(
              widget.name,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}

// Halaman daftar produk berdasarkan kategori
class ProductListPage extends StatelessWidget {
  final String categoryName;

  const ProductListPage({super.key, required this.categoryName});

  // Daftar produk per kategori
  List<Map<String, dynamic>> getProducts(String category) {
    switch (category) {
      case 'Smartphone':
        return [
          {'name': 'Samsung Galaxy A55', 'price': 'Rp 5.999.000', 'icon': Icons.phone_android},
          {'name': 'Xiaomi Redmi Note 13', 'price': 'Rp 3.499.000', 'icon': Icons.phone_iphone},
          {'name': 'Lenovo Vibe K5', 'price': 'Rp 2.899.000', 'icon': Icons.smartphone},
          {'name': 'Oppo Reno 11', 'price': 'Rp 4.999.000', 'icon': Icons.phone_iphone},
        ];
      case 'Laptop':
        return [
          {'name': 'Acer Aspire 5', 'price': 'Rp 7.200.000', 'icon': Icons.laptop_mac},
          {'name': 'Asus Vivobook', 'price': 'Rp 8.500.000', 'icon': Icons.laptop},
          {'name': 'Lenovo IdeaPad', 'price': 'Rp 6.999.000', 'icon': Icons.laptop_chromebook},
        ];
      case 'Smartwatch':
        return [
          {'name': 'Apple Watch 8', 'price': 'Rp 7.000.000', 'icon': Icons.watch},
          {'name': 'Xiaomi Mi Band 8', 'price': 'Rp 599.000', 'icon': Icons.fitness_center},
          {'name': 'Samsung Galaxy Watch', 'price': 'Rp 4.200.000', 'icon': Icons.watch_later},
        ];
      case 'Smart TV':
        return [
          {'name': 'LG 43 Inch', 'price': 'Rp 4.800.000', 'icon': Icons.tv},
          {'name': 'Samsung 50 Inch', 'price': 'Rp 6.500.000', 'icon': Icons.tv_rounded},
          {'name': 'Polytron LED 40"', 'price': 'Rp 3.900.000', 'icon': Icons.tv_outlined},
        ];
      case 'Keyboard':
        return [
          {'name': 'Keyboard Logitech', 'price': 'Rp 483.000', 'icon': Icons.keyboard},
          {'name': 'Logitech MX KEYSS Keyboard', 'price': 'Rp 1.733.000', 'icon': Icons.keyboard_rounded},
          {'name': 'Wireless Rexus"', 'price': 'Rp 209.000', 'icon': Icons.keyboard_outlined},
        ];
        case 'Camera':
        return [
          {'name': 'Mirrorless Sony A5000', 'price': 'Rp 750.000', 'icon': Icons.camera},
          {'name': 'Fujifilm Instax Mini 12 ', 'price': 'Rp 1.383.000', 'icon': Icons.camera_rounded},
          {'name': 'Canon EOS 1300D"', 'price': 'Rp 3.099.000', 'icon': Icons.camera_outlined},
        ];
      default:
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final products = getProducts(categoryName);
    final screenWidth = MediaQuery.of(context).size.width;
    final crossAxisCount = screenWidth > 600 ? 3 : 2;

    return Scaffold(
      backgroundColor: Colors.teal.shade50,
      appBar: AppBar(
        title: Text('Daftar $categoryName'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          itemCount: products.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.85,
          ),
          itemBuilder: (context, index) {
            final product = products[index];
            return ProductCard(
              icon: product['icon'],
              name: product['name'],
              price: product['price'],
            );
          },
        ),
      ),
    );
  }
}

// Widget kartu produk individual
class ProductCard extends StatefulWidget {
  final IconData icon;
  final String name;
  final String price;

  const ProductCard({
    super.key,
    required this.icon,
    required this.name,
    required this.price,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Kamu memilih: ${widget.name}')),
        );
      },
      onHover: (hover) => setState(() => _hovered = hover),
      borderRadius: BorderRadius.circular(16),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: _hovered
                  ? Colors.teal.withOpacity(0.3)
                  : Colors.grey.withOpacity(0.2),
              blurRadius: _hovered ? 12 : 6,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(widget.icon, size: 55, color: Colors.teal.shade400),
            const SizedBox(height: 10),
            Text(
              widget.name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              widget.price,
              style: TextStyle(
                color: Colors.teal.shade700,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
