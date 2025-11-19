# Proyek Flutter: Football Shop (Penjelasan Konsep)

Repository ini berisi proyek aplikasi Flutter sederhana untuk menampilkan menu-menu pada "Football Shop". Proyek ini dibuat sambil mempelajari konsep-konsep dasar Flutter.

---

## 1. Apa itu Widget Tree dan Hubungan Parent-Child?

**Widget Tree** (Pohon Widget) adalah representasi struktur dari seluruh *User Interface* (UI) Anda di Flutter. Bayangkan UI Anda seperti pohon silsilah keluarga. Widget terluar (seperti `MaterialApp`) adalah akarnya, dan setiap widget yang Anda tambahkan di dalamnya (seperti `Scaffold`, `Column`, `Text`) adalah cabang dan daunnya.



**Hubungan Parent-Child (Induk-Anak)** adalah inti dari cara Flutter menyusun *layout*.

* **Parent (Induk):** Widget yang "membungkus" widget lain. Contoh: `Padding` adalah *parent* dari `Column` di proyek saya.
* **Child (Anak):** Widget yang "dibungkus" oleh widget lain. Contoh: `Column` adalah *child* dari `Padding`.

**Cara Kerja:** Hubungan ini menentukan *layout* dan *konteks*.
1.  **Layout:** *Parent* (induk) memberitahu *child* (anak) bagaimana ia boleh ditampilkan. Misalnya, `Center` (sebagai *parent*) memaksa anaknya (`Row`) untuk berada di tengah.
2.  **Konteks:** *Parent* bisa "mewariskan" data ke *child*, seperti tema (akan dibahas di bawah).

---

## 2. Widget yang Digunakan dalam Proyek Ini

Berikut adalah semua widget yang saya gunakan dalam versi final proyek "Football Shop":

* **Widget Inti & Struktur:**
    * `MaterialApp`: (Dijelaskan di bawah).
    * `Scaffold`: Kerangka dasar halaman. Ini yang menyediakan "slot" untuk `AppBar` (atas) dan `body` (tengah).
    * `AppBar`: Bilah judul di bagian atas aplikasi.
    * `Padding`: Memberikan jarak (bantalan) di sekeliling *child*-nya (dalam kasus saya, membungkus `Column` utama).
    * `Column`: Menyusun daftar *children* (jamak) secara vertikal (dari atas ke bawah).

* **Widget Tampilan & Layout:**
    * `Material`: "Kanvas" dasar yang memberi saya properti seperti `color` (warna latar) dan `borderRadius` (lengkungan sudut) untuk kartu tombol saya.
    * `Container`: Kotak serbaguna. Di proyek ini, saya menggunakannya untuk memberi `padding` di dalam `InkWell`.
    * `Center`: Memaksa *child*-nya untuk berada di tengah-tengah.
    * `Row`: Menyusun daftar *children* secara horizontal (dari kiri ke kanan). saya gunakan ini untuk menyejajarkan `Icon` dan `Text` di dalam tombol.
    * `Icon`: Menampilkan sebuah ikon (seperti `Icons.apps`, `Icons.inventory`, dll).
    * `SizedBox`: Kotak kosong tak terlihat. saya gunakan hanya untuk memberi jarak (spasi) antara `Icon` dan `Text`.
    * `Text`: Menampilkan string (teks).

* **Widget Interaksi & Lain-lain:**
    * `InkWell`: Membuat *child*-nya (yang biasanya tidak bisa diklik, seperti `Container`) menjadi bisa diklik, memiliki *handler* `onTap`, dan memberikan efek "riak air" (splash) saat disentuh.
    * `ScaffoldMessenger`: (Secara teknis, ini adalah *service*). Digunakan untuk mengelola dan menampilkan `SnackBar`.
    * `SnackBar`: Pop-up notifikasi sementara yang muncul di bagian bawah layar untuk memberi tahu pengguna ("Kamu telah menekan tombol...").

* **Widget Kustom (Buatan Sendiri):**
    * `MyHomePage`: `StatelessWidget` kustom saya yang bertindak sebagai seluruh halaman utama.
    * `ItemCard`: `StatelessWidget` kustom saya yang bertindak sebagai "LEGO" atau "cetakan" untuk satu tombol/kartu. Ini membuat kode saya rapi dan tidak berulang.

---

## 3. Fungsi Widget MaterialApp

`MaterialApp` adalah widget "pembungkus" level tertinggi (root) untuk aplikasi Anda yang menggunakan desain Material.

**Fungsi utamanya adalah:**
1.  **Tema (Theming):** Menyediakan tema desain Material secara global (warna default, font, gaya tombol) ke semua widget di bawahnya (semua *children* dan *descendants*).
2.  **Navigasi (Routing):** Mengelola tumpukan halaman (disebut "routes") sehingga Anda bisa berpindah dari satu halaman ke halaman lain (misalnya menggunakan `Navigator.push`).
3.  **Pengaturan Dasar:** Mengatur hal-hal dasar aplikasi seperti bahasa (lokalisasi) dan *debug banner*.

**Mengapa sering digunakan sebagai widget root?**
`MaterialApp` harus menjadi *root* (akar) atau widget terluar karena ia perlu "membungkus" *seluruh* aplikasi agar bisa memberikan **konteks** (seperti tema dan kemampuan navigasi) ke *setiap* halaman dan widget di dalam aplikasi Anda. Tanpa `MaterialApp`, widget seperti `Scaffold` tidak akan berfungsi dengan benar.

---

## 4. Perbedaan StatelessWidget dan StatefulWidget

Ini adalah perbedaan paling fundamental dalam mengelola data di Flutter.

**StatelessWidget (Widget "Statis")**
* **Tidak punya "memori" internal.**
* Artinya: Setelah widget ini dibuat (dibangun), propertinya (datanya) **tidak bisa diubah** dari dalam.
* Ia 100% bergantung pada data yang "dioper" oleh *parent*-nya. Jika *parent* mengubah datanya, `StatelessWidget` akan di-*rebuild* (dibangun ulang) dengan data baru itu.
* Contoh di proyek saya: `MyHomePage` dan `ItemCard`. Keduanya hanya **menampilkan** data yang mereka terima (`items`, `item.name`). Mereka tidak *mengubah* data itu.

**StatefulWidget (Widget "Dinamis")**
* **Punya "memori" internal** yang disebut **`State`**.
* Artinya: Widget ini bisa *mengubah* datanya sendiri dari dalam dan *membangun ulang* (rebuild) tampilannya saat datanya berubah.
* Perubahan ini dipicu dengan memanggil method `setState()`, yang memberi tahu Flutter untuk menggambar ulang widget itu dengan data yang baru.

**Kapan memilih?**
* **Pilih `StatelessWidget`** (pilihan *default*) jika halaman/widget Anda hanya perlu **menampilkan** informasi dan tidak akan berubah karena interaksi pengguna (seperti ikon, teks judul, atau kartu di proyek saya).
* **Pilih `StatefulWidget`** jika Anda perlu **mengubah** sesuatu di layar berdasarkan interaksi pengguna (seperti *checkbox* yang dicentang, *form* input teks yang diisi, *slider* yang digeser, atau data yang di-*fetch* dari internet).

---

## 5. Apa itu BuildContext dan Mengapa Penting?

**BuildContext** (atau `context`) adalah "alamat" atau "lokasi" unik dari sebuah widget di dalam Widget Tree.

**Mengapa penting?**
`context` memberi tahu widget di mana posisinya relatif terhadap widget lain. Fungsi utamanya adalah untuk **berkomunikasi dengan widget "leluhur" (di atasnya)** di dalam *tree*.

**Bagaimana penggunaannya di metode `build`?**
Method `build` **menerima** `context` sebagai parameter yang diberikan oleh Flutter. saya *tidak membuat* `context`, saya *menerimanya*.

saya kemudian menggunakan `context` itu untuk "mencari" layanan yang disediakan oleh leluhur.

**Contoh di proyek saya:**
```dart
ScaffoldMessenger.of(context).showSnackBar(...);
```

# Tugas 8: Flutter Navigation, Layouts, Forms, and Input Elements

## 1. Jelaskan perbedaan antara `Navigator.push()` dan `Navigator.pushReplacement()` pada Flutter.

Metode `Navigator.push()` bekerja dengan cara menambahkan rute (halaman) baru ke bagian paling atas tumpukan navigasi (*stack*), yang berarti halaman sebelumnya tetap ada di memori di bawah halaman baru tersebut. Metode ini memungkinkan pengguna untuk kembali ke halaman sebelumnya menggunakan tombol *back* bawaan perangkat atau AppBar. Dalam aplikasi Football Shop ini, `Navigator.push()` sebaiknya digunakan ketika pengguna ingin melihat detail produk atau berpindah ke sub-halaman sementara, di mana alur kembali ke halaman sebelumnya adalah perilaku yang diharapkan.

Sebaliknya, `Navigator.pushReplacement()` menghapus rute yang sedang aktif saat ini dari tumpukan navigasi dan menggantikannya langsung dengan rute yang baru. Hal ini menyebabkan pengguna tidak dapat kembali ke halaman sebelumnya karena halaman tersebut sudah dibuang dari *stack*. Dalam aplikasi ini, metode ini sangat krusial digunakan pada navigasi menu utama (seperti di dalam `LeftDrawer`). Saat pengguna berpindah dari "Halaman Utama" ke "Tambah Produk", kita menggunakan `pushReplacement` agar tumpukan halaman tidak menumpuk terus-menerus dan tombol *back* tidak mengembalikan pengguna ke menu yang sama secara berulang, menjaga efisiensi memori dan pengalaman pengguna yang logis.

## 2. Bagaimana kamu memanfaatkan hierarchy widget seperti Scaffold, AppBar, dan Drawer untuk membangun struktur halaman yang konsisten?

Saya memanfaatkan `Scaffold` sebagai fondasi atau kerangka utama bagi setiap halaman di aplikasi Football Shop. Widget ini menyediakan struktur visual dasar *Material Design* yang secara otomatis mengatur tata letak elemen-elemen penting. Di dalam `Scaffold` tersebut, saya menempatkan `AppBar` pada properti `appBar` untuk memastikan setiap halaman memiliki judul aplikasi dan area aksi yang seragam di bagian atas layar.

Untuk navigasi, saya menggunakan `Drawer` yang ditempatkan pada properti `drawer` milik `Scaffold`. Dengan memisahkan `Drawer` ke dalam widget tersendiri (`LeftDrawer`) dan memanggilnya di setiap halaman utama, saya menciptakan konsistensi navigasi di seluruh aplikasi. Pengguna dapat mengakses menu yang sama dengan cara yang sama (ikon menu atau *swipe*) di halaman mana pun mereka berada, menciptakan pengalaman pengguna yang terintegrasi dan intuitif tanpa perlu menduplikasi kode navigasi secara manual di setiap file.

## 3. Apa kelebihan menggunakan layout widget seperti Padding, SingleChildScrollView, dan ListView saat menampilkan elemen-elemen form?

Penggunaan widget tata letak sangat penting dalam desain antarmuka formulir untuk menjamin kegunaan dan estetika. `Padding` memberikan jarak visual yang diperlukan antara elemen input dan tepi layar, mencegah antarmuka terlihat padat dan meningkatkan keterbacaan serta kemudahan interaksi sentuh. `ListView` (atau `Column`) digunakan untuk menyusun elemen formulir secara vertikal yang rapi.

Yang paling krusial dalam konteks formulir adalah `SingleChildScrollView`. Widget ini membungkus seluruh area formulir untuk memungkinkan pengguliran (*scrolling*). Tanpa widget ini, saat pengguna mengetik dan *keyboard* virtual muncul di layar, ruang layar yang tersedia akan menyusut drastis yang menyebabkan *overflow error* (layar menjadi kuning-hitam). Dengan `SingleChildScrollView`, antarmuka menjadi responsif terhadap perubahan ukuran layar akibat *keyboard*, memastikan pengguna tetap dapat mengakses tombol "Save" atau *field* lain yang tertutup tanpa merusak tampilan aplikasi.

## 4. Bagaimana kamu menyesuaikan warna tema agar aplikasi Football Shop memiliki identitas visual yang konsisten dengan brand toko?

Untuk menjaga konsistensi identitas visual merek "Mpruy United", saya menerapkan tema secara global melalui properti `theme` pada widget `MaterialApp` di `main.dart`. Saya mendefinisikan `ColorScheme` dengan warna primer yang disesuaikan (biru khas tim) agar komponen standar Flutter secara otomatis mengikuti palet warna ini.

Selain itu, saya membuat konstanta warna statis (seperti `barcaBlue` dan `barcaRed`) dalam kelas terpisah atau di dalam kode menu. Konstanta ini digunakan secara eksplisit pada elemen-elemen kunci seperti latar belakang `AppBar`, tombol navigasi, dan ikon kategori. Pendekatan ini memastikan bahwa meskipun ada perubahan pada tema default sistem, elemen-elemen branding yang krusial tetap mempertahankan warna spesifik yang menjadi ciri khas toko, memberikan tampilan yang profesional dan seragam di seluruh bagian aplikasi.

# Tugas 9: Integrasi Layanan Web Django dengan Aplikasi Flutter

## 1. Jelaskan mengapa kita perlu membuat model Dart saat mengambil/mengirim data JSON? Apa konsekuensinya jika langsung memetakan Map<String, dynamic> tanpa model (terkait validasi tipe, null-safety, maintainability)?

Pembuatan model Dart, seperti class ProductEntry yang saya buat, sangat krusial karena berfungsi sebagai cetakan atau kontrak struktur data yang menjembatani respons JSON dari Django dengan objek di Flutter. Dengan menggunakan model, kita dapat memanfaatkan fitur type safety dari Dart secara maksimal, di mana setiap field seperti name, price, atau isFeatured didefinisikan tipe datanya secara eksplisit. Jika kita hanya mengandalkan Map<String, dynamic>, kita bekerja tanpa jaminan tipe data yang jelas, yang berisiko tinggi menyebabkan runtime error (misalnya, mencoba mengakses field yang ternyata null atau salah ketik nama key). Selain itu, penggunaan model meningkatkan maintainability kode; seperti yang saya terapkan dengan fungsi bantuan safeInt dan safeDouble di dalam model, saya dapat menangani data yang berpotensi null atau format angka yang tidak konsisten dari server secara terpusat, sehingga mencegah aplikasi crash dan memudahkan tim pengembang lain memahami struktur data tanpa harus menebak-nebak isi JSON mentah.

## 2. Apa fungsi package http dan CookieRequest dalam tugas ini? Jelaskan perbedaan peran http vs CookieRequest.

Dalam tugas ini, package http berfungsi sebagai pustaka dasar yang menyediakan metode standar untuk melakukan permintaan jaringan (seperti GET dan POST) ke server Django. Namun, untuk kebutuhan aplikasi yang membutuhkan autentikasi, saya menggunakan CookieRequest dari package pbp_django_auth. Perbedaan mendasarnya terletak pada manajemen sesi; package http bawaan bersifat stateless, yang berarti setiap permintaan dianggap independen dan tidak menyimpan informasi sesi (cookies) dari server. Sebaliknya, CookieRequest dirancang khusus untuk menyimpan dan menyertakan session cookies (seperti sessionid dan csrftoken) secara otomatis pada setiap permintaan berikutnya setelah pengguna berhasil login. Hal ini sangat vital bagi aplikasi Mpruy United Shop saya agar server Django dapat mengenali pengguna yang sedang mengakses fitur "My Products" atau "Create Product" sebagai pengguna yang terautentikasi, tanpa perlu mengirim ulang kredensial setiap saat.

## 3. Jelaskan mengapa instance CookieRequest perlu untuk dibagikan ke semua komponen di aplikasi Flutter.

Instance CookieRequest harus dibagikan ke seluruh komponen aplikasi menggunakan state management Provider di main.dart untuk menjaga konsistensi sesi pengguna di seluruh layar aplikasi. CookieRequest bertindak sebagai penyimpan "kartu identitas" digital pengguna yang didapatkan saat login. Jika setiap halaman atau widget membuat instance CookieRequest baru secara terpisah, maka informasi sesi (cookies) yang tersimpan akan hilang, dan server Django akan menganggap permintaan dari halaman tersebut berasal dari pengguna anonim (belum login). Dengan membagikan satu instance tunggal (singleton) melalui Provider, saya memastikan bahwa session ID yang sama digunakan baik saat mengakses halaman daftar produk, detail produk, maupun formulir tambah produk, sehingga status autentikasi pengguna tetap terjaga selama aplikasi berjalan.

## 4. Jelaskan konfigurasi konektivitas yang diperlukan agar Flutter dapat berkomunikasi dengan Django. Mengapa kita perlu menambahkan 10.0.2.2 pada ALLOWED_HOSTS, mengaktifkan CORS dan pengaturan SameSite/cookie, dan menambahkan izin akses internet di Android? Apa yang akan terjadi jika konfigurasi tersebut tidak dilakukan dengan benar?

Konfigurasi konektivitas melibatkan penyesuaian di sisi Django dan Android agar komunikasi data dapat berjalan lancar. Saya menambahkan 10.0.2.2 pada ALLOWED_HOSTS di settings.py karena Android Emulator mengenali alamat localhost komputer host melalui IP khusus tersebut, bukan 127.0.0.1. Selanjutnya, saya menginstal dan mengonfigurasi django-cors-headers serta mengatur CORS_ALLOW_ALL_ORIGINS = True agar browser (untuk Flutter Web) atau klien lain tidak diblokir oleh kebijakan keamanan browser saat meminta sumber daya dari domain yang berbeda. Pengaturan SameSite dan keamanan cookie juga disesuaikan agar sesi tetap valid. Di sisi Android, izin INTERNET pada AndroidManifest.xml mutlak diperlukan karena secara default Android memblokir akses jaringan aplikasi. Jika konfigurasi ini tidak dilakukan dengan benar, aplikasi akan mengalami kegagalan koneksi (seperti Connection Refused atau XMLHTTPRequest error), data JSON tidak akan termuat, atau proses login akan gagal karena cookie sesi ditolak oleh browser atau emulator.

## 5. Jelaskan mekanisme pengiriman data mulai dari input hingga dapat ditampilkan pada Flutter.

Mekanisme pengiriman data dimulai ketika pengguna mengisi data produk (nama, harga, kategori, gambar) pada form di Flutter dan menekan tombol simpan. Aplikasi akan memvalidasi input, lalu mengemas data tersebut menjadi format JSON dan mengirimkannya menggunakan request.postJson ke endpoint Django (/create-flutter/). Di sisi backend, saya membuat fungsi view khusus create_product_flutter yang membaca body request, melakukan parsing JSON menjadi dictionary Python, membuat objek model baru, dan menyimpannya ke database. Setelah berhasil, Django mengembalikan respons sukses. Kemudian, di halaman daftar produk (list_product.dart), aplikasi menggunakan FutureBuilder untuk memanggil fungsi fetchProduct yang melakukan request GET ke endpoint JSON. Data JSON yang diterima kemudian dikonversi (parsing) menjadi daftar objek ProductEntry menggunakan model Dart yang telah dibuat, dan akhirnya ditampilkan ke layar dalam bentuk kartu-kartu produk yang memuat gambar dan informasi lainnya.

## 6. Jelaskan mekanisme autentikasi dari login, register, hingga logout. Mulai dari input data akun pada Flutter ke Django hingga selesainya proses autentikasi oleh Django dan tampilnya menu pada Flutter.

Proses autentikasi dimulai dengan fitur Registrasi, di mana data username dan password dikirim dari Flutter ke endpoint registrasi Django untuk membuat entri User baru di database. Untuk proses Login, pengguna memasukkan kredensial di halaman Login Flutter, yang kemudian dikirim ke view login di Django. Django memverifikasi kredensial tersebut menggunakan fungsi authenticate; jika valid, Django membuat sesi aktif dan mengembalikan respons JSON beserta session cookie. CookieRequest di Flutter menangkap dan menyimpan cookie ini. Berkat cookie yang tersimpan, pengguna kemudian diarahkan ke halaman menu utama dan dapat mengakses endpoint yang dilindungi decorator @login_required. Saat pengguna menekan tombol Logout, Flutter mengirim request ke endpoint logout Django yang akan menghapus sesi di sisi server. Setelah sukses, Flutter akan menghapus cookie lokal dan mengembalikan pengguna ke halaman Login, menutup akses ke fitur-fitur privat aplikasi.

## 7. Jelaskan bagaimana cara kamu mengimplementasikan checklist di atas secara step-by-step! (bukan hanya sekadar mengikuti tutorial).

Langkah implementasi saya dimulai dengan mempersiapkan backend Django terlebih dahulu. Saya menginstal django-cors-headers, mengonfigurasi settings.py untuk CORS dan ALLOWED_HOSTS, serta membuat aplikasi authentication dengan view untuk login, register, dan logout. Selanjutnya, di sisi Flutter, saya membuat halaman login.dart dan register.dart yang terhubung ke endpoint tersebut menggunakan CookieRequest dan Provider.

Setelah autentikasi bekerja, saya membuat model data product_entry.dart dengan memanfaatkan Quicktype dan menyesuaikannya secara manual untuk menangani null safety serta menambahkan field baru seperti thumbnail, second_image, dan is_featured. Langkah berikutnya adalah membuat halaman product_entry_form.dart. Di sini, saya menghadapi tantangan error 500 karena ketidakcocokan format data, sehingga saya membuat view baru create_product_flutter di Django yang secara spesifik menangani parsing json.loads dari request body. Saya juga menerapkan logika URL dinamis (kIsWeb) di Flutter untuk membedakan alamat localhost (Web) dan 10.0.2.2 (Emulator) guna mengatasi error koneksi.

Terakhir, saya mengimplementasikan fitur daftar produk. Saya memodifikasi list_product.dart dan backend Django agar mendukung fitur penyaringan (filtering). Saya memperbarui fungsi show_json di Django untuk menerima parameter ?filter=user. Di Flutter, saya membuat logika pada tombol "My Products" yang mengirim parameter tersebut, sehingga pengguna bisa melihat daftar produk milik mereka sendiri secara terpisah dari daftar "All Products". Halaman product_detail.dart juga saya perbarui untuk menampilkan gambar dan detail lengkap produk secara visual.

