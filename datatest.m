% Load data test dan train
data_test = csvread('data_test_PNN.csv');
data_train = csvread('data_train_PNN.csv');
% bedakan data train berdasarkan kelasnya
mengurutkan_data_train = sortrows(data_train,4);
kelas_0 = mengurutkan_data_train(1:46,:);% data yang masuk pada kelas 0 merupakan data 1 sampai 46
kelas_1 = mengurutkan_data_train(47:94,:);% data yang masuk pada kelas 1 merupakan data 47 sampai 94 
kelas_2 = mengurutkan_data_train(95:150,:); % data yang masuk pada kelas 2 merupakan data 95 sampai 150

sigma=1;
for i = 1:size(data_test)
      % membangun fungsi untuk f(x) dikelas 0 menggunakan metode jaringan probabilistik
    for j = 1:size(kelas_0)
        kelas_0(i,1) = exp(-(((data_test(i,1)-kelas_0(j,1))^2 + (data_test(i,2)-kelas_0(j,2))^2 + (data_test(i,3)-kelas_0(j,3))^2) / 2*sigma^2));
        hasil_exp_0=kelas_0(i,1);
        f(i,1) = sum(hasil_exp_0)/size(data_test,1);
    end
      % membangun fungsi untuk f(x) dikelas 1 menggunakan metode jaringan probabilistik
    for l = 1:size(kelas_1)
        kelas_1(i,1) = exp(-(((data_test(i,1)-kelas_1(l,1))^2 + (data_test(i,2)-kelas_1(l,2))^2 + (data_test(i,3)-kelas_1(l,3))^2) / 2*sigma^2));
        hasil_exp_1 = kelas_1(i,1);
        f(i,2) = sum(hasil_exp_1)/size(data_test,1);
    end
      % membangun fungsi untuk f(x) dikelas 2 menggunakan metode jaringan probabilistik
    for n = 1:size(kelas_2)
        kelas_2(i,1) = exp(-(((data_test(i,1)-kelas_2(n,1))^2 + (data_test(i,2)-kelas_2(n,2))^2 + (data_test(i,3)-kelas_2(n,3))^2) / 2*sigma^2));
        hasil_exp_2=kelas_2(i,1);
        f(i,3) = sum(hasil_exp_2)/size(data_test,1);
    end
    %==== nilai maksimum ====
    
   for k = 1:size(f,1)
        if f(k,1) == max(k,1)
            f(k,4)=0;
        else if f(k,2) == max(k,1)
            f(k,4) = 1;
        else if f(k,3) == max(k,1)
            f(k,4) = 2;
        end
    end
end