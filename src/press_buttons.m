function press_buttons(vid, galileo)
    % colors
    red_min = 175;
    red_max = 255;

    % actions
    aperta_e_solta = char(100);

    while true
        % get image from camera
        imgO = getdata(vid,1,'uint8');
        
        % Detecta bit vermelho
        if(imgO(311,274,1) >= red_min && imgO(311,274,1) <= red_max)
            %colocar aqui o botao de clicar do galileo
            fprintf(galileo,'%c', aperta_e_solta);
        end
        
        imagesc(imgO);
    end
end