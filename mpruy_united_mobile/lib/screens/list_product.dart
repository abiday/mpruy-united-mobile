import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:mpruy_united_mobile/models/product_entry.dart';
import 'package:mpruy_united_mobile/widgets/left_drawer.dart';
import 'package:mpruy_united_mobile/screens/product_detail.dart';
import 'package:flutter/foundation.dart' show kIsWeb; // Untuk cek platform web/mobile

class ProductEntryPage extends StatefulWidget {
  // Variabel filter: false = Semua Produk, true = Produk Saya
  final bool filterByUser;

  const ProductEntryPage({super.key, this.filterByUser = false});

  @override
  State<ProductEntryPage> createState() => _ProductEntryPageState();
}

class _ProductEntryPageState extends State<ProductEntryPage> {
  // URL Backend Dinamis
  String get _backendUrl => kIsWeb ? 'http://localhost:8000' : 'http://10.0.2.2:8000';

  Future<List<ProductEntry>> fetchProduct(CookieRequest request) async {
    // Endpoint dasar
    String endpoint = '$_backendUrl/json/';
    
    // Jika filter menyala, tambahkan query parameter ?filter=user
    // Ini akan ditangkap oleh views.py di Django: request.GET.get("filter")
    if (widget.filterByUser) {
      endpoint += '?filter=user';
    }

    final response = await request.get(endpoint);

    // Decode response menjadi list of ProductEntry
    var data = response;
    List<ProductEntry> listProduct = [];
    for (var d in data) {
      if (d != null) {
        listProduct.add(ProductEntry.fromJson(d));
      }
    }
    return listProduct;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    
    // Judul halaman berubah sesuai konteks
    final String pageTitle = widget.filterByUser ? 'My Products' : 'All Products';

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(pageTitle),
        backgroundColor: const Color(0xFF004D98), // barcaBlue
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: FutureBuilder(
        future: fetchProduct(request),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else {
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.remove_shopping_cart, size: 60, color: Colors.grey),
                    const SizedBox(height: 16),
                    Text(
                      // Pesan kosong yang berbeda tergantung filter
                      widget.filterByUser 
                          ? "Anda belum menambahkan produk." 
                          : "Belum ada data produk di toko.",
                      style: const TextStyle(color: Colors.grey, fontSize: 20),
                    ),
                  ],
                ),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (_, index) {
                  final product = snapshot.data![index];
                  final fields = product.fields;

                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailPage(product: product),
                        ),
                      );
                    },
                    child: Card(
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      elevation: 2,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(color: Colors.grey.shade200),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // --- THUMBNAIL IMAGE (KIRI) ---
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Container(
                                width: 100,
                                height: 100,
                                color: Colors.grey[100],
                                child: fields.thumbnail.isNotEmpty
                                    ? Image.network(
                                        fields.thumbnail,
                                        fit: BoxFit.cover,
                                        errorBuilder: (ctx, err, stack) => const Icon(Icons.broken_image, color: Colors.grey),
                                      )
                                    : const Icon(Icons.shopping_bag, color: Colors.grey),
                              ),
                            ),
                            const SizedBox(width: 16),
                            
                            // --- INFO PRODUK (KANAN) ---
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Kategori & Featured Badge
                                  Row(
                                    children: [
                                      if (fields.isFeatured)
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                          margin: const EdgeInsets.only(right: 8),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFA50044), // barcaRed
                                            borderRadius: BorderRadius.circular(4),
                                          ),
                                          child: const Text("Featured", style: TextStyle(color: Colors.white, fontSize: 10)),
                                        ),
                                      Text(
                                        fields.category,
                                        style: TextStyle(color: Colors.grey[600], fontSize: 12),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  
                                  // Nama Produk
                                  Text(
                                    fields.name,
                                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  
                                  const SizedBox(height: 8),
                                  
                                  // Harga
                                  Text(
                                    "Rp ${fields.price}",
                                    style: const TextStyle(
                                      fontSize: 15, 
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF004D98), // barcaBlue
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          }
        },
      ),
    );
  }
}