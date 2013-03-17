function histogram = CENTRIST4lines(image)
%CENTRIST returns the matrix of the CT values

    % Read images
    Im  = imread(image);
    Imgray = rgb2gray(im2double(Im));
    Imgray = imresize(Imgray, 0.125);
    Imsize = size(Imgray);

    %% CT VALUES MATRIX
    CTmat = zeros(Imsize);
    for line = 2:Imsize(1)-1
        for col = 2:Imsize(2)-1
            CTmat(line,col) = compare(Imgray(line-1:line+1, col-1:col+1));
        end
    end
    
    L1 = CTmat(1              :1*Imsize(1)/4, :);
    L2 = CTmat(1*Imsize(1)/4+1:2*Imsize(1)/4, :);
    L3 = CTmat(2*Imsize(1)/4+1:3*Imsize(1)/4, :);
    L4 = CTmat(3*Imsize(1)/4+1:4*Imsize(1)/4, :);
    
    histo1 = hist(L1(:),40);
    histo2 = hist(L2(:),40);
    histo3 = hist(L3(:),40);
    histo4 = hist(L4(:),40);
    
    histogram = [histo1 histo2 histo3 histo4];
    
end

