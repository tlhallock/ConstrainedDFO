function [structure] = mock_structure_create(xdim, ydim)
  structure = struct();
  structure.xs = [];
  structure.ys = [];
  structure.xdim = xdim;
  structure.ydim = ydim;
end
