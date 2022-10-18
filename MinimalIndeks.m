function idx=MinimalIndeks(x)
    %Jika indeks tidak ditemukan, maka kembalikan fungsi ini dengan nilai kosong

    if size(x,2)>1
        fprintf('Pada fungsi minimalIndeks, Input fungsi harus dalam bentuk vektor\n')
    else
        min_x=min(x);

        for i=1:size(x,1)
            if x(i,1) == min_x
                idx=i;
                break;
            end
        end
    end
end

        
