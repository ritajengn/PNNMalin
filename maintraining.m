% load data train yang diberikan 
data_train = csvread('data_train_PNN.csv');

% mengurutkan data berdasarkan kelasnya 
mengurutkan_data_train = sortrows(data_train,4);
kelas_0 = mengurutkan_data_train(1:46,:);% data yang masuk pada kelas 0 merupakan data 1 sampai 46
kelas_1 = mengurutkan_data_train(47:94,:); % data yang masuk pada kelas 1 merupakan data 47 sampai 94 
kelas_2 = mengurutkan_data_train(95:150,:); % data yang masuk pada kelas 2 merupakan data 95 sampai 150

train = data_train(1:96,:);
data_valid = data_train(97:150,:);

total_atribut = size(train,2)-1;
data_kelas = train(:,total_atribut+1);
data_train_0_pnn = data_train(find(data_kelas==0),:);
data_train_1_pnn = data_train(find(data_kelas==1),:);
data_train_2_pnn = data_train(find(data_kelas==2),:);

sigma = 1;


for x = 1:size(data_valid)
    % membangun fungsi untuk f(x) dikelas 0 menggunakan metode jaringan probabilistik
    for y = 1:size(data_train_0_pnn)
        kelas_0(x,1) = exp(-(((data_valid(x,1)-data_train_0_pnn(y,1))^2 + (data_valid(x,2)-data_train_0_pnn(y,2))^2 + (data_valid(x,3)-data_train_0_pnn(y,3))^2) / 2*sigma^2));
        hasil_exp0 =kelas_0(x,1) ;
        f(x,1) = sum( hasil_exp0)/size(data_train_0_pnn,1);
    end
    % membangun fungsi untuk f(x) dikelas 1 menggunakan metode jaringan probabilistik
    for l = 1:size(data_train_1_pnn)
        kelas_1(x,1) = exp(-(((data_valid(x,1)-data_train_1_pnn(l,1))^2 + (data_valid(x,2)-data_train_1_pnn(l,2))^2 + (data_valid(x,3)-data_train_1_pnn(l,3))^2) / 2*sigma^2));
        hasil_exp1=kelas_1(x,1) ;
        f(x,2) = sum(hasil_exp1)/size(data_train_1_pnn,1);
    end
    % membangun fungsi untuk f(x) dikelas 2 menggunakan metode jaringan probabilistik
    for n = 1:size(data_train_2_pnn)
        kelas_2(x,1) = exp(-(((data_valid(x,1)-data_train_2_pnn(n,1))^2 + (data_valid(x,2)-data_train_2_pnn(n,2))^2 + (data_valid(x,3)-data_train_2_pnn(n,3))^2) / 2*sigma^2));
        hasil_exp2=kelas_2(x,1);
        f(x,3) = sum(hasil_exp2)/size(data_train_2_pnn,1);
    end
    
    %==== nilai maksimum ====
    f(x,4) = data_valid(x,4);
    
    for k = 1:size(f)
        %max_f(k,1) = max(f(k,1:3));
        if (find(max(f(k,1:3)) == f(k,1:3)) == 1)
            pengkelompokan(k,1) = 0;
        elseif (find(max(f(k,1:3)) == f(k,1:3)) == 2)
            pengkelompokan(k,1) = 1;
        elseif (find(max(f(k,1:3)) == f(k,1:3)) == 3)
            pengkelompokan(k,1) = 2;
        end
    end
end

%======= Visualisasi seluruh data =======%
hold on;
scatter3(kelas_0(:,1),kelas_0(:,2),kelas_0(:,3),'k','filled');
hold off;
hold on;
scatter3(kelas_1(:,1),kelas_1(:,2),kelas_1(:,3),'d','filled');
hold off;
hold on;
scatter3(kelas_2(:,1),kelas_2(:,2),kelas_2(:,3),'x','filled');
hold off;
% ========= Menghitung akurasi ==========%
total_benar = 0;
for m = 1:size(pengkelompokan)
    if (pengkelompokan(m,1) == f(m,4))
        total_benar = total_benar + 1;
    end
end
akurasi = (total_benar/50)*100;
fprintf('maka akurasi yang didapat adalah ')
disp(akurasi);

