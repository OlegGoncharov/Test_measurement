clear; close all; clc;

location = 2; % 1 - в холле, 2 - в бэзэховой камере

if location == 1
    cd('In_hall')
    mat = dir('*.mat');
    for q = 1:length(mat)
        load(mat(q).name);
    end
    alpha1 = single(alpha1);
    alpha2 = single(alpha2);
    rssi_1 = single(rssi_1);
    rssi_2 = single(rssi_2);
    alpha2 = alpha2(1:end-1);
    rssi_2 = rssi_2(1:end-1);
elseif location == 2
    cd('In_chamber')
    mat = dir('*.mat');
    for q = 1:length(mat)
        load(mat(q).name);
    end
    alpha1 = single(alpha1);
    alpha2 = single(alpha2);
    rssi_1 = single(rssi_1);
    rssi_2 = single(rssi_2);
else
    disp('Введите 1 или 2')
end

figure('units','normalized','outerposition',[0 0 1 1])
subplot(2,2,1)
histogram(alpha1)
title('Гистограмма распределения угла прихода \alpha_1')

subplot(2,2,2)
histogram(rssi_1)
title('Гистограмма распределения мощности RSSI_1')

subplot(2,2,3)
histogram(alpha2)
title('Гистограмма распределения угла прихода \alpha_2')

subplot(2,2,4)
histogram(rssi_2)
title('Гистограмма распределения мощности RSSI_2')

figure('units','normalized','outerposition',[0 0 1 1])
subplot(2,2,1)
plot(1:length(alpha1),alpha1)
xlabel('t, отсчеты')
ylabel('гр.', 'rotation',0)
title('\alpha_1')

subplot(2,2,2)
plot(1:length(alpha2),alpha2)
xlabel('t, отсчеты')
ylabel('гр.', 'rotation',0)
title('\alpha_2')

subplot(2,2,3)
plot(1:length(alpha1),rssi_1)
xlabel('t, отсчеты')
ylabel('дБ', 'rotation',0)
title('RSSI_1')

subplot(2,2,4)
plot(1:length(rssi_1),rssi_2)
xlabel('t, отсчеты')
ylabel('дБ', 'rotation',0)
title('RSSI_2')

d = 0.37;
r1 = abs(d*sin((90-alpha2)*pi/180)./sin((90-alpha1)*pi/180+(90-alpha2)*pi/180));
r2 = abs(d*sin((90-alpha1)*pi/180)./sin((90-alpha1)*pi/180+(90-alpha2)*pi/180));

figure('units','normalized','outerposition',[0 0 1 1])
subplot(1,2,1)
plot(1:length(r1),r1)
xlabel('t, отсчеты')
title('R_1')

subplot(1,2,2)
histogram(r1)
xlabel('R, м')
title('R_1')

figure('units','normalized','outerposition',[0 0 1 1])
subplot(1,2,1)
plot(1:length(r1),r2)
xlabel('t, отсчеты')
title('R_2')

subplot(1,2,2)
histogram(r2)
xlabel('R, м')
title('R_2')

disp('Статистические измерения в холле')
cd('../')
cd('In_hall')
mat = dir('*.mat');
for q = 1:length(mat)
    load(mat(q).name);
end
alpha1 = single(alpha1);
alpha2 = single(alpha2);
rssi_1 = single(rssi_1);
rssi_2 = single(rssi_2);
alpha2 = alpha2(1:end-1);
rssi_2 = rssi_2(1:end-1);
d = 0.27;
r1 = abs(d*sin((90-alpha2)*pi/180)./sin((90-alpha1)*pi/180+(90-alpha2)*pi/180));
r2 = abs(d*sin((90-alpha1)*pi/180)./sin((90-alpha1)*pi/180+(90-alpha2)*pi/180));
disp(['СКО alpha1 = ' num2str(std(alpha1)) ' градусов'])
disp(['СКО alpha2 = ' num2str(std(alpha2)) ' градусов'])
disp(['СКО RSSI_1 = ' num2str(std(rssi_1)) ' дБ'])
disp(['СКО RSSI_2 = ' num2str(std(rssi_2)) ' дБ'])
disp(['СКО R_1 = ' num2str(std(r1)) ' м'])
disp(['Среднее значение R_1 = ' num2str(mean(r1)) ' м'])
disp(['СКО R_2 = ' num2str(std(r2)) ' м'])
disp(['Среднее значение R_2 = ' num2str(mean(r2)) ' м'])
disp('   ')
disp('   ')
disp('   ')
disp('Статистические измерения в безэховой камере')
cd('../')
cd('In_chamber')
mat = dir('*.mat');
for q = 1:length(mat)
    load(mat(q).name);
end
alpha1 = single(alpha1);
alpha2 = single(alpha2);
rssi_1 = single(rssi_1);
rssi_2 = single(rssi_2);
d = 0.1;
r1 = abs(d*sin((90-alpha2)*pi/180)./sin((90-alpha1)*pi/180+(90-alpha2)*pi/180));
r2 = abs(d*sin((90-alpha1)*pi/180)./sin((90-alpha1)*pi/180+(90-alpha2)*pi/180));
disp(['СКО alpha1 = ' num2str(std(alpha1)) ' градусов'])
disp(['СКО alpha2 = ' num2str(std(alpha2)) ' градусов'])
disp(['СКО RSSI_1 = ' num2str(std(rssi_1)) ' дБ'])
disp(['СКО RSSI_2 = ' num2str(std(rssi_2)) ' дБ'])
disp(['СКО R_1 = ' num2str(std(r1)) ' м'])
disp(['Среднее значение R_1 = ' num2str(mean(r1)) ' м'])
disp(['СКО R_2 = ' num2str(std(r2)) ' м'])
disp(['Среднее значение R_2 = ' num2str(mean(r2)) ' м'])
close all