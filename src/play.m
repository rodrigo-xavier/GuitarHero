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
press_button(vid, galileo);

% Perguntar se press_button é um nome Okay?
% Perguntar se video.m será utilizado