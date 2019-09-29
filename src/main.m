% Flags
just_video = false;
has_external_monitor = true;

% Encerra conexão com arduino se estiver conectado
if exist('arduino','var') == true
    fclose(arduino);    
end

% Encerra conexão com video se estiver conectado
if exist('vid','var') == true
    delete(vid);
end

[vid, arduino] = connect_devices();
configure_video(vid);
if ~has_external_monitor || just_video
    preview(vid);
end
if ~just_video
    press_buttons(vid, arduino);
end