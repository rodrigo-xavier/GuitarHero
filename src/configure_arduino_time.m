function configure_arduino_time(galileo, tempo_simple, tempo_rastro)
    % Funcao que trata do envio de tempos para o arduino
    
    % fprintf(galileo,'%c', ENVIA_TIME_SIMPLE);
    send_time_to_arduino(galileo, tempo_simple, false);

    % fprintf(galileo,'%c', ENVIA_TIME_RASTRO);
    send_time_to_arduino(galileo, tempo_rastro, true);
    
    disp("Tempos enviados com sucesso ao arduino!");
end

function send_time_to_arduino(galileo, time_to_send, isRastro)
    %time to send is in seconds

    if ~isRastro
        acao = [char(bin2dec('10000000')) char(bin2dec('00000000')) char(90)];
        msg = "Tempo Simples: ";
    else
        acao = [char(bin2dec('10000000')) char(bin2dec('00000000')) char(91)];
        msg = "Tempo Rastro: ";
    end

    fprintf(galileo, "%s", acao);
    out = '';
    while(true)
        if (galileo.BytesAvailable > 0)
            out = fscanf(galileo,'%c',galileo.BytesAvailable)
            if strcmp(out,'OK')
                break;
            end
        end
        fprintf(galileo, '%c', char(90));
    end
    out = ''

    time_to_send = round(time_to_send*1000,0);
    while true
        % envia o tempo para o arduino 
        time_format = strcat('a', num2str(time_to_send), 'b');
        fprintf(galileo, "%s", time_format);
        if (galileo.BytesAvailable > 0)
            out = fscanf(galileo,'%c',galileo.BytesAvailable);
            if(str2num(out)==time_to_send)
                disp(msg + out);
                break;
            end
        end
    end
end