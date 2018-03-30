%Ryan Plante
%DSP Homework 5
%3/29/18

%% Question 1
%See paper

%% Question 2
x = [1 2 3 4 5 6 7 8 9 10];
y = [0.1 0.2 0.3 0.4];
conv(x, y)
fft_conv(x, y)

%% Question 3
n = 0:1:511;% giving input
A = 3.7;% amplitude
fo = 0.3308;% frequency
x = A*cos(2*pi*n*fo);% creating the signal
idx = 1:1:32768;
y1 = 10*log10(abs(fft(x,32768)))/A;% calculate dtft 32768 pints and convert into db using A amplitude as reference
y2 = 10*log10(abs(fft(x,512)))/A;% calculate dtft 512 pints and convert into db using A amplitude as reference
figure(1)
plot((idx - 16384)/16384, y1);

figure(2);
plot((idx - 16384)/16384, y1);
hold on;% plotting the db vs freq graph for both 32768 and 512 points fft
xlabel('frequency fo');
ylabel('magniitude in dB');
%figure(3)
plot((n - 256)/256, y2, '*');
xlabel('frequency fo');
ylabel('magniitude in dB');
title('Without any window');
legend('DTFT with 32768', 'DTFT with 512');
xlim([.3 .35]);

%part c
w = kaiser(512,8.0);% create the kaiser window
x2 = x.*w';% point to point multiplication wih the kaiser window
% rest is done same as above
y12 = 10*log10(abs(fft(x2,32768)))/A;
y22 = 10*log10(abs(fft(x2,512)))/A;
figure();
plot((idx - 16384)/16384, y12);hold on;
xlabel('frequency fo');
ylabel('magniitude in dB');
plot((n - 256)/256, y22, '^');
xlabel('frequency fo');
ylabel('magniitude in dB');
legend('DTFT with 32768', 'DTFT with 512');
title('With kaiser window');
xlim([.3 .35]);


%% Question 4
D = importdata('hw5data.txt');
figure(1)
E = fft(D);
x = 2*pi*(0:2047) / 2048;
x = unwrap(fftshift(x) - 2*pi);
plot(x/pi, ((2*pi)/500000).*abs(fftshift(E)))
xlabel('Rads / \pi')