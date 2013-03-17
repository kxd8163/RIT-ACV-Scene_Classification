%% INITIALISATION
clc
clear
close all

% Load feature vectors
CTvect = load('pauline_CT.mat');
Gvect  = load('karina_gist.mat');

GIST  = [Gvect.Gicoast; Gvect.Giforest; Gvect.Gihighway;...
    Gvect.Gimountain; Gvect.GitallBuilding];
GIST = mean(GIST,3);

CT = [CTvect.CTcoast; CTvect.CTforest; CTvect.CThighway;...
    CTvect.CTmountain; CTvect.CTtallBuilding];
CT = mean(CT,3);

FEATURES = [GIST*1000 CT];
xFeat = linspace(1,size(FEATURES,2),size(FEATURES,2));
xGist = linspace(1,size(GIST,2),size(GIST,2));
xCT = linspace(1,size(CT,2),size(CT,2));

subplot(2,1,1)
scatter(xFeat,FEATURES(1,:),'x'); hold on,
scatter(xFeat,FEATURES(2,:),'x'); hold on,
scatter(xFeat,FEATURES(3,:),'x'); hold on,
scatter(xFeat,FEATURES(4,:),'x'); hold on,
scatter(xFeat,FEATURES(5,:),'x');
title('GIST and CT features with rescale')

subplot(2,2,3)
scatter(xGist,GIST(1,:),'x'); hold on,
scatter(xGist,GIST(2,:),'x'); hold on,
scatter(xGist,GIST(3,:),'x'); hold on,
scatter(xGist,GIST(4,:),'x'); hold on,
scatter(xGist,GIST(5,:),'x');
title('GIST features without any rescale')

subplot(2,2,4)
scatter(xCT,CT(1,:),'x'); hold on,
scatter(xCT,CT(2,:),'x'); hold on,
scatter(xCT,CT(3,:),'x'); hold on,
scatter(xCT,CT(4,:),'x'); hold on,
scatter(xCT,CT(5,:),'x');
title('CT features without any rescale')