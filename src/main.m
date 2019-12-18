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
configure_video(video);
arduino = connect_arduino();
% detect_time
% configure_arduino


% Flags
just_video = false;
has_external_monitor = true;


if ~has_external_monitor || just_video
    preview(video);
end
if ~just_video
    press_buttons(video, arduino);
end