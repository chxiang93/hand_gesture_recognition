% Copyright 2017 The MathWorks, Inc.

% This matlab script is done by Sue Chen Xiang, Beh Kar Soon 
% and Poh Soon Heng

%% Load a pre-trained, deep, convolutional network
% AlexNet is a pre-trained network trained on 1000 object categories.
% AlexNet is avaliable as a support package on matlab
alex = alexnet;
% Review Network Architecture 
layers = alex.Layers

%% Modify the network to use 12 categories
layers(23) = fullyConnectedLayer(12); 
layers(25) = classificationLayer

%% Set up our training data
% Load the training images data using the imageDatastore function
% to parse the folder names as HandGesture and its subfolder
allImages = imageDatastore('HandGesture', 'IncludeSubfolders', true, 'LabelSource', 'foldernames');
% Split the data into training and testing images 
[trainingImages, testImages] = splitEachLabel(allImages, 0.8, 'randomize');

%% Re-train the Network (transfer learning)
% For transfer learning we want to change the weights of the network ever so slightly. How
% much a network is changed during training is controlled by the learning
% rates. 
opts = trainingOptions('sgdm', 'InitialLearnRate', 0.001, 'MaxEpochs', 20, 'MiniBatchSize', 64);
% Train the network
myNet = trainNetwork(trainingImages, layers, opts);

%% Measure network accuracy
predictedLabels = classify(myNet, testImages); 
accuracy = mean(predictedLabels == testImages.Labels)

%% Next:
%% 1. You need type in the command window >> classifyVideo(myNet)
%% 2. Point at the hand gesture that you want to test

