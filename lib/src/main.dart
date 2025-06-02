import 'package:flutter/material.dart';
import 'catalogo_perros.dart';
import 'catalogo_cerdos.dart';
import 'catalogo_gallinas.dart';
import 'catalogo_gatos.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '🐾 Pet Shop Online',
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: Colors.grey[100],
        hintColor: Colors.greenAccent,
        fontFamily: 'Arial',
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.black),
          bodyMedium: TextStyle(color: Colors.black87),
        ),
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  final List<String> productImages = [
    'assets/images/comida_perros1.png',
    'assets/images/comida_perros2.png',
    'assets/images/comida_perros3.png',
    'assets/images/comida_perros4.png',
    'assets/images/comida_perros5.png',
    'assets/images/comida_perros6.png',
    'assets/images/comida_cerdos1.png',
    'assets/images/comida_cerdos2.png',
  ];

  final List<String> productTitles = [
    '🐶 Perro Gourmet 1',
    '🐶 Perro Gourmet 2',
    '🐶 Perro Gourmet 3',
    '🐶 Perro Gourmet 4',
    '🐶 Perro Gourmet 5',
    '🐶 Perro Gourmet 6',
    '🐷 Cerdo Delicioso 1',
    '🐷 Cerdo Delicioso 2',
  ];

  final List<double> productPrices = [
    15.00, 20.00, 12.50, 18.00, 25.00, 30.00, 22.00, 28.00,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🐾 Pet Shop Online'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchPage(
                    titles: productTitles,
                    images: productImages,
                    prices: productPrices,
                  ),
                ),
              );
            },
          ),
          Stack(
            children: [
              IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {},
              ),
              Positioned(
                right: 6,
                top: 6,
                child: Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: Text('3', style: TextStyle(color: Colors.white, fontSize: 12)),
                ),
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/portada.png'),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
              ),
              child: Center(
                child: Container(
                  padding: EdgeInsets.all(10),
                  color: Colors.black.withOpacity(0.4),
                  child: Text(
                    '🎉 ¡Ofertas Especiales! 🎉',
                    style: TextStyle(fontSize: 28, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.all(10),
              height: 50,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  CategoryChip(label: '🐶 Perros', onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DogCatalog()),
                    );
                  }),
                  CategoryChip(label: '🐷 Cerdos', onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PigCatalog()),
                    );
                  }),
                  CategoryChip(label: '🐔 Gallinas', onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ChickenCatalog()),
                    );
                  }),
                  CategoryChip(label: '😺 Gatos', onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CatCatalog()),
                    );
                  }),
                  CategoryChip(label: '🧴 Complementos', onTap: () {}),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '✨ Colecciones destacadas',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green[800]),
              ),
            ),
            GridView.count(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              crossAxisCount: 2,
              childAspectRatio: 0.7,
              children: List.generate(productImages.length, (index) {
                return ProductCard(
                  title: productTitles[index],
                  price: productPrices[index],
                  imageUrl: productImages[index],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryChip extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const CategoryChip({Key? key, required this.label, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        child: Chip(
          label: Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
          backgroundColor: Colors.green[100],
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final String title;
  final double price;
  final String imageUrl;

  const ProductCard({
    Key? key,
    required this.title,
    required this.price,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
            child: Image.asset(imageUrl, fit: BoxFit.cover, height: 120, width: double.infinity),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text('💲${price.toStringAsFixed(2)}', style: TextStyle(color: Colors.green[700], fontSize: 14)),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8, top: 4, bottom: 8),
            child: Row(
              children: List.generate(5, (index) {
                return Icon(Icons.star, color: index < 4 ? Colors.amber : Colors.grey, size: 14);
              }),
            ),
          ),
        ],
      ),
    );
  }
}

class SearchPage extends StatefulWidget {
  final List<String> titles;
  final List<String> images;
  final List<double> prices;

  const SearchPage({required this.titles, required this.images, required this.prices});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String query = "";

  @override
  Widget build(BuildContext context) {
    List<int> searchResults = [];
    for (int i = 0; i < widget.titles.length; i++) {
      if (widget.titles[i].toLowerCase().contains(query.toLowerCase())) {
        searchResults.add(i);
      }
    }

    return Scaffold(
      appBar: AppBar(title: Text('🔍 Buscar productos')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              onChanged: (value) => setState(() => query = value),
              decoration: InputDecoration(
                hintText: 'Escribe para buscar... 🔎',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
              children: searchResults.map((index) {
                return ProductCard(
                  title: widget.titles[index],
                  price: widget.prices[index],
                  imageUrl: widget.images[index],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
