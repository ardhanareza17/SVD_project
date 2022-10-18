function [Jarak]= PerhitunganDataBaru(pathContohData,pathDataBaru, format,daftarGambar,H,W,M,m,U,omega,R)
    form=figure;
    form.Position=[50 50 1500 1500];
    
    
    %Cari gambar contoh wajah yang tersedia untuk ditampilkan
    ContohData=dir(sprintf(['%s/*.', format],pathContohData));    
    
    %Cari gambar data wajah baru yang tersedia
    DataBaru=dir(sprintf(['%s/*.', format],pathDataBaru));
    
    %Hitung jumlah gambar data baru yang tersedia
    jumlahDataBaru=size(DataBaru,1);
    
    %Buat array untuk mengukur norm selisih data testing dan database
    Jarak =zeros(jumlahDataBaru,3);
    
    %Lakukan perhitungan pada masing-masing data baru (poin 2e1 - 2e6)
    for i=1:jumlahDataBaru
        str=strcat(pathDataBaru,'\',DataBaru(i).name);    
        tmp=im2gray(imread(str));
        
        gambar=reshape(tmp,H*W,1);
        testGambar=double(gambar);

        %Hitung selisih antara gambar dengan rata-rata gambar (A)
        selisihGambar=testGambar-m;

        %Hitung nilai bobot (om) pada gambar yang baru dengan rumus:
        %om = UT * A
        om=U'*selisihGambar;

        %Tentukan gambar contoh yang paling baik dalam mendeskripsikan data baru
        %dengan cara mencari minimal dari jarak Euclidean
        
        %Hitung nilai E(k) dengan rumus:
        %E(k) = om(k) - omega
        d=repmat(om,1,M)-omega;

        dist=zeros(M,1);

        %Hitung jarak euclidean dari nilai E(k) yang sudah ditentukan sebelumnya
        for j=1:M
            dist(j,1)=norm(d(:,j));
        end

        %Tentukan jawaban gambar, yaitu gambar yang memiliki jarak Euclidean terendah dari semua gambar
        idx1=MinimalIndeks(dist);
        Jarak(i,1) = norm(dist(idx1));
        selisih = dist(idx1);
        dist(idx1) = [];
        idx2=MinimalIndeks(dist);
        Jarak(i,2) = norm(dist(idx2));
        dist(idx2) = [];
        idx3=MinimalIndeks(dist);
        Jarak(i,3) = norm(dist(idx3));
        
        
        

        %Tampilkan pada layar
        subplot(jumlahDataBaru,2,((i-1)*2)+1)
        imshow(uint8(tmp))
        title(strcat('Data Testing'),'Position',[25,0])
        
        subplot(jumlahDataBaru,2,((i-1)*2)+2)
        imshow(uint8(daftarGambar(:,:,idx1)))
        title(strcat('Dikenali sebagai (Norm selisih = ',num2str(selisih),')'),'Position',[25,0])
        
    end
end