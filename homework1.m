%% Question 1
%a
time = [0:1/1000000:3/1000];
g1 = cos(2*pi*(1000)*time);
g2 = cos(2*pi*(9000)*time);
figure(1)
hold on
plot(time, g1)
plot(time, g2)

%b
time = [0:1/8000:3/1000]; %sampling now at 8ksps
g1 = cos(2*pi*(1000)*time);
g2 = cos(2*pi*(9000)*time);
plot(time, g1, 'ro')
plot(time, g2, 'c*')

%c 
%TODO

%% Question 2
% TODO

%% Question 3 works sort of, part D gives issues??? Ask about later
figure(2)
%a
n = 0:50;
a = [1 -1.3 0.72 0.081 -0.3645];
b = [2 2.8 1.6 -0.4 -1.2];
h = impz(b, a, n);
stem(h)

%b
figure(3)
for m = 0:75
    if m <= 30
        x(m+1) = m*(30-m);
    else
        x(m+1) = 0;
    end
end
z = filter(b, a, x);
stem(z)
%c
figure(4)
d = conv(h, x);
stem(d)
%d
sizeD = size(d)
sizeZ = size(z)
C = z(1, 1:76) == d(1, 1:76)
if z(1, 1:76) == d(1, 1:76)
   test = 'Equal!'
else
  test ='Not Equal!'
end

%% Question 4
%a
%TODO

%b
[x_long,Fs] = audioread('guitar10min.ogg');
x = x_long(55*Fs:65*Fs,1);
x = x/max(abs(x));
obj1 = audioplayer(x,Fs);


%%  Question 5
% TODO
