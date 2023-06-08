clear all
close all
clc


filename = 'C:/python_code/projekt_ai/d_sha_ready.txt';
delimiterIn = '\n';

A = importdata(filename, delimiterIn);
N = 1600;
M = 64;
X = zeros(N, M);
Y = strings(N, 1);
Z = strings(100, 1);
z = 1;
for i=1 : N
    
    rekord = A{i, 1};
    rekordStr = string(rekord);
    elementy = split(rekordStr, ",");
    for j=1 : M 
        X(i, j) = str2double(elementy(j+1, 1));
    end
    Y(i, 1) = elementy(1);
    if mod(i, 16) == 0
        Z(z, 1) = elementy(1);
        z = z+1;
    end
end

YY = zeros(size(Y));
for i=1 : N
    YY(i, 1) = find(Z == Y(i,1));
end

oldMin = min(X);
oldMax = max(X);
Xn = zeros(size(X));
newMin = 0;
newMax = 1;

for j=1 : M
    %Xn(:, j) = ((X(:, j) - oldMin(1, j)) ./ (oldMax(1, j) - oldMin(1, j))) .* (newMax - newMin) + newMin;
    Xn(:, j) = X(:, j); bez normalizacji
end


save("C:/python_code/projekt_ai/daneShaWithNorm.mat", 'N', 'M', 'X', 'Xn', 'Y', 'YY');