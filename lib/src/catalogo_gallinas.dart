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

class ChickenCatalog extends StatelessWidget {
  final List<Product> products = [
    Product(
      image: 'assets/images/comida_gallinas1.png',
      title: 'Gallina Gourmet 1',
      price: 12.50,
      description: 'Nutrición balanceada para gallinas adultas.',
    ),
    Product(
      image: 'assets/images/comida_gallinas2.png',
      title: 'Gallina Gourmet 2',
      price: 20.00,
      description: 'Alimento especial para gallinas de razas pequeñas.',
    ),
    Product(
      image: 'assets/images/comida_gallinas3.png',
      title: 'Gallina Gourmet 3',
      price: 18.00,
      description: 'Comida húmeda rica en proteínas para gallinas.',
    ),
    Product(
      image: 'assets/images/comida_gallinas4.png',
      title: 'Gallina Gourmet 4',
      price: 15.00,
      description: 'Alimento a base de maíz para gallinas ponedoras.',
    ),
    Product(
      image: 'assets/images/comida_gallinas5.png',
      title: 'Gallina Gourmet 5',
      price: 22.00,
      description: 'Sabor irresistible para gallinas y aves de corral.',
    ),
    Product(
      image: 'assets/images/comida_gallinas6.png',
      title: 'Gallina Gourmet 6',
      price: 30.00,
      description: 'Comida premium con vitaminas y minerales para gallinas.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Catálogo de Gallinas'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: ChickenSearchDelegate(products),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
          ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return ProductCard(product: product);
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
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
            child: Image.asset(
              product.image,
              fit: BoxFit.cover,
              height: 120,
              width: double.infinity,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              product.title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              '\$${product.price.toStringAsFixed(2)}',
              style: TextStyle(color: Colors.green[700], fontSize: 14),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              product.description,
              style: TextStyle(fontSize: 12, color: Colors.black54),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8, bottom: 8),
            child: Row(
              children: List.generate(5, (starIndex) {
                return Icon(
                  Icons.star,
                  color: starIndex < 4 ? Colors.amber : Colors.grey,
                  size: 12,
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

class ChickenSearchDelegate extends SearchDelegate {
  final List<Product> products;

  ChickenSearchDelegate(this.products);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
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
      padding: const EdgeInsets.all(8.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
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
