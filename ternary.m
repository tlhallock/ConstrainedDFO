function [result] = ternary(cond, value1, value2)
  if cond
    result = value1;
  else
    result = value2;
  end
end