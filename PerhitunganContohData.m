function [daftarGambar,H,W,M,m,U,omega,R]=PerhitunganContohData(pathContohData, format)
    %Ambil semua gambar contoh wajah yang tersedia
    ContohData=dir(sprintf(['%s/*.',format],pathContohData));
    
    str=strcat(pathContohData,'\',ContohData(1).name);    
    im=imread(str);
    im=im2gray(im);

    %Tentukan tinggi (H) dan lebar (W) dari masing-masing gambar
    %Kemudian hitung jumlah gambar yang tersedia (M)
    H=size(im,1); %Tinggi gambar
    W=size(im,2); %Lebar gambar
    M=size(ContohData,1); %Jumlah gambar

    daftarGambar=zeros(H,W,M);
    vec=zeros(H*W,M);

    %Baca masing-masing gambar yang tersedia,
    %kemudian lakukan konversi gambar tersebut menjadi vektor gambar (vec)
    for i=1:M
        str=strcat(pathContohData,'\',ContohData(i).name);
        daftarGambar(:,:,i)=im2gray(imread(str));
        vec(:,i)=reshape(daftarGambar(:,:,i),H*W,1);
    end
        
    %Hitung rata-rata (m) dari masing-masing gambar dengan rumus:
    %m = (1/M) * E(vec)
    m=sum(vec,2)/M;

    %Hitung selisih antara gambar dengan rata-rata gambar dengan rumus:
    %A(i) = vec(i) - M
    A=vec-repmat(m,1,M);

    %SVD;
    [U, lambda, V]= svd(A);

    %Setelah menemukan nilai eigenface,
    %Hitung nilai bobot (W) untuk masing-masing gambar dengan rumus:
    %W(i) = U(i)T * A
    %Kemudian masukkan semua nilai bobot pada masing-masing gambar sebagai nilai omega
    omega=U'*A;
    
    %Hitung seberapa beda vektor wajah dan rata-rata
    R = [];
    for i=1:M
        panjang = norm(A(:,i));
        R = [R panjang];
    end
end

