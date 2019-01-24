% deconecta o galileo se estiver conectado
if exist('galileo','var') == true
    fclose(galileo);
end

% deleta o video se ele existir
if exist('vid','var') == true
    delete(vid);
end

[vid, galileo] = connect_devices();

hvpc = vision.VideoPlayer;   %create video player object

src = getselectedsource(vid);
vid.FramesPerTrigger = 1;
vid.TriggerRepeat = Inf;
vid.ReturnedColorspace = 'rgb';
% src.FrameRate = '30';
start(vid)
%[x,y] = getpts;
%start main loop for image acquisition

% cores
vermelho_min = 175;
vermelho_max = 255;

% ações
aperta_e_solta = char(100);
aperta = char(101);
solta = char(102);

while true
    imgO = getdata(vid,1,'uint8');    %get image from camera
    
    %detect red button       
    if(imgO(311,274,1) >= vermelho_min && imgO(311,274,1) <= vermelho_max)
        %colocar aqui o botao de clicar do galileo
        fprintf(galileo,'%c', aperta_e_solta);  
    end
    
    imagesc(imgO);
end
    