% 1 - rozmycie, 2 - neurony, 3 - poprawnosc, 4 - mse, 5, popUcz, 6 - mseUcz
nazwa_pliku = 'C:\Users\Michał\Downloads\RBFNs\wyniki_niski_parametr.mat';
dane = load(nazwa_pliku);
dane = dane.Wyniki;
z = zeros(19, 5);
x_blad = 0.01;
y_blad = 1;
% i = 18, j = 10;
figure
[x,y] = meshgrid(0.01 : 0.02 : 0.1, 10 : 70 : 1300);
%[x,y] = meshgrid(0.1:0.2:2,10:70:1200);
for i = 1:19
    for j = 1:5
        indeks = find(abs(dane(:, 1) - x(i, j)) < x_blad & abs(dane(:, 2) - y(i, j)) < y_blad);
        disp(x(i, j));
        disp(y(i, j));
        disp(indeks);
        a = dane(indeks, 3);
        z(i, j) = a;
    end
end
surf(x, y, z)
xlabel("Wartość rozprzestrzenienia");
ylabel("Ilość neuronów w sieci");
zlabel("Poprawność sieci [%]");
title("Rezultaty w zależności od ilości neuronów i wartości rozprzestrzenienia");
%tu wykres dla mse - nauki i testowego

figure
[x,y] = meshgrid(0.01 : 0.02 : 0.1, 10 : 70 : 1300);
%[x,y] = meshgrid(0.1:0.2:2,10:70:1200);
for i = 1:19
    for j = 1:5
        indeks = find(abs(dane(:, 1) - x(i, j)) < x_blad & abs(dane(:, 2) - y(i, j)) < y_blad);
        disp(x(i, j));
        disp(y(i, j));
        disp(indeks);
        a = dane(indeks, 4);
        z(i, j) = a;
    end
end
surf(x, y, z)
xlabel("Wartość rozprzestrzenienia");
ylabel("Ilość neuronów w sieci");
zlabel("Wartość mse");
title("Wartości mse w zależności od ilości neuronów i wartości rozprzestrzenienia");

figure
%[x,y] = meshgrid(0.1:0.2:2,10:70:1200);
[x,y] = meshgrid(0.01 : 0.02 : 0.1, 10 : 70 : 1300);
for i = 1:19
    for j = 1:5
        indeks = find(abs(dane(:, 1) - x(i, j)) < x_blad & abs(dane(:, 2) - y(i, j)) < y_blad);
        disp(x(i, j));
        disp(y(i, j));
        disp(indeks);
        a = dane(indeks, 5);
        z(i, j) = a;
    end
end
surf(x, y, z)
xlabel("Wartość rozprzestrzenienia");
ylabel("Ilość neuronów w sieci");
zlabel("Poprawność sieci dla danych uczących [%]");
title("Wyniki dla danych uczących w zależności od ilości neuronów i wartości rozprzestrzenienia");

figure
[x,y] = meshgrid(0.01 : 0.02 : 0.1, 10 : 70 : 1300);
for i = 1:19
    for j = 1:5
        indeks = find(abs(dane(:, 1) - x(i, j)) < x_blad & abs(dane(:, 2) - y(i, j)) < y_blad);
        disp(x(i, j));
        disp(y(i, j));
        disp(indeks);
        a = dane(indeks, 6);
        z(i, j) = a;
    end
end
surf(x, y, z)
xlabel("Wartość rozprzestrzenienia");
ylabel("Ilość neuronów w sieci");
zlabel("Wartość mse dla danych uczących");
title("Wartości mse dla danych uczących w zależności od ilości neuronów i wartości rozprzestrzenienia");

disp(["Max procent: ", max(dane(:, 3))]);
disp(["Min procent: ", min(dane(:, 3))]);

disp(["Max mse: ", max(dane(:, 4))]);
disp(["Min mse: ", min(dane(:, 4))]);

disp(["Max procentUcz: ", max(dane(:, 5))]);
disp(["Min procentUcz: ", min(dane(:, 5))]);

disp(["Max mseUcz: ", max(dane(:, 6))]);
disp(["Min mseUcz: ", min(dane(:, 6))]);