function CS4300_print_matrix(U,rows,cols)
% CS4300_a7_driver - Prettily prints a state vector as a matrix.
% Call:
%     CS4300_a7_driver;
% Author:
%     Ryan Keepers
%     Leland Stenquist
%     UU
%     Fall 2016
%

matrix = zeros(rows,cols);

for idx = 1:length(U)
    [r,c] = CS4300_get_coords(idx, rows, cols);
    r_ = (rows+1)-r;
    matrix(r_,c) = U(idx);
end

disp(matrix);