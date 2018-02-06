function [y, s] = calc_running_mean(x, s)
    windowsize = s.windowsize;
    blocksize = s.blocksize;
    carryover = s.carryover;
    signalWithCarry = [];
         signalWithCarry = horzcat(carryover, x);
         %avg computes normally/must deal with carryover values to left
          for colindex = (1+windowsize:blocksize+windowsize)
              y(colindex-windowsize) = sum(signalWithCarry(1, colindex-windowsize:colindex))/windowsize;
          end
          s.carryover = signalWithCarry(1, end-windowsize:end);
end