import 'package:flutter/material.dart';
import 'package:mpruy_united_mobile/models/product_entry.dart';

class ProductDetailPage extends StatelessWidget {
  final ProductEntry product;

  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    // Mengambil data fields untuk mempersingkat kode
    final fields = product.fields;

    return Scaffold(
      appBar: AppBar(
        title: Text(fields.name),
        backgroundColor: const Color(0xFF004D98), // barcaBlue
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- BAGIAN 1: MAIN IMAGE (THUMBNAIL) ---
            SizedBox(
              width: double.infinity,
              height: 300, // Tinggi gambar fixed agar rapi
              child: fields.thumbnail.isNotEmpty
                  ? Image.network(
                      fields.thumbnail,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[300],
                          child: const Center(
                              child: Icon(Icons.broken_image, size: 50, color: Colors.grey)),
                        );
                      },
                    )
                  : Container(
                      color: Colors.grey[300],
                      child: const Center(
                          child: Icon(Icons.image_not_supported, size: 50, color: Colors.grey)),
                    ),
            ),

            // --- BAGIAN 2: INFORMASI UTAMA ---
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Row untuk Kategori dan Badge Featured
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Chip(
                        label: Text(
                          fields.category,
                          style: const TextStyle(color: Colors.white),
                        ),
                        backgroundColor: const Color(0xFF004D98), // barcaBlue
                      ),
                      // Tampilkan Badge jika Featured
                      if (fields.isFeatured)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: const Color(0xFFA50044), // barcaRed
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Row(
                            children: [
                              Icon(Icons.star, color: Colors.white, size: 16),
                              SizedBox(width: 4),
                              Text(
                                "Featured",
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                  
                  const SizedBox(height: 16),

                  // Nama Produk
                  Text(
                    fields.name,
                    style: const TextStyle(
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Harga
                  Text(
                    "Rp ${fields.price}",
                    style: const TextStyle(
                      fontSize: 22.0,
                      color: Color(0xFFA50044), // barcaRed
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  
                  const SizedBox(height: 8),
                  
                  // Rating
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber),
                      const SizedBox(width: 4),
                      Text(
                        "${fields.rating} / 5.0",
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),
                  const Divider(),
                  const SizedBox(height: 16),

                  // Deskripsi
                  const Text(
                    "Description",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    fields.description,
                    style: const TextStyle(fontSize: 16, height: 1.5),
                  ),
                ],
              ),
            ),

            // --- BAGIAN 3: SECOND IMAGE (OPTIONAL) ---
            if (fields.secondImage.isNotEmpty) ...[
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: const Text(
                  "More Views",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    fields.secondImage,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const SizedBox(),
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ],
        ),
      ),
    );
  }
}