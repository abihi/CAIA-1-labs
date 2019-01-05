clear;
close all;

load("cdata");

figure(1);plot(cdata(:,1),'.')
figure(2);plot(cdata(:,2),'.')
figure(3);plot(cdata(:,1),cdata(:,2),'.')