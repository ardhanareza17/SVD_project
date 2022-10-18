%Lakukan proses pembelajaran pada masing-masing contoh gambar wajah yang tersedia
%Penjelasan lebih detail tentang fungsi ini dapat dilihat pada penjelasan skrip dibawah ini (poin 1a - 1i)
[daftarGambar,H,W,M,m,U,omega,R]=PerhitunganContohData('data kaggle\DBase', 'png');

%Lakukan proses perhitungan pada data baru menggunakan nilai eigenface yang sudah ditemukan sebelumnya
%Penjelasan lebih detail tentang fungsi ini dapat dilihat pada penjelasan skrip dibawah ini (poin 2a - 2e)
Jarak = PerhitunganDataBaru('data kaggle\DBase','data kaggle\Testing 2', 'png',daftarGambar,H,W,M,m,U,omega,R)