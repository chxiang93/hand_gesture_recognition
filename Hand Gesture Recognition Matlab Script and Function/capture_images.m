clc, clear all, close all

% This matlab script is done by Sue Chen Xiang, Beh Kar Soon 
% and Poh Soon Heng

%Close the warning statements
warning off;

%Variables
cam=webcam; %This will open the webcam
c=200;  % Maximum photo to captured
temp=0; % Counter for keep track how many image was taken
hf = figure;

%Programm will stop every 50 times after image captured, press c to
%continue
while true
    e=cam.snapshot; % Take a snapshot from the webcam

    if(mod(temp,50)==0) % If reach every 50 images
        w = waitforbuttonpress;     % Wait for keyboard
        if w
            ch = get(hf,'currentcharacter');
            while strcmp(ch,'c') == false   % If the keyboard input is not c
                pause(1)
                ch = get(hf,'currentcharacter');
            end
        end
    end
    %Program stop after 200 images captured
    if(temp>=c)
        break;
    else
    %resize the captured images and in bmp format
    es=imresize(e,[227 227]);
    filename=strcat(num2str(temp),'.bmp');
    imwrite(es,filename);
    temp=temp+1;
    imshow(es);
    drawnow;
    end
end