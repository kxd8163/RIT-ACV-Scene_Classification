function compValue = compare(mat)
%COMPARE first compares each bit of the 3x3 matrix with its center.  
%Generates 1 if center value is greater or equal to the neighbor, 0 if the 
%center value is smaller. mat must be a 3x3 matrix. Otherwise the function 
%returns 0. If the input matrix is a 3x3 matrix, the the output will be a 
%string of bits with 0's and 1's depending on the comparisons. The string
%of bits contains the 8 neighbors bits of the center, from left to right,
%from up to down.

    sizeMat = size(mat);
    compValue = 0;
    if ((sizeMat(1) == 3) && (sizeMat(2) == 3))
        compValue = ones(3)*mat(2,2) >= mat;
        compValue = compValue';
        compValue = compValue(:)';                  % All elements in one line
        compValue = [compValue(1:4) compValue(6:9)];% Remove central element
        compValue = bi2de(compValue(end:-1:1));      % Convert to decimal value
    end
    
end

