// To parse this JSON data, do
//
//     final productEntry = productEntryFromJson(jsonString);

import 'dart:convert';

List<ProductEntry> productEntryFromJson(String str) => List<ProductEntry>.from(json.decode(str).map((x) => ProductEntry.fromJson(x)));

String productEntryToJson(List<ProductEntry> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductEntry {
    String model;
    String pk;
    Fields fields;

    ProductEntry({
        required this.model,
        required this.pk,
        required this.fields,
    });

    factory ProductEntry.fromJson(Map<String, dynamic> json) => ProductEntry(
        model: json["model"],
        pk: json["pk"].toString(),
        fields: Fields.fromJson(json["fields"]),
    );

    Map<String, dynamic> toJson() => {
        "model": model,
        "pk": pk,
        "fields": fields.toJson(),
    };
}

class Fields {
    int user;
    String name;
    int price;
    String description;
    String category;
    String thumbnail;      // Field Baru
    String secondImage;    // Field Baru
    bool isFeatured;       // Field Baru
    double rating;

    Fields({
        required this.user,
        required this.name,
        required this.price,
        required this.description,
        required this.category,
        required this.thumbnail,
        required this.secondImage,
        required this.isFeatured,
        required this.rating,
    });

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        user: safeInt(json["user"]),
        name: json["name"] ?? "Tanpa Nama",
        price: safeInt(json["price"]),
        description: json["description"] ?? "-",
        category: json["category"] ?? "Uncategorized",
        // FIX UTAMA: Handle null dengan nilai default
        thumbnail: json["thumbnail"] ?? "", 
        secondImage: json["second_image"] ?? "", 
        isFeatured: json["is_featured"] ?? false,
        rating: safeDouble(json["rating"]),
    );

    Map<String, dynamic> toJson() => {
        "user": user,
        "name": name,
        "price": price,
        "description": description,
        "category": category,
        "thumbnail": thumbnail,
        "second_image": secondImage,
        "is_featured": isFeatured,
        "rating": rating,
    };
}

// Fungsi bantuan agar parsing angka aman dari error
int safeInt(dynamic value) {
  if (value == null) return 0;
  if (value is int) return value;
  if (value is String) return int.tryParse(value) ?? 0;
  return 0;
}

double safeDouble(dynamic value) {
  if (value == null) return 0.0;
  if (value is double) return value;
  if (value is int) return value.toDouble();
  if (value is String) return double.tryParse(value) ?? 0.0;
  return 0.0;
}