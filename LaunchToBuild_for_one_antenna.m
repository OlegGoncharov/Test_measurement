clear; close all; clc;

load('Ant1_one_antennas.mat')
alpha = single(alpha);
channel1 = single(channel1);

rssi_1 = single(rssi_1);

pos = find(channel1(2)==channel1);
disp(['СКО для канала = ' num2str(std(alpha(pos)))])
disp(['СКО для канала = ' num2str(std(alpha))])