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
hold off
%(C)
%TODO/See paper

%% Question 2
%See paper

%% Question 3 works sort of, part D gives issues??? Ask about later
%(A)
n = 0:75;
a = [1 -1.3 0.72 0.081 -0.3645];
b = [2 2.8 1.6 -0.4 -1.2];
h = impz(b, a, n);
figure(2)
stem(h)

%(B)
figure(3)
hold on
xn = [];
for n = 0:75
    if n <=30
        xn(n+1) = n*(30-n); 
    else
        xn(n+1) = 0;
    end
end
z = filter(b, a, xn);
stem(z, '-vb')
%(C)

d = conv(h, xn);
d(77:end) = [];
stem(d, '-^r')
%(D)
c = isequal(round(d),round(z))
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
