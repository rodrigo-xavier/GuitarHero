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
% preview(vid);
[note_time, trail_time] = detect_level(vid);
fprintf("%f", note_time)
fprintf("\n")
fprintf("%f", trail_time)
press_buttons(vid, galileo);