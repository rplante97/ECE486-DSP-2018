function s = init_running_mean(windowsize, blocksize)
    s.windowsize = windowsize;
    s.blocksize = blocksize;
    s.carryover = zeros(1, windowsize);
end