import 'package:flutter/material.dart';
// Impor widget Drawer
import 'package:mpruy_united_mobile/widgets/left_drawer.dart';
// Impor halaman Form Tambah Produk
import 'package:mpruy_united_mobile/product_entry_form.dart';
// Impor halaman List Produk
import 'package:mpruy_united_mobile/screens/list_product.dart'; 

// --- DATA MODEL ---
class ItemHomepage {
  final String name;
  final IconData icon;
  final Color color;

  ItemHomepage(this.name, this.icon, this.color);
}

// --- MAIN PAGE WIDGET ---
class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  final String nama = "Abid Dayyan Putra Rahardjo";
  final String npm = "2406356580";
  final String kelas = "F";

  static const Color barcaBlue = Color(0xFF004D98);
  static const Color barcaRed = Color(0xFFA50044);

  final List<ItemHomepage> items = [
    ItemHomepage("All Products", Icons.shopping_bag, barcaBlue),
    ItemHomepage("My Products", Icons.inventory, barcaRed),
    ItemHomepage("Create Product", Icons.add_shopping_cart, barcaBlue),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Mpruy United Shop',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: barcaBlue,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: const LeftDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InfoCard(title: 'NPM', content: npm),
                InfoCard(title: 'Name', content: nama),
                InfoCard(title: 'Class', content: kelas),
              ],
            ),
            const SizedBox(height: 16.0),
            Center(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Text(
                      'Welcome to Mpruy United Shop',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0,
                        color: barcaBlue,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  GridView.count(
                    primary: true,
                    padding: const EdgeInsets.all(20),
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    crossAxisCount: 3,
                    shrinkWrap: true,
                    children: items.map((ItemHomepage item) {
                      return ItemCard(item);
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- INFO CARD WIDGET ---
class InfoCard extends StatelessWidget {
  final String title;
  final String content;

  const InfoCard({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      child: Container(
        width: MediaQuery.of(context).size.width / 3.5,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Text(
              content,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

// --- ITEM CARD WIDGET ---
class ItemCard extends StatelessWidget {
  final ItemHomepage item;

  const ItemCard(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: item.color,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: () {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text("Kamu telah menekan tombol ${item.name}!")),
            );

          // --- NAVIGASI SESUAI TOMBOL ---
          if (item.name == "Create Product") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProductEntryFormPage()),
            );
          } 
          else if (item.name == "All Products") {
            // Kirim parameter false untuk melihat semua
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProductEntryPage(filterByUser: false)),
            );
          }
          else if (item.name == "My Products") {
            // Kirim parameter true untuk melihat produk sendiri
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProductEntryPage(filterByUser: true)),
            );
          }
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  item.icon,
                  color: Colors.white,
                  size: 32.0,
                ),
                const Padding(padding: EdgeInsets.all(3)),
                Text(
                  item.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}