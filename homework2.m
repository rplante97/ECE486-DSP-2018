%Ryan Plante
%DSP Homework 2
%14 February 2018

%% Question 1
%See paper
%% Question 2
%See paper
%% Question 3
%Filter 1

%Declare Difference Eq Coefficients
a1 = [1 -1.5371 0.9025];
b1 = [1 1.6180 1];

%frequency array, ~1000 point resolution
f = -0.5:.001:0.5;

z = exp(i*2*pi*f); %input

%Evaluate H(z) = Y(z)/X(Z) at all points of Z
hz1 = polyval(b1, z) ./polyval(a1, z);
hz1db = 20*log10(hz1); %convert from magnitude to db
plot(f, hz1db)

%Filter 2

a2 = [1 0 -0.81];
b2 = [1 -0.618 1];

hz2 = polyval(b2, z) ./polyval(a2, z);
hz2db = 20*log10(hz2);
figure(2)
plot(f, hz2db)




%% Question 4
%a
casc =(hz1db+hz2db); %cascade the two filters together
gain = 1/(20*log10(abs(max(casc)))) %find gain for max 1 db gain

%b
cascadeWithGain = gain*casc;

figure(3)
plot(f,cascadeWithGain)

%c
x = [0 0 0 0 0 0 0 0 3 1.5 -1.8 0.2 0 0 0 0 0 0 0 0];
stage1 = filter(b1, a1, x*gain)
stage2 = filter(b2, a2, stage1)

%% Question 5
a = [1 -1.8*cos(2*pi*(0.3)) 0.81];
b = [1 -2*cos(2*pi*(0.06)) 1];

hz3 = polyval(b, z) ./ polyval(a, z);
hz3 = 20*log10(hz3);
figure(11)
plot(f, hz3)
%% Question 6

%% Question 7
%Mostly on paper, some matlab