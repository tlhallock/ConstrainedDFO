function [extrema] = update_extrema(f1, extrema, guess)
    f1Val = f1(guess);
    f2Val = abs(f1Val);
    
    if f2Val > extrema.maxVal
      extrema.maxAbsX = guess;
      extrema.maxVal = f2Val;
    end
    if f1Val < extrema.minVal
      extrema.minX = guess;
      extrema.minVal = f1Val;
    end
endfunction