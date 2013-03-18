function [g] = gistGabor(img, w, G)
% 
%Finds gist Gaor of color image (applies Gabor filter bank on each plane)
%Image is preprocessed before applying Gabor bank - image must be first whitened and the normallized
% Input:
%   img = input image (it can be a block: [nrows, ncols, c, Nimages])
%   w = number of windows (w*w) for gist
%   G = precomputed transfer functions
%
% Output:
%   g: are the global features = [Nfeatures Nimages], 
%                    Nfeatures = w*w*Nfilters*c

img = double(imread(img));
img = imresize(img, 0.5);

% For color images, normalization is done by dividing by the local 
% luminance variance. 
 
fc = 4; % 4 cycles/image 
W = 5; 
s1 = fc/sqrt(log(2)); 
 
% Pad images to reduce boundary artifacts 
img = log(img+1); 
img = padarray(img, [W W], 'symmetric'); 
[sn, sm, c, N] = size(img); 
n = max([sn sm]); 
n = n + mod(n,2); 
img = padarray(img, [n-sn n-sm], 'symmetric','post'); 
 
% Filter 
[fx, fy] = meshgrid(-n/2:n/2-1); 
gf = fftshift(exp(-(fx.^2+fy.^2)/(s1^2))); 
gf = repmat(gf, [1 1 c N]); 
 
% Whitening 
output = img - real(ifft2(fft2(img).*gf)); 
clear img 
 
% Local contrast normalization 
localstd = repmat(sqrt(abs(ifft2(fft2(mean(output,3).^2).*gf(:,:,1,:)))), [1 1 c 1]);  
output = output./(.2+localstd); 
 
% Crop output to have same size than the input 
output = output(W+1:sn-W, W+1:sm-W,:,:); 



if ndims(output)==2
    c = 1; 
    N = 1;
end
if ndims(output)==3
    [nrows ncols c] = size(output);
    N = c;
end
if ndims(output)==4
    [nrows ncols c N] = size(img);
    output = reshape(img, [nrows ncols c*N]);
    N = c*N;
end

[n n Nfilters] = size(G);
W = w*w;
g = zeros([W*Nfilters N]);

output = single(fft2(output)); 
k=0;
for n = 1:Nfilters
    ig = abs(ifft2(output.*repmat(G(:,:,n), [1 1 N])));    
    v = downN(ig, w);
    g(k+1:k+W,:) = reshape(v, [W N]);
    k = k + W;
    drawnow
end

if c == 3
    % If the input was a color image, then reshape 'g' so that one column
    % is one images output:
    g = reshape(g, [size(g,1)*3 size(g,2)/3]);
end


function y=downN(x, N)
nx = fix(linspace(0,size(x,1),N+1));
ny = fix(linspace(0,size(x,2),N+1));
y  = zeros(N, N, size(x,3));
for xx=1:N
  for yy=1:N
    v=mean(mean(x(nx(xx)+1:nx(xx+1), ny(yy)+1:ny(yy+1),:),1),2);
    y(xx,yy,:)=v(:);
  end
end