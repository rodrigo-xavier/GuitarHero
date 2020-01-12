function [video] = connect_video()
    try
        video = videoinput('winvideo', 1, 'I420_640x480');
        disp("Vid: Porta 1 Sucesso!");
    catch ME
        disp("Vid: Porta 1 Fail!");
    end
    try
        video = videoinput('winvideo', 2, 'I420_640x480');
        disp("Vid: Porta 2 Sucesso!");
    catch ME
        disp("Vid: Porta 2 Fail!");
    end
end