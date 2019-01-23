% deconecta o arduino se estiver conectado
if exist('conexao','var') == 1
    fclose(conexao);
end

% deleta o video se ele existir
if exist('vid','var') == 1
    delete(vid);
end

i = 0;

% Tenta iniciar conexão com arduino nas 20 primeiras portas
while(i <= 20)
    port_name = 'COM';
    port_number = int2str(i);
    arduino_port = strcat(port_name, port_number);

    try
        conexao = serial(arduino_port);
        fopen(conexao);
        break;
    catch
        string = ['Porta COM', i, ' Falhou'];
        disp(string)
    end

    i = i + 1;
end

i = 0;

% Tenta iniciar conexão com video nas 2 primeiras portas
while(i <= 2)
    vid_port = i; % vid_port pode variar (1 ou 2)

    try
        vid = videoinput('winvideo', vid_port, 'I420_640x480');
        break;
    catch
        string = ['Porta VID', i, ' Falhou'];
        disp(string)
    end

    i = i + 1;
end

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
    imgO=getdata(vid,1,'uint8');    %get image from camera
    
    %detect red button       
    if(imgO(311,274,1) >= vermelho_min && imgO(311,274,1) <= vermelho_max)
        %colocar aqui o botao de clicar do arduino
        fprintf(conexao,'%c', aperta_e_solta);  
    end
    
    imagesc(imgO);
end
    