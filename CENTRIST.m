function histogram = centrist(image)
%CENTRIST returns the matrix of the CT values

    % Read images
    Im  = imread(image);
    Imgray = rgb2gray(im2double(Im));
    Imgray = imresize(Imgray, 0.25);
    Imsize = size(Imgray);

    %% CT VALUES MATRIX
    CTmat = zeros(Imsize);
    for line = 2:Imsize(1)-1
        for col = 2:Imsize(2)-1
            CTmat(line,col) = compare(Imgray(line-1:line+1, col-1:col+1));
        end
    end

    histogram = hist(CTmat(:),20);
end

