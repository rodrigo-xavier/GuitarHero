% Flags
just_video = false;
has_external_monitor = true;

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
if ~has_external_monitor || just_video
    preview(vid);
end
if ~just_video
    press_buttons(vid, galileo);
end