% This function and matlab sricpt are done by all three member.
% Sue Chen Xiang ,Poh Soon Heng , Beh Kar Soon 

function img = gestureExtract(imgBackground, imgRecog)
% This function will extract the hand gesture and convert it to binary image
% so that the user can see the hand gesture in black and white in real time
% using webcam

    imgGesture = imgBackground - imgRecog;  % remove the background so that
                                            % only hand gesture is involve

    img = rgb2gray(imgGesture); %change rgb to grayscale
    img = histeq(img); % use histogram equalization to enhance the image
    lvl = graythresh(img); % determine the threshold value
    img = im2bw(img,lvl); %converts the grayscale image I to binary image BW

    img = bwareaopen(img, 1000);    % Remove pixel with less than 1000
    img = imfill(img,'holes');  % fill the hole
 
    img = imdilate(img,strel('disk',6)); %dilate iamge
    img = imerode(img,strel('disk',4));  %erode the image

    img = medfilt2(img, [5 5]);          %median filtering
end