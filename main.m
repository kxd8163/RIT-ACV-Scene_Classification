%% INITIALISATION
clc
clear
close all

% Parameters

tstart = tic;
nbErrors = 0;

%% Extract names of images
cd Images_training/coast
ImagesCoast = dir ('*.jpg');
cd ..

cd forest
ImagesForest = dir ('*.jpg');
cd ..

cd highway
ImagesHighway = dir ('*.jpg');
cd ..

cd mountain
ImagesMountain = dir ('*.jpg');
cd ..

cd tallbuilding
ImagesTallBuilding = dir ('*.jpg');
cd ..

%% Instantiate matrixes to store trainning images feature
Gcoast = zeros(1,576,69);
Gforest = zeros(1,576,69);
Ghighway = zeros(1,576,69);
Gmountain = zeros(1,576,69);
GtallBuilding = zeros(1,576,69);

CHcoast = zeros(1,8,69);
CHforest = zeros(1,8,69);
CHhighway = zeros(1,8,69);
CHmountain = zeros(1,8,69);
CHtallBuilding = zeros(1,8,69);


%% Compute CT values - extract CENTRIST features
for i = 1:size(ImagesCoast)
    CTcoast(:,:,i) = CENTRIST4lines(ImagesCoast(i).name);
    CTforest(:,:,i) = CENTRIST4lines(ImagesForest(i).name);
    CThighway(:,:,i) = CENTRIST4lines(ImagesHighway(i).name);
    CTmountain(:,:,i) = CENTRIST4lines(ImagesMountain(i).name);
    CTtallBuilding(:,:,i) = CENTRIST4lines(ImagesTallBuilding(i).name);
end

%% Compute Gabor values - Gabor textural descriptor
for i = 1:size(ImagesCoast)
    Gcoast(:,:,i) = gistGabor(ImagesCoast(i).name);
    Gforest(:,:,i) = gistGabor(ImagesForest(i).name);
    Ghighway(:,:,i) = gistGabor(ImagesHighway(i).name);
    Gmountain(:,:,i) = gistGabor(ImagesMountain(i).name);
    GtallBuilding(:,:,i) = gistGabor(ImagesTallBuilding(i).name);
end

%% Compute color histogram for the testing images
for i = 1:size(ImagesCoast)
    CHcoast(:,:,i) = colorHist(ImagesCoast(i).name);
    CHforest(:,:,i) = colorHist(ImagesForest(i).name);
    CHhighway(:,:,i) = colorHist(ImagesHighway(i).name);
    CHmountain(:,:,i) = colorHist(ImagesMountain(i).name);
    CHtallBuilding(:,:,i) = colorHist(ImagesTallBuilding(i).name);
end

%create target matrixes for training and testing

for f=0:4
    target_opt(1,1+30*f:30*(f+1) = 1;
end

target = zeros(5,345);
for f=0:4
    target(1,1+69*f:69*(f+1)) = 1;
end

%create training and testing matrixes for Gabor features

gist = zeros(345,576);
for f=1:69
    gist(f,:) = Gcoast(:,:,f);
end

for f=70:69+69
    gist(f,:) = Gforest(:,:,f-69);
end

for f=70+69:69+69+69
    gist(f,:) = Ghighway(:,:,f-69-69);
end

for f=70+69+69:69+69+69+69
    gist(f,:) = Gmountain(:,:,f-69-69-69);
end

for f=70+69+69+69:69+69+69+69+69
    gist(f,:) = GtallBuilding(:,:,f-69-69-69-69);
end

gist=gist';


gistTest = zeros(150,576);

for f=1:150
    gististTest(f,:) = ImTestGist(1,:,f);
end 
gistTest = gistTest';

%create training and testing matrixes for CT features

CTinp = zeros(345,160);
for f=1:69
    CTinp(f,:) = CTcoast(:,:,f);
end

for f=70:69+69
    CTinp(f,:) = CTforest(:,:,f-69);
end

for f=70+69:69+69+69
    CTinp(f,:) = CThighway(:,:,f-69-69);
end

for f=70+69+69:69+69+69+69
    CTinp(f,:) = CTmountain(:,:,f-69-69-69);
end

for f=70+69+69+69:69+69+69+69+69
    CTinp(f,:) = CTtallBuilding(:,:,f-69-69-69-69);
end

CTinp = CTinp';

%create training and testing matrixes for color features

CHinp = zeros(345,8);
for f=1:69
    CHinp(f,:) = CHcoast(:,:,f);
end

for f=70:69+69
    CHinp(f,:) = CHforest(:,:,f-69);
end

for f=70+69:69+69+69
    CHinp(f,:) = CHhighway(:,:,f-69-69);
end

for f=70+69+69:69+69+69+69
        CHinp(f,:) = CHmountain(:,:,f-69-69-69);
end

for f=70+69+69+69:69+69+69+69+69
CHinp(f,:) = CHtallBuilding(:,:,f-69-69-69-69);
end

CHinp = CHinp';
%%%%%%%%%%%%%%%%%%%%%%

CTtest = zeros(150,160);
for f=1:150
CTtest(f,:) = ImTest(1,:,f);
end 
CTtest = CTtest';

%%%%%%%%%%%%%%%%%%%%%
CHtesty = zeros(150,8);
for f=1:150
    CHtesty(f,:) = CHTest(1,:,f);
end 
CHtesty = CHtesty';


mingist = min(gist(:));
maxgist = max(gist(:));
minCT = min(CTinp(:));
maxCT = max(CTinp(:));
minCH = min(CHinp(:));
maxCH = max(CHinp(:));

gistSc = (gist - mingist)./maxgist;
gistTestSc =(gistTest - mingist)./maxgist;

CTinpSc = (CTinp - minCT)./maxCT;
CTtestSc = (CTtest - minCT)./maxCT;

CHinpSc = (CHinp - minCH)./maxCH;
CHtestSc = (CHtesty - minCH)./maxCH;

GCTinp = [gistSc; CTinpSc];
GCTtest = [gistTestSc;CTtestSc];

GCHinp = [gistSc; CHinpSc];
GCHtest = [gistTestSc; CHtestSc];

CTCHinp = [CTinpSc; CHinpSc];
CTCHtest = [CTtestSc; CHtestSc];

GCTCHinp = [gistSc; CTinpSc; CHinpSc];
GCTCHtest = [gistTestSc; CTtestSc; CHtestSc];



%% Display

totalTime = toc(tstart);
disp (['Total computation time: ' int2str(totalTime)]);


