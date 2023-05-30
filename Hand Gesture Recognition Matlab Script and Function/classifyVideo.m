% This function and matlab sricpt are done by all three member.
% Sue Chen Xiang ,Poh Soon Heng , Beh Kar Soon 

function [] = classifyVideo(net)
% This function will open a webcam and take image in real time to capture
% and classify hand gesture that is detected using the network model
% trained pass in as argument

    % Initialize webcam
    cam = webcam;
    % Initialize figure
    hf = figure;
    x=0; %set coordinat x for rectangle
    y=0; %set coordinat y for rectangle
    height=500; %set height for rectangle to identify hand gesture
    width=500;  %set width for rectangle to identify hand gesture
    bbox =[x y height width];
    imgBackground = cam.snapshot; % Snap a pic for background
    imgBackground =imcrop(imgBackground,bbox);

    while 1
        % compares the current character to q
        % if 'q' is pressed exit
        if strcmp(get(hf,'currentcharacter'),'q')
            close(hf)
            break
        end
        % Acquire a single image
        rgbImage = snapshot(cam);
        processingArea = insertObjectAnnotation(rgbImage,'rectangle',bbox,'Processing Area');   
        img =imcrop(rgbImage,bbox);
        % Resize image to fit AlexNet dimensions
        resizedImage = imresize(img, [227 227]);
        % Classify Image
        label = classify(net,resizedImage);
        subplot(1,2,1)
        % Display the image.
        imshow(processingArea);
        % Display label
        title(label,"FontSize",20);
        % Update figure
        hold on;
        drawnow
        imgThreshold = gestureExtract(imgBackground,img); %Use extract technique
        subplot(1,2,2)
        imshow(imgThreshold) %show threshold image
        title('Processed Image')
        drawnow
    end
    
    % Clear camera object
    clear('cam');
end