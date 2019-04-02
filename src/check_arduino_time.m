function check_arduino_time(galileo, tempo_aperta)
    % FunÃ§Ã£o que trata do envio de tempos para o arduino

    CHECA_TIME_SIMPLE = char(109);
    
    out = 0;

    % checa se o arduino já estão rodando o código
    % com o tempo correto (isso pode ocorrer por ex.
    % quando damos CTRL + C encerrando o código do matlab,
    % mas o código e o tempo corretos continuam no arduino)
    fprintf(galileo,'%c', CHECA_TIME_SIMPLE);
    pause(0.5); % um tempo de espera para a resposta chegar
    if (galileo.BytesAvailable > 0)
        out = fscanf(galileo,'%c',galileo.BytesAvailable);
        out = str2num(out)
    end
    
    % envia o tempo para o arduino se necessÃ¡rio
    while true
        % se o arduino já tiver o tempo correto, não precisa enviar
        if(out==tempo_aperta*1000)
           break;
        elseif out~=0
            texto_erro = ['Arduino já possui um tempo, mas é diferente do ' ...
                          'tempo do nível atual. Por favor, dê reboot no Arduino.'];
            error(texto_erro);
        end
        % envia o tempo para o arduino 
        time_to_send = strcat('a', num2str(tempo_aperta*1000), 'b');
        fprintf(galileo, "%s", time_to_send);
        if (galileo.BytesAvailable > 0)
            out = fscanf(galileo,'%c',galileo.BytesAvailable);
            if(str2num(out)==tempo_aperta*1000)
                break;
            end
        end
    end

end