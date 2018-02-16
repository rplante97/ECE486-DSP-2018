%% Problem 6
clearvars -except fig

%% A
sigma = 1.3;
M = 4;

% ii.
sum = 0;

%sum of impulse responses = dc gain
for i=-M:M
  sum = sum + exp(-0.5*(i/sigma)^2);
end

G = 1/sum 

% iii.
fwindow=[-0.5:0.01:0.5]; %frequency, 100 samples
nwindow = [-M:1:M]; %window in which filter is applied

%define the filter
syms n f z
h(n) = piecewise(n>=-M & n<=M, G*exp(-0.5*(n/sigma)^2),0); 

% x[n] z^-n from n = -inf to inf
H(z) = 0*z; 

%idk what this does right here, symbolic toolbox stuff
for i=-M:M
  H(z) = H(z) + h(i)*(z^-i);
end

H(f) = subs(H(z),z,exp(1j*2*pi*f));
%weird way to plot impulse reponse
figure(1)
plot(fwindow,abs(double(H(fwindow))));

legend('6A');
% iv.
% Load the image, and convert to doubles for processing.
p1 = double(imread('Cavvy_bw.jpg'));

%amount of rows in image
rows = size(p1);
rows = rows(1);

%for all rows in image create new image processed through impulse response
for i=1:rows
  p2(i,:) = conv(p1(i,:),double(h(nwindow)));
end

%% B
%new impulse response
h2(n) = piecewise(n>=-M & n<=M, -G*(n/(sigma^2))*exp(-0.5*((n/sigma)^2)),0);

%plotting filter gain again
sum = 0;
for n=-M:M
  sum = sum + (n/(sigma^2))*exp(-0.5*((n/sigma)^2));
end

G = -1/sum

% x[n] z^-n from n = -inf to inf
H(z) = 0*z; 
for i=-M:M
  H(z) = H(z) + h2(i)*(z^-i);
end

H(f) = subs(H(z),z,exp(1j*2*pi*f));

figure(2)
plot(fwindow,abs(double(H(fwindow))));

legend('6B');

%image detection on image
for i=1:rows
  p3(i,:) = conv(p1(i,:),double(h2(nwindow)));
end

figure(3)
%orignal image
imshow(p1,[0 255]);

figure(4)
%impulse response
imshow(p2,[0 255]);

figure(5)
%edge detection
imshow(p3,[-20 20]);