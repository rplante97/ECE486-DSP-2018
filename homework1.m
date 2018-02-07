%% Question 1
%(A)
time = [0:1/1000000:3/1000];
g1 = cos(2*pi*(1000)*time);
g2 = cos(2*pi*(9000)*time);
figure(1)
hold on
plot(time, g1)
plot(time, g2)

%(B)
time = [0:1/8000:3/1000]; %sampling now at 8ksps
g1 = cos(2*pi*(1000)*time);
g2 = cos(2*pi*(9000)*time);
plot(time, g1, 'ro')
plot(time, g2, 'c*')

%(C)
%TODO/See paper

%% Question 2
%See paper

%% Question 3 works sort of, part D gives issues??? Ask about later
%(A)
n = 0:50;
a = [1 -1.3 0.72 0.081 -0.3645];
b = [2 2.8 1.6 -0.4 -1.2];
h = impz(b, a, n);
stem(h)

%(B)
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

%(C)
figure(4)
d = conv(h, x);
stem(d)

%(D)
sizeD = size(d)
sizeZ = size(z)
C = z(1, 1:76) == d(1, 1:76)
if z(1, 1:76) == d(1, 1:76)
   test = 'Equal!'
else
  test ='Not Equal!'
end

%% Question 4
%(A)
%See paper

%(B)
%load in our audio file as specified in handout
[x_long,Fs] = audioread('guitar10min.ogg');
x = x_long(55*Fs:65*Fs,1);
x = x/max(abs(x));
obj1 = audioplayer(x,Fs);

%Find blocksize and number of blocks
%Probably a more efficient way to do this???
num = size(x);
num = num(1);
factors = factor(num);
blocksize = factors(3);
blocks = factors(1) * factors(2);
windowsize = 151;

%Reshape array for use with our running mean functions
blockedSignal = reshape(x,[blocksize, blocks])';

%Create our lowpass filter
lowpass = [];
s = init_running_mean(windowsize, blocksize);
for index = 1:blocks
[y, s] = calc_running_mean(blockedSignal(index, :), s);
lowpass = horzcat(lowpass, y);
end
obj2 = audioplayer(lowpass, Fs);

%Create our highpass filter
delay = (windowsize-1)/2;
delayMatrix = zeros(1, delay);
delayedSignal = horzcat(delayMatrix, x');
highpass = delayedSignal(1,1:end-delay) - lowpass;
obj3 = audioplayer(highpass, Fs);

%Create our audio mixer. Change the lowpass coefficient for more/less bass,
%change the highpass coefficient for more/less highs
mixer = 5*lowpass + 1*highpass;
mixer = mixer/max(abs(mixer)); %Normalize values to +/- 1
obj4 = audioplayer(mixer, Fs);
%% Question 5
%See paper
