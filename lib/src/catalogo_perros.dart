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

class DogCatalog extends StatelessWidget {
  final List<Product> products = [
    Product(
      image: 'assets/images/comida_perros1.png',
      title: '🐾 Perro Gourmet 1',
      price: 12.50,
      description: '🥩 Nutrición balanceada para perros adultos.',
    ),
    Product(
      image: 'assets/images/comida_perros2.png',
      title: '🐾 Perro Gourmet 2',
      price: 20.00,
      description: '🍖 Especial para razas pequeñas.',
    ),
    Product(
      image: 'assets/images/comida_perros3.png',
      title: '🐾 Perro Gourmet 3',
      price: 18.00,
      description: '🍗 Húmeda rica en proteínas.',
    ),
    Product(
      image: 'assets/images/comida_perros4.png',
      title: '🐾 Perro Gourmet 4',
      price: 15.00,
      description: '🐓 A base de pollo para perros activos.',
    ),
    Product(
      image: 'assets/images/comida_perros5.png',
      title: '🐾 Perro Gourmet 5',
      price: 22.00,
      description: '😋 Sabor irresistible para tu mascota.',
    ),
    Product(
      image: 'assets/images/comida_perros6.png',
      title: '🐾 Perro Gourmet 6',
      price: 30.00,
      description: '💪 Con vitaminas y minerales.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFDF8F1),
      appBar: AppBar(
        backgroundColor: Color(0xFFFA8072),
        title: Text(
          '🐶 Catálogo Perruno',
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
                delegate: DogSearchDelegate(products),
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
      color: Color(0xFFFFF3E0),
      elevation: 6,
      shadowColor: Colors.orangeAccent,
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
                color: Colors.brown[800],
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

class DogSearchDelegate extends SearchDelegate {
  final List<Product> products;

  DogSearchDelegate(this.products);

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
      icon: Icon(Icons.arrow_back, color: Colors.brown),
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
          leading: Icon(Icons.pets, color: Colors.orange),
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
