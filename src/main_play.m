arduino_port = 'COM8';
vid_port = 2;

% deconecta o arduino se estiver conectado
if exist('conexao','var') == 1
    fclose(conexao);
end

conexao = serial(arduino_port);
fopen(conexao);

% deleta o video se ele existir
if exist('vid','var') == 1
    delete(vid);
end

vid = videoinput('winvideo', vid_port, 'I420_640x480');

% preview(obj)
% while true
%     frame = getsnapshot(obj);
%     imagesc(frame);
% end
%
% delete(obj);

hvpc = vision.VideoPlayer;   %create video player object

src = getselectedsource(vid);
vid.FramesPerTrigger =1;
vid.TriggerRepeat = Inf;
vid.ReturnedColorspace = 'rgb';
% src.FrameRate = '30';
start(vid)
%[x,y] = getpts;
%start main loop for image acquisition
while true
    imgO=getdata(vid,1,'uint8');    %get image from camera
    
%     imgO(383,203,2)
%     if (imgO(383,203,2) > 700) && (imgO(383,203,2) < 1023)
%         fprintf(conexao,'%c','a');
%     end
     %detect red button
     if (imgO(311,274,1) >= 175 && imgO(311,274,1) <= 255)
        %colocar aqui o botao de clicar do arduino
        fprintf(conexao,'%c',char(100));  
    end
    %   imgO(383,203,:)
    %   imgO(383,258,:)
    %   imgO(383,312,:)
    %   imgO(383,370,:)
    %   imgO(383,424,:)
    %   hvpc.step(imgO);    %see current image in player
    %   imshow(imgO);
    %   imageinfo(imgO);

    % pixels de detecção de notas em geral

    imgO(312,230,:) = 255;
    imgO(311,274,:) = 255;
    imgO(312,311,:) = 255;
    imgO(312,354,:) = 255;
    imgO(311,395,:) = 255;

    % pixels de detecção de rastro
    % verde
    imgO(293,238,:) = 255;
    imgO(292,238,:) = 255;
    imgO(291,239,:) = 255;
    imgO(290,239,:) = 255;
    imgO(289,239,:) = 255;
    imgO(288,240,:) = 255;
    imgO(287,240,:) = 255;
    imgO(286,240,:) = 255;
    imgO(285,241,:) = 255;
    imgO(284,241,:) = 255;
    imgO(283,241,:) = 255;
    imgO(282,242,:) = 255;
    imgO(281,243,:) = 255;
    %   vermelho
    imgO(293,275,:) = 255;
    imgO(292,275,:) = 255;
    imgO(291,275,:) = 255;
    imgO(290,276,:) = 255;
    imgO(289,276,:) = 255;
    imgO(288,276,:) = 255;
    imgO(287,276,:) = 255;
    imgO(286,276,:) = 255;
    imgO(285,277,:) = 255;
    imgO(284,277,:) = 255;
    imgO(283,277,:) = 255;
    imgO(282,277,:) = 255;
    imgO(281,278,:) = 255;
    %   amarelo
    imgO(293,312,:) = 255;
    imgO(292,312,:) = 255;
    imgO(291,312,:) = 255;
    imgO(290,312,:) = 255;
    imgO(289,312,:) = 255;
    imgO(288,312,:) = 255;
    imgO(287,312,:) = 255;
    imgO(286,312,:) = 255;
    imgO(285,312,:) = 255;
    imgO(284,312,:) = 255;
    imgO(283,312,:) = 255;
    imgO(282,312,:) = 255;
    imgO(281,312,:) = 255;

    %   azul
    imgO(291,349,:) = 255;
    imgO(290,349,:) = 255;
    imgO(289,349,:) = 255;
    imgO(288,349,:) = 255;
    imgO(287,349,:) = 255;
    imgO(286,349,:) = 255;
    imgO(285,348,:) = 255;
    imgO(284,348,:) = 255;
    imgO(283,348,:) = 255;
    imgO(282,348,:) = 255;
    imgO(281,348,:) = 255;
    imgO(280,348,:) = 255;
    imgO(279,348,:) = 255;

    %   laranja
    imgO(294,387,:) = 255;
    imgO(293,387,:) = 255;
    imgO(292,386,:) = 255;
    imgO(291,386,:) = 255;
    imgO(290,386,:) = 255;
    imgO(289,385,:) = 255;
    imgO(288,385,:) = 255;
    imgO(287,385,:) = 255;
    imgO(286,384,:) = 255;
    imgO(285,384,:) = 255;
    imgO(284,384,:) = 255;
    imgO(283,383,:) = 255;
    imgO(282,382,:) = 255;

    imagesc(imgO);
end
figure, imshow(imgO);
[x,y] = getpts;
