addpath('press_buttons/') 

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

preview(vid);

color_range = get_color_range()

depurate(vid, galileo, color_range);