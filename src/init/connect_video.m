function [video] = connect_video()
    counter = 1;
    video_message = [];

    % Tenta iniciar conexão com video nas 2 primeiras portas
    while(counter <= 2)
        try
            video_message = [];
            video = videoinput('winvideo', counter, 'I420_640x480');
            break;
        catch video_message
            disp("Vid: Porta " + int2str(counter) + " Falhou!");
        end

        counter = counter + 1;
    end
    
    if isempty(video_message)
        disp("Vid: Porta " + int2str(counter) + " Sucesso!");
    end

    % try
    %     video = videoinput('winvideo', 1, 'I420_640x480');
    %     disp("Vid: Porta 1 Sucesso!");
    % catch ME
    %     video = videoinput('winvideo', 2, 'I420_640x480');
    %     disp("Vid: Porta 2 Sucesso!");
    % end
end