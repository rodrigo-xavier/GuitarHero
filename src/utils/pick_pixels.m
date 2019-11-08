% Encerra conexão com arduino se estiver conectado
if exist('arduino','var') == true
    fclose(arduino);
end

% Encerra conexão com video se estiver conectado
if exist('vid','var') == true
    delete(vid);
end

ME2 = [];
counter = 1;

% Tenta iniciar conexão com video nas 2 primeiras portas
while(counter <= 2)
    try
        ME2 = [];
        vid = videoinput('winvideo', counter, 'I420_640x480');
        break;
    catch ME2
        disp("Vid: Porta " + int2str(counter) + " Falhou!");
    end

    counter = counter + 1;
end
if isempty(ME2)
    disp("Vid: Porta " + int2str(counter) + " Sucesso!");
end

configure_video(vid);

% get image from camera
imgO = getdata(vid,1,'uint8');
        
% Pixels em cima das notas
% imgO(412,185,:) = 255;
% imgO(411,250,:) = 255;
% imgO(411,313,:) = 255;
% imgO(411,376,:) = 255;
% imgO(411,440,:) = 255;

figure, imshow(imgO);
[x,y] = getpts;