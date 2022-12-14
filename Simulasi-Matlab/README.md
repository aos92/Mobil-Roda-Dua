Sebelum melanjutkan dengan simulasi, kita memerlukan beberapa parameter eksplisit. Yang pertama adalah titik awal, arah awal, titik target dan arah target mobil. 
Persyaratan telah ditentukan bahwa posisi awal adalah [β2 β2 βπ/4]
π, posisi target adalah [0 0 π/4]
π. Kedua, batas kecepatan roda kiri dan kanan adalah β0,5 m/s β€
ππ, ππ β€ 0,5 m/s. Karena jarak roda πΏ tidak diberikan pada judul, jarak roda πΏ diatur menjadi 0.2m selama simulasi.

Selain parameter spasial, parameter pengontrol juga sangat penting. Pertama atur langkah waktu ke 0,1π , lalu kontrol kontrol PID untuk kecepatan linier dan kecepatan sudut
perangkat untuk menyesuaikan. Pertama, tentukan parameter πΎπ dari kedua kontroler tersebut, πΎπ yang digunakan untuk mengatur kecepatan jalur tidak boleh terlalu besar atau terlalu kecil.
Jika jalurnya terlalu panjang; jika terlalu kecil, kecepatan gerakan akan diperlambat dan waktu untuk mencapai titik target akan lebih lama. πΎπ yang digunakan untuk mengatur kecepatan sudut tidak boleh terlalu kecil, dapat diatur relatif lebih besar,
Ini akan membuat kecepatan kemudi lebih cepat. Selanjutnya, tentukan parameter πΎπ. Karena formula I yang diperoleh dengan mendiskritisasi pengontrol secara langsung adalah formula PID terdiskritisasi tipe-posisi, maka akan demikian
Ada fenomena kejenuhan integral, sehingga istilah kesalahan kumulatif akan sangat besar, jika algoritma inkremental PID digunakan, tidak akan ada masalah seperti itu. Mengingat situasi ini, saya telah memutuskan untuk
Istilah kesalahan kumulatif langsung dihapus untuk memastikan kinerja pengontrol di seluruh wilayah, bukan hanya memenuhi persyaratan pekerjaan besar. Akhirnya, parameter πΎπ dilakukan
Penyesuaian, parameter πΎπ tidak boleh terlalu besar, jika terlalu besar akan meningkatkan redaman sistem dan memperlambat kecepatan konvergensi tahap akhir. setelah beberapa saat
Penyesuaian, parameter PID akhir yang digunakan untuk mengontrol kecepatan linier adalah πΎπ = 0,3, πΎπ = 0, πΎπ = 0,2, dan parameter PID untuk mengontrol kecepatan sudut adalah πΎπ = 2, πΎπ = 0, πΎπ =
0,1.

Setelah mengklarifikasi data yang relevan, hasil akhir dapat diperoleh melalui simulasi. Karena keterbatasan pemrosesan komputer, kami tidak dapat secara akurat berhenti di titik target, kami hanya bisa
Menentukan presisi. Dalam simulasi ditetapkan bahwa jarak antara kendaraan dengan titik target pada task 1 tidak melebihi 0,01π, dan deviasi antara arah kendaraan dengan target pada task 2 tidak melebihi
0,001rad, akurasinya relatif tinggi, tetapi waktunya akan relatif lebih lama.

https://github.com/aos92/Mobil-Roda-Dua/blob/main/Simulasi-Matlab/Figure_6.png
Gbr.6 (Lintasan) Jalur mobil yang bergerak ditunjukkan pada Gbr.6. Titik biru adalah titik awal, titik merah adalah titik target, dan lintasan terdiri dari titik-titik diskrit dan garis penghubung antar titik.

https://github.com/aos92/Mobil-Roda-Dua/blob/main/Simulasi-Matlab/Figure_7a.png
https://github.com/aos92/Mobil-Roda-Dua/blob/main/Simulasi-Matlab/Figure_7b.png
Gbr.7a (Gambaran v dan Ο terhadap t pada bagian pertama) dan Gbr.7b (Gambar v dan Ο terhadap t pada bagian kedua) masing-masing menunjukkan kecepatan perjalanan dan kecepatan sudut dari dua bagian mobil melalui titik-titik diskrit, di mana dapat dilihat dengan jelas bahwa deviasi cenderung
Dalam proses zeroing, batas kecepatan yang dibutuhkan dalam dokumen pekerjaan besar juga tercermin secara tidak langsung.

https://github.com/aos92/Mobil-Roda-Dua/blob/main/Simulasi-Matlab/Figure_8a.png
Gbr.8a (Grafik ΞΈ terhadap t)  menunjukkan orientasi mobil, terlihat setelah kontrol dibagi menjadi dua bagian, dan setelah bagian kedua dikontrol, jarak terakhir antara mobil dan sumbu X
Sudut yang disertakan adalah 0,78611rad, yaitu π/4.

https://github.com/aos92/Mobil-Roda-Dua/blob/main/Simulasi-Matlab/Figure_8b.png
Gbr.8b (Gambaran Vl, Vr terhadap t) menunjukkan kecepatan linier roda kiri dan kanan mobil. Terlihat dari gambar bahwa terdapat tanda-tanda batas kecepatan yang jelas, dan kontrol bagian pertama dan bagian kedua
Selama proses berlangsung, kecepatan linier roda kiri dan kanan dibatasi secara efektif dalam jangkauan.
