import 'package:flutter/material.dart';

class Product {
  final String image;
  final String title;
  final double price;
  final String description;

  Product({
    required this.image,
    required this.title,
    required this.price,
    required this.description,
  });
}

class PigCatalog extends StatelessWidget {
  final List<Product> products = [
    Product(
      image: 'assets/images/comida_cerdos1.png',
      title: '🐷 Delicia Porcina 1',
      price: 10.99,
      description: '🌽 Mezcla premium de granos para cerdos felices.',
    ),
    Product(
      image: 'assets/images/comida_cerdos2.png',
      title: '🐷 Delicia Porcina 2',
      price: 14.50,
      description: '🍠 Con batata y minerales esenciales.',
    ),
    Product(
      image: 'assets/images/comida_cerdos3.png',
      title: '🐷 Delicia Porcina 3',
      price: 12.00,
      description: '🍏 Rica en frutas para un sabor único.',
    ),
    Product(
      image: 'assets/images/comida_cerdos4.png',
      title: '🐷 Delicia Porcina 4',
      price: 17.75,
      description: '🥬 Mezcla vegetal para mantener la pancita feliz.',
    ),
    Product(
      image: 'assets/images/comida_cerdos5.png',
      title: '🐷 Delicia Porcina 5',
      price: 19.90,
      description: '🥓 ¡Irresistible y 100% saludable!',
    ),
    Product(
      image: 'assets/images/comida_cerdos6.png',
      title: '🐷 Delicia Porcina 6',
      price: 22.30,
      description: '💖 Con amor y vitaminas para tu cerdito.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFF0F5),
      appBar: AppBar(
        backgroundColor: Color(0xFFE75480),
        title: Text(
          '🐖 Catálogo de Cerdos',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            onPressed: () {
              showSearch(
                context: context,
                delegate: PigSearchDelegate(products),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12.0,
            mainAxisSpacing: 12.0,
            childAspectRatio: 0.75,
          ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            return ProductCard(product: products[index]);
          },
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xFFFFE4E1),
      elevation: 6,
      shadowColor: Colors.pinkAccent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.asset(
              product.image,
              fit: BoxFit.cover,
              height: 120,
              width: double.infinity,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            child: Text(
              product.title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Colors.pink[800],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              '\$${product.price.toStringAsFixed(2)} 🛒',
              style: TextStyle(
                color: Colors.green[800],
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            child: Text(
              product.description,
              style: TextStyle(fontSize: 12, color: Colors.brown[600]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 4, bottom: 6),
            child: Row(
              children: List.generate(5, (starIndex) {
                return Icon(
                  Icons.star_rounded,
                  color: starIndex < 4 ? Colors.amber : Colors.grey[300],
                  size: 16,
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

class PigSearchDelegate extends SearchDelegate {
  final List<Product> products;

  PigSearchDelegate(this.products);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear, color: Colors.redAccent),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back, color: Colors.pink),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = products
        .where((product) =>
            product.title.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12.0,
        mainAxisSpacing: 12.0,
        childAspectRatio: 0.75,
      ),
      itemCount: results.length,
      itemBuilder: (context, index) {
        return ProductCard(product: results[index]);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = products
        .where((product) =>
            product.title.toLowerCase().startsWith(query.toLowerCase()))
        .toList();

    return ListView(
      children: suggestions.map((product) {
        return ListTile(
          leading: Icon(Icons.pets, color: Colors.pinkAccent),
          title: Text(product.title),
          onTap: () {
            query = product.title;
            showResults(context);
          },
        );
      }).toList(),
    );
  }
}
