function histogram = CENTRIST16(image)
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
        
    histo11 = hist(L1(1              :1*Imsize(1)/4),20);
    histo12 = hist(L1(1*Imsize(1)/4+1:2*Imsize(1)/4),20);
    histo13 = hist(L1(2*Imsize(1)/4+1:3*Imsize(1)/4),20);
    histo14 = hist(L1(3*Imsize(1)/4+1:4*Imsize(1)/4),20);
    histo21 = hist(L2(1              :1*Imsize(1)/4),20);
    histo22 = hist(L2(1*Imsize(1)/4+1:2*Imsize(1)/4),20);
    histo23 = hist(L2(2*Imsize(1)/4+1:3*Imsize(1)/4),20);
    histo24 = hist(L2(3*Imsize(1)/4+1:4*Imsize(1)/4),20);
    histo31 = hist(L3(1              :1*Imsize(1)/4),20);
    histo32 = hist(L3(1*Imsize(1)/4+1:2*Imsize(1)/4),20);
    histo33 = hist(L3(2*Imsize(1)/4+1:3*Imsize(1)/4),20);
    histo34 = hist(L3(3*Imsize(1)/4+1:4*Imsize(1)/4),20);
    histo41 = hist(L4(1              :1*Imsize(1)/4),20);
    histo42 = hist(L4(1*Imsize(1)/4+1:2*Imsize(1)/4),20);
    histo43 = hist(L4(2*Imsize(1)/4+1:3*Imsize(1)/4),20);
    histo44 = hist(L4(3*Imsize(1)/4+1:4*Imsize(1)/4),20);
    
    histogram = [histo11 histo12 histo13 histo14 ...
                 histo21 histo22 histo23 histo24 ...
                 histo31 histo32 histo33 histo34 ...
                 histo41 histo42 histo43 histo44];
    
end

