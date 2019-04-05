function check_arduino_time(galileo, tempo_simple, tempo_rastro)
    % Funcao que trata do envio de tempos para o arduino
    
    ENVIA_TIME_SIMPLE = char(90);
    ENVIA_TIME_RASTRO = char(91);
    
    fprintf(galileo,'%c', ENVIA_TIME_SIMPLE);
    send_time_to_arduino(galileo, tempo_simple);

    fprintf(galileo,'%c', ENVIA_TIME_RASTRO);
    send_time_to_arduino(galileo, tempo_rastro);

end

function send_time_to_arduino(galileo, time_to_send)
    %time to send is in seconds

    while true
        % envia o tempo para o arduino 
        time_format = strcat('a', num2str(time_to_send*1000), 'b');
        fprintf(galileo, "%s", time_format);
        if (galileo.BytesAvailable > 0)
            out = fscanf(galileo,'%c',galileo.BytesAvailable);
            if(str2num(out)==time_to_send*1000)
                disp("Tempo: " + out);
                break;
            end
        end
    end
end