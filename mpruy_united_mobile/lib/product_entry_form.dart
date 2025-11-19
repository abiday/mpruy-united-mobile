import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:mpruy_united_mobile/screens/list_product.dart';
import 'package:mpruy_united_mobile/widgets/left_drawer.dart';
import 'package:mpruy_united_mobile/menu.dart';
import 'package:flutter/foundation.dart' show kIsWeb; // BARU: Import untuk deteksi platform

class ProductEntryFormPage extends StatefulWidget {
  const ProductEntryFormPage({super.key});

  @override
  State<ProductEntryFormPage> createState() => _ProductEntryFormPageState();
}

class _ProductEntryFormPageState extends State<ProductEntryFormPage> {
  final _formKey = GlobalKey<FormState>();

  // --- Variabel Input Sesuai Model Django ---
  String _name = "";
  int _price = 0;
  String _description = "";
  String? _category; 
  String _thumbnail = ""; 
  String _secondImage = ""; 
  bool _isFeatured = false; 

  // --- KUNCI FIX: URL Dinamis ---
  // Gunakan localhost untuk Web, 10.0.2.2 untuk Android Emulator
  String get _backendUrl => kIsWeb ? 'http://localhost:8000' : 'http://10.0.2.2:8000';

  // Opsi Kategori sesuai HTML Django
  final List<String> _categoryOptions = [
    'Jersey',
    'Football Boots',
    'Football Ball',
    'Accessories',
    'Training Equipment',
  ];

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Create New Product',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF004D98), // barcaBlue
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: const LeftDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 600), 
            padding: const EdgeInsets.all(24.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: Colors.grey.shade300),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- Header Section ---
                  const Text(
                    "Create New Product",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "Add your football equipment and accessories to the shop",
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 24),
                  const Divider(),
                  const SizedBox(height: 24),

                  // --- Input Name ---
                  _buildLabel("Product Name"),
                  TextFormField(
                    decoration: _inputDecoration("Enter product name"),
                    onChanged: (String? value) {
                      setState(() { _name = value!; });
                    },
                    validator: (String? value) {
                      if (value == null || value.isEmpty) return "Product name cannot be empty!";
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // --- Input Price ---
                  _buildLabel("Price"),
                  TextFormField(
                    decoration: _inputDecoration("Enter price"),
                    keyboardType: TextInputType.number,
                    onChanged: (String? value) {
                      setState(() { _price = int.tryParse(value!) ?? 0; });
                    },
                    validator: (String? value) {
                      if (value == null || value.isEmpty) return "Price cannot be empty!";
                      if (int.tryParse(value) == null) return "Price must be a number!";
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // --- Input Description ---
                  _buildLabel("Description"),
                  TextFormField(
                    decoration: _inputDecoration("Enter product description"),
                    maxLines: 4,
                    onChanged: (String? value) {
                      setState(() { _description = value!; });
                    },
                    validator: (String? value) {
                      if (value == null || value.isEmpty) return "Description cannot be empty!";
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // --- Input Category (Dropdown) ---
                  _buildLabel("Category"),
                  DropdownButtonFormField<String>(
                    decoration: _inputDecoration("Select category"),
                    value: _category,
                    items: _categoryOptions.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() { _category = newValue; });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) return "Please select a category!";
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // --- Input Main Image URL ---
                  _buildLabel("Main Image URL"),
                  TextFormField(
                    decoration: _inputDecoration("https://example.com/image.jpg"),
                    onChanged: (String? value) {
                      setState(() { _thumbnail = value!; });
                    },
                    validator: (String? value) {
                      if (value == null || value.isEmpty) return "Main image URL cannot be empty!";
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // --- Input Second Image URL (Optional) ---
                  _buildLabel("Second Image URL (Optional)"),
                  TextFormField(
                    decoration: _inputDecoration("https://example.com/second-image.jpg"),
                    onChanged: (String? value) {
                      setState(() { _secondImage = value!; });
                    },
                  ),
                  const SizedBox(height: 16),

                  // --- Checkbox Featured ---
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: CheckboxListTile(
                      title: const Text("Featured Product", style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: const Text(
                        "(This product will be highlighted in the shop)",
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      value: _isFeatured,
                      activeColor: const Color(0xFFA50044), // barcaRed
                      onChanged: (bool? value) {
                        setState(() {
                          _isFeatured = value!;
                        });
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // --- Buttons (Cancel & Save) ---
                  Row(
                    children: [
                      // Cancel Button
                      Expanded(
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            side: BorderSide(color: Colors.grey.shade300),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                          ),
                          onPressed: () {
                            Navigator.pop(context); // Kembali ke halaman sebelumnya
                          },
                          child: const Text("Cancel", style: TextStyle(color: Colors.black87)),
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Save Button
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFA50044), // barcaRed
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                          ),
                          onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                  
                                  try {
                                      // Ganti URL keras menjadi URL dinamis
                                      final String endpoint = '$_backendUrl/create-flutter/';
                                      
                                      final response = await request.postJson(
                                          endpoint, 
                                          jsonEncode(<String, dynamic>{
                                              'name': _name,
                                              'price': _price,
                                              'description': _description,
                                              'category': _category ?? "Uncategorized",
                                              'thumbnail': _thumbnail,
                                              'second_image': _secondImage,
                                              'is_featured': _isFeatured,
                                          }),
                                      );
                                      
                                      if (context.mounted) {
                                          if (response['status'] == 'success' || response['status'] == true) {
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                  const SnackBar(content: Text("Product saved successfully!"), backgroundColor: Colors.green),
                                              );
                                              Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(builder: (context) => const ProductEntryPage()),
                                              );
                                          } else {
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                  SnackBar(content: Text("Gagal menyimpan produk: ${response['message'] ?? 'Kesalahan tak terduga'}"), backgroundColor: Colors.red),
                                              );
                                          }
                                      }
                                  
                                  } catch (e) {
                                      // Penanganan error jaringan/403/500
                                      print("Error saat POST ke create-flutter: $e");

                                      if (context.mounted) {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(
                                                  content: Text("NETWORK GAGAL! Pastikan Django berjalan dan sudah login. Error: ${e.toString()}"),
                                                  backgroundColor: Colors.red,
                                              ),
                                          );
                                      }
                                  }
                              }
                          },  
                          child: const Text("Add Product", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // --- Helper Widget untuk Label ---
  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: Colors.black87),
      ),
    );
  }

  // --- Helper Decoration untuk Input Field ---
  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6.0),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6.0),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6.0),
        borderSide: const BorderSide(color: Color(0xFFA50044), width: 1.5), // barcaRed focus
      ),
    );
  }
}