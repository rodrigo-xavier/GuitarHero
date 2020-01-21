% Include subpaths
addpath(genpath(pwd))

% Encerra conexão com arduino se estiver conectado
if exist('arduino','var') == true
    delete(arduino);
end

% Encerra conexão com video se estiver conectado
if exist('video','var') == true
    delete(video);
end

video = connect_video();
arduino = connect_arduino();
configure_video(video);
% detect_time()
% configure_arduino()

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
time = 0.480;
configure_arduino(arduino, time);

time = uint16(round(time*1000,0));
msg = "OFFTIME: ";
disp(msg + time);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Flags
just_video = false;
has_external_monitor = true;


if ~has_external_monitor || just_video
    preview(video);
end
if ~just_video
    press_buttons(video, arduino);
end