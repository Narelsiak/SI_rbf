nazwa_pliku = 'C:/python_code/projekt_ai/daneShaWithoutNorm.mat';
nazwa_pliku2 = 'C:/python_code/projekt_ai/daneMarwithNorm.mat';
nazwa_pliku3 = 'C:/python_code/projekt_ai/daneTexwithNorm.mat';
dane = load(nazwa_pliku);
dane2 = load(nazwa_pliku2);
dane3 = load(nazwa_pliku3);

%%
%       grupowanie
% daneTest = horzcat(dane2.Xn, dane3.Xn);
% [idx, C] = kmeans(dane.Xn, 100);
% arr_grp =  zeros(100, 2);
% arr_grp2 = zeros(100, 1);
% temp_arr = zeros(100,1);
% pom = 1;
% for i = 1:1600
%         temp_arr(idx(i, 1),1)  = temp_arr(idx(i, 1),1) + 1;
%         arr_grp2(idx(i,1,1)) = arr_grp2(idx(i,1,1)) + 1;
%         if mod(i, 16) == 0
%             arr_grp(pom, 1) = max(temp_arr);
%             arr_grp(pom, 2) = pom;
%             pom = pom + 1;
%             temp_arr = zeros(100,1);    
%         end
% end
%  figure
% hold on
% plot(arr_grp(:, 1))
% title("Liczba poprawnie zgrupowanych danych w poszczególnych grupach");
% legend('Danych w grupie');
% xlabel("Indeks grupy");
% ylabel("Ilość poprawnie pogrupowanych")
%  figure
%  plot(arr_grp2);
% title("Liczba danych w poszczególnych grupach");
% legend('Danych w grupie');
% xlabel("Indeks grupy");
% ylabel("Ilość danych w jednej grupie")

%%
dane = horzcat(dane.Xn, dane.YY);
%dane = horzcat(dane2.Xn, dane3.Xn, dane.YY);
liczba_uczacych = 15;
liczba_testowych = 16 - liczba_uczacych;
liczba_ogolem = 100;
kolumn = 64 + 1;%64 * 3 + 1
dane_uczace = zeros(liczba_uczacych * liczba_ogolem, kolumn);
dane_testowe = zeros(liczba_testowych * liczba_ogolem, kolumn);
%%
       % normalnie, ostatnia to testowa
for i = 0:99
    for j = 1:16
        nowy_wiersz = dane(((i*(liczba_uczacych + liczba_testowych)) + j), :); % 'dane' to macierz z danymi, pobieranie i-tego wiersza
        if j <=liczba_uczacych
           dane_uczace(((i*liczba_uczacych) + j), :) = nowy_wiersz;
        else
           dane_testowe((i*liczba_testowych) + j - liczba_uczacych, :) = nowy_wiersz;
        end
    end
end

%%
% %       losowa zmienna testowa
% nxtInd = 1;
% for i = 0:99
%     indeks_testowy = randi([1,16]);
%     disp(indeks_testowy)
%     for j = 1:16
%         nowy_wiersz = dane(((i*(liczba_uczacych + liczba_testowych)) + j), :); % 'dane' to macierz z danymi, pobieranie i-tego wiersza
%         if j == indeks_testowy
%             dane_testowe(i + 1, :) = nowy_wiersz;
%         else
%             dane_uczace(nxtInd, :) = nowy_wiersz;
%             nxtInd = nxtInd + 1;
%         end
%     end
% end

%%
X_uczace = dane_uczace(:, 1:kolumn-1);
y_uczace = dane_uczace(:, kolumn);

% Wydzielenie wejść i wyjść dla danych testowych
X_testowe = dane_testowe(:, 1:kolumn-1);
y_testowe = dane_testowe(:, kolumn);

%%
goal = 0;
best = 2;
bestTest = 0;

%spread = 0.3;
%liczba_neuronow = 1200;
%%
%          POJEDYNCZY TEST
% siec_rbf = newrb(X_uczace', y_uczace', goal, spread, liczba_neuronow, 1000);
%         y_pred = sim(siec_rbf, X_testowe')';
%         y_test_pred = sim(siec_rbf, X_uczace')';
%         proc = 100 * (1 - sum((abs(y_pred-y_testowe) > 0.5)') / length(y_pred));
%         proc2 = 100 * (1 - sum((abs(y_test_pred-y_uczace) > 0.5)') / length(y_uczace));
%          MSE = mean((y_testowe - y_pred).^2);
%          MSE2 = mean((y_uczace - y_test_pred).^2);

%%
%porównanie
spread = 0.1;
liczbaN1 = 570;
liczbaN2 = 990;
    siec_rbf = newrb(X_uczace', y_uczace', goal, spread, liczbaN1, 50);
    y_pred = sim(siec_rbf, X_testowe')';
    correct1 = abs(y_pred - y_testowe);
    correct1 = sort(correct1);
    proc = 100 * (1 - sum((abs(y_pred-y_testowe) > 0.5)') / length(y_pred));
    MSE1 = mean((y_testowe - y_pred).^2);

    siec_rbf = newrb(X_uczace', y_uczace', goal, spread, liczbaN2, 50);
    y_pred2 = sim(siec_rbf, X_testowe')';
    correct2 = abs(y_pred - y_testowe);
    correct2 = sort(correct2);
    proc2 = 100 * (1 - sum((abs(y_pred2-y_testowe) > 0.5)') / length(y_pred2));
    MSE2 = mean((y_testowe - y_pred2).^2);
            figure
            plot(y_testowe, 'k')
            hold on
            plot(y_pred, 'b')
            plot(y_pred2, 'r')
            legend('Actual data','Predictions1', 'Predictions2')
            xlabel(['Prediction1: spread: ' num2str(spread) ' neuronów: ' num2str(liczbaN1) ' poprawnosc: ' num2str(proc), ' MSE: ', num2str(MSE1), ...
                '\newlinePrediction2: spread: ' num2str(spread) ' neuronów: ' num2str(liczbaN2) ' poprawnosc: ' num2str(proc2),' MSE: ', num2str(MSE2),]);

%%
%         pojedynczy test
  Wyniki = zeros(0,6);%rozmycie, ilosc_neuronow, poprawnosc, MSE, poprawnosc dla uczacych, MSE2
% spread = 0.3;
% liczba_neuronow = 1200;
%  siec_rbf = newrb(X_uczace', y_uczace', goal, spread, liczba_neuronow, 50);
%         y_pred = sim(siec_rbf, X_testowe')';
%         y_test_pred = sim(siec_rbf, X_uczace')';
% 
%         correct = abs(y_pred - y_testowe);
%         correct = sort(correct);
%         proc = 100 * (1 - sum((abs(y_pred-y_testowe) > 0.5)') / length(y_pred));
%         proc2 = 100 * (1 - sum((abs(y_test_pred-y_uczace) > 0.5)') / length(y_uczace));
% 
%         MSE = mean((y_testowe - y_pred).^2);
%         MSE2 = mean((y_uczace - y_test_pred).^2);
%         Wyniki = [Wyniki; spread liczba_neuronow proc MSE proc2 MSE2];
% 
%             figure
%             plot(y_testowe)
%             hold on
%             plot(y_pred)
%             legend('Actual data','Predictions')
%             xlabel(['spread: ' num2str(spread) ' neuronów: ' num2str(liczba_neuronow) ' poprawnosc: ' num2str(proc)]);
%             best = proc;
%%
% caly proces nauki
%for spreadL = 0.1 : 0.2 : 2
% for spreadL = 0.01 : 0.02 : 0.1
%      for liczba_neuronowL = 10 : 70 : 1300
% disp(['spreadL = ' num2str(spreadL) ', liczba_neuronowL = ' num2str(liczba_neuronowL)]);
%         siec_rbf = newrb(X_uczace', y_uczace', goal, spreadL, liczba_neuronowL, 1000);
%         %siec_rbf = newrbe(X_uczace', y_uczace', spreadL)
%         % Testowanie sieci RBF
%         y_pred = sim(siec_rbf, X_testowe')';
%         y_test_pred = sim(siec_rbf, X_uczace')';
%         %m = mse(siec_rbf, y_pred, y_testowe);'
% 
%         correct = abs(y_pred - y_testowe);
%         correct = sort(correct);
%         proc = 100 * (1 - sum((abs(y_pred-y_testowe) > 0.5)') / length(y_pred));
%         proc2 = 100 * (1 - sum((abs(y_test_pred-y_uczace) > 0.5)') / length(y_uczace));
%         %disp(['Liczba miejsc, w których różnica jest mniejsza niż 0.5: ', num2str(proc)]);
%         if proc > bestTest
%             bestTest = proc;
%         end
%         MSE = mean((y_testowe - y_pred).^2);
%         MSE2 = mean((y_uczace - y_test_pred).^2);
%         Wyniki = [Wyniki; spreadL liczba_neuronowL proc MSE proc2 MSE2];
%         if proc > best
% 
%             %disp("Błąd średniokwadratowy (MSE): " + MSE);
%             figure
%             plot(y_testowe)
%             hold on
%             plot(y_pred)
%             legend('Actual data','Predictions')
%             xlabel(['spread: ' num2str(spreadL) ' neuronów: ' num2str(liczba_neuronowL) ' poprawnosc: ' num2str(proc)]);
%             best = proc;
%         end
%      end 
% end
disp(bestTest);