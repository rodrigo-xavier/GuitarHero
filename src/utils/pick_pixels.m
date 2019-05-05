% Encerra conexão com galileo se estiver conectado
if exist('galileo','var') == true
    fclose(galileo);
end

% Encerra conexão com video se estiver conectado
if exist('vid','var') == true
    delete(vid);
end

[vid, galileo] = connect_devices();
configure_video(vid);

% get image from camera
imgO = getdata(vid,1,'uint8');

figure, imshow(imgO);
[x,y] = getpts;