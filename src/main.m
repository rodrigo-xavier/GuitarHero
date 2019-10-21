% Flags
just_video = false;
has_external_monitor = true;

% Encerra conexão com arduino_board se estiver conectado
if exist('arduino_board','var') == true
    delete(arduino_board);    
end

% Encerra conexão com video se estiver conectado
if exist('vid','var') == true
    delete(vid);
end

[arduino_board] = connect_devices();

configure_arduino_time(arduino_board, 0.125);
while(true)
    envia_comando(arduino_board, '0');
end


% configure_video(vid);
% if ~has_external_monitor || just_video
%     preview(vid);
% end
% if ~just_video
%     press_buttons(vid, arduino_board);
% end