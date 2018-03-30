function y = fft_conv(h, x)

M = length(h);
N = length(x);
L = 1024 - M + 1;

% Zero-pad h. M is guaranteed to be < 200.
h = [h, zeros(1, 1024-M)];

H = fft(h);

% Start putting together y.
y = [];
previous = zeros(1, M-1);
num_blocks = ceil(N / L);

% For all the full blocks..
for i = 1:num_blocks-1

    % Define x.
    start = L*(i-1) + 1;
    stop  = L*i;
    block = [previous, x(start:stop)];

    % Take the fft and multiply by fft(h).
    X = fft(block);
    Y = X .* H;

    % Put onto y, without the junk values.
    y_ = ifft(Y);
    y = [y, y_(M:end)];

    previous = block(end-M+2:end);

end

% Run that once more for the partial block.

start = L*(num_blocks-1) + 1;
block = [previous, x(start:end)];
block = [block, zeros(1, 1024-length(block))];

X = fft(block);
Y = X .* H;

y_ = ifft(Y);
y = [y, y_(M:end)];

end
