function check_arduino_time(galileo, tempo_simple, tempo_rastro)
    % Função que trata do envio de tempos para o arduino

    CHECA_TIME_SIMPLE = char(109);
    CHECA_TIME_RASTRO = char(108);
    
    out_simple = 0;

    % checa se o arduino j� est�o rodando o c�digo
    % com o tempo correto (isso pode ocorrer por ex.
    % quando damos CTRL + C encerrando o c�digo do matlab,
    % mas o c�digo e o tempo corretos continuam no arduino)
    fprintf(galileo,'%c', CHECA_TIME_SIMPLE);
    pause(0.5); % um tempo de espera para a resposta chegar
    if (galileo.BytesAvailable > 0)
        out_simple = fscanf(galileo,'%c',galileo.BytesAvailable);
        out_simple = str2num(out_simple);
        disp(out_simple*1000);
    end
    
    out_rastro = 0;
    fprintf(galileo,'%c', CHECA_TIME_RASTRO);
    pause(0.5); % um tempo de espera para a resposta chegar
    if (galileo.BytesAvailable > 0)
        out_rastro = fscanf(galileo,'%c',galileo.BytesAvailable);
        out_rastro = str2num(out_rastro);
        disp(out_rastro*1000);
    end
    
    % envia o tempo para o arduino se necessário
    while true
        % se o arduino j� tiver o tempo correto, n�o precisa enviar
        if(out_simple==tempo_simple*1000)
           break;
        elseif out_simple~=0
            texto_erro = ['Arduino j� possui um tempo, mas � diferente do ' ...
                          'tempo do n�vel atual. Por favor, d� reboot no Arduino.'];
            error(texto_erro);
        end
        % envia o tempo para o arduino 
        time_to_send = strcat('a', num2str(tempo_simple*1000), 'b');
        fprintf(galileo, "%s", time_to_send);
        if (galileo.BytesAvailable > 0)
            out_simple = fscanf(galileo,'%c',galileo.BytesAvailable);
            if(str2num(out_simple)==tempo_simple*1000)
                disp(out_simple*1000);
                break;
            end
        end
    end

    % envia o tempo para o arduino se necessário
    while true
        % se o arduino j� tiver o tempo correto, n�o precisa enviar
        if(out_rastro==tempo_rastro*1000)
           break;
        elseif out_rastro~=0
            texto_erro = ['Arduino j� possui um tempo, mas � diferente do ' ...
                          'tempo do n�vel atual. Por favor, d� reset ou reboot no Arduino.'];
            error(texto_erro);
        end
        % envia o tempo para o arduino 
        time_to_send = strcat('a', num2str(tempo_rastro*1000), 'b');
        fprintf(galileo, "%s", time_to_send);
        if (galileo.BytesAvailable > 0)
            out_rastro = fscanf(galileo,'%c',galileo.BytesAvailable);
            if(str2num(out_rastro)==tempo_rastro*1000)
                disp(out_rastro*1000);
                break;
            end
        end
    end

end