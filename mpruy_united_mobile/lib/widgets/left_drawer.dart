import 'package:flutter/material.dart';
import 'package:mpruy_united_mobile/menu.dart';
import 'package:mpruy_united_mobile/product_entry_form.dart';
import 'package:mpruy_united_mobile/screens/list_product.dart';
import 'package:mpruy_united_mobile/screens/login.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xFF004D98), // barcaBlue
            ),
            child: Column(
              children: [
                Text(
                  'Mpruy United Shop',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Padding(padding: EdgeInsets.all(10)),
                Text(
                  "Ayo beli kebutuhan bola-mu di sini!",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
              ],
            ),
          ),
          
          // --- Menu Halaman Utama ---
          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text('Halaman Utama'),
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => MyHomePage()),
              );
            },
          ),

          // --- Menu Daftar Produk (All) ---
          ListTile(
            leading: const Icon(Icons.shopping_bag),
            title: const Text('Daftar Produk'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    // Default: Tampilkan semua (filterByUser: false)
                    builder: (context) => const ProductEntryPage(filterByUser: false),
                  ));
            },
          ),

          // --- Menu Produk Saya (User Only) ---
          ListTile(
            leading: const Icon(Icons.inventory),
            title: const Text('Produk Saya'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    // Filter: Hanya user ini (filterByUser: true)
                    builder: (context) => const ProductEntryPage(filterByUser: true),
                  ));
            },
          ),

          // --- Menu Tambah Produk ---
          ListTile(
            leading: const Icon(Icons.add_shopping_cart),
            title: const Text('Tambah Produk'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProductEntryFormPage()),
              );
            },
          ),

          // --- Menu Logout ---
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () async {
              final response = await request.logout(
                // Gunakan URL Dinamis jika perlu, tapi 127.0.0.1 relatif aman di sini
                "http://127.0.0.1:8000/auth/logout/",
              );
              String message = response["message"];
              if (context.mounted) {
                if (response['status']) {
                  String uname = response["username"];
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("$message Sampai jumpa, $uname."),
                  ));
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(message),
                  ));
                }
              }
            },
          ),
        ],
      ),
    );
  }
} 