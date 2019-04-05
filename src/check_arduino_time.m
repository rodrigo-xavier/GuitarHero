function check_arduino_time(galileo, tempo_simple, tempo_rastro)
    % Funcao que trata do envio de tempos para o arduino
    
    % fprintf(galileo,'%c', ENVIA_TIME_SIMPLE);
    send_time_to_arduino(galileo, tempo_simple, false);

    % fprintf(galileo,'%c', ENVIA_TIME_RASTRO);
    send_time_to_arduino(galileo, tempo_rastro, true);

end

function send_time_to_arduino(galileo, time_to_send, isRastro)
    %time to send is in seconds

    if ~isRastro
        acao = char(90);
    else
        acao = char(91);
    end

    while true
        % envia o tempo para o arduino 
        fprintf(galileo,'%c', acao);
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