%% Problem 6
%% A
M = 4;
sigma = 1.3;
G = 1; %placeholder value

%ii
%compute sum of impulse response to find DC gain
sum = 0;
for n = -M:M
  sum = sum + exp(-0.5*(n/sigma)^2);
end

G = 1/sum %gain coefficient for DC gain of 1

%iii
f= (-0.5:0.01:0.5); %frequency, 100 samples
window = (-M:1:M); %window in which filter is non-zero

%define our filter symbolically
syms z freq n
h(n) = piecewise((n >= -M) & (n <= M), G*exp(-0.5*(n/sigma)^2),0); 
H(z) = 0*z;
for i = -M:M
  H(z) = H(z) + h(i)*(z^-i);
end

%substitute our exponential in for z
H(freq) = subs(H(z), z, exp(1j*2*pi*freq));
%plot our filter gain
figure(1)
plot(f, abs(double(H(f))))
xlabel('Frequency (Hz)');
ylabel('Magnitude')
title('Gaussian Blur Filter Gain');

%iv
% Load the image, and convert to doubles for processing.
p1 = double(imread('Cavvy_bw.jpg'));

%calculate number of rows in image array
rows = size(p1(:,1));

%for all rows in image create new image processed through gaussian blur
%filter
for i= 1:rows
  p2(i,:) = conv(p1(i,:), double(h(window)));
end
figure(2)
%orignal image
imshow(p1,[0 255])
title('Original Image');

figure(3)
%gaussian blur processed image
imshow(p2,[0 255])
title('Gaussian Blur Filtered Image');
%% B
%define our edge detection filter
h2(n) = piecewise((n >= -M) & (n <= M), -G*(n/(sigma^2))*exp(-0.5*((n/sigma)^2)),0);

%i
%once again find our filter gain
sum = 0;
for i = -M:M
  sum = sum + (i/(sigma^2))*exp(-0.5*((i/sigma)^2));
end
%create new gain coefficient
G = -1/sum

H(z) = 0*z; 
for i= -M:M
  H(z) = H(z) + h2(i)*(z^-i);
end

%substitue our exponential in for z
H(freq) = subs(H(z), z, exp(1j*2*pi*freq));

%plot filter gain vs frequency
figure(4)
plot(f, abs(double(H(f))))
xlabel('Frequency (Hz)');
ylabel('Magnitude')
title('Edge Detection Filter Gain');

%for all rows in image create new image processed through edge detection
%filter
for i= 1:rows
  p3(i,:) = conv(p1(i,:), double(h2(window)));
end

figure(5)
%edge detection
imshow(p3, [-20 20])
title('Edge Detection Filtered Image');