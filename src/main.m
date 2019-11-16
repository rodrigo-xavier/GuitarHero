% Flags
just_video = false;
has_external_monitor = false;
simulating_on_pc = true;

% Encerra conexão com arduino se estiver conectado
if exist('arduino','var') == true && ~simulating_on_pc
    delete(arduino);    
end

% Encerra conexão com video se estiver conectado
if exist('vid','var') == true && ~simulating_on_pc
    delete(vid);
end

if simulating_on_pc
    arduino = 0;
    vid = 0;
    pause(15);
else 
    [arduino, vid] = connect_devices();
    configure_video(vid);
end

% configure_arduino_time(arduino, 0.125);
% while(true)
%     envia_comando(arduino, '0');
% end

if (~has_external_monitor || just_video) && ~simulating_on_pc
    preview(vid);
end

if ~just_video
    press_buttons(vid, arduino, simulating_on_pc);
end