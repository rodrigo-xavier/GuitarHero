function [tempo_aperta, tempo_espera] = choose_times(nivel)
    %Esta função retorna os tempos corretos de acordo com o nível passado.
    % O nível é o que estiver sendo jogado.
    
        if(strcmp(nivel,'easy_slowest'))
            tempo_aperta = 1.094;
            tempo_espera = 0.5;
        elseif(strcmp(nivel, 'easy_slower'))
            tempo_aperta = 0.819;
            tempo_espera = 0.5;
        elseif(strcmp(nivel,'easy_slow'))
            tempo_aperta = 0.723;
            tempo_espera = 0.5;
        elseif(strcmp(nivel,'easy_full_speed'))
            tempo_aperta = 0.535;
            tempo_espera = 0.5;
        elseif(strcmp(nivel,'medium_slowest'))
            tempo_aperta = 0.874;
            tempo_espera = 0.5;
        elseif(strcmp(nivel, 'medium_slower'))
            tempo_aperta = 0.630;
            tempo_espera = 0.5;
        elseif(strcmp(nivel, 'medium_slow'))
            tempo_aperta = 0.543;
            tempo_espera = 0.5;
        elseif(strcmp(nivel, 'medium_full_speed'))
            tempo_aperta = 0.439;
            tempo_espera = 0.5;
        elseif(strcmp(nivel, 'hard_slowest'))
            tempo_aperta = 0.749;
            tempo_espera = 0.5;
        elseif(strcmp(nivel,'hard_slower'))
            tempo_aperta = 0.573;
            tempo_espera = 0.5;
        elseif(strcmp(nivel,'hard_slow'))
            tempo_aperta = 0.474;
            tempo_espera = 0.5;
        elseif(strcmp(nivel,'hard_full_speed'))
            tempo_aperta = 0.369;
            tempo_espera = 0.5;
        elseif(strcmp(nivel,'expert_slowest'))
            tempo_aperta = 0.652;
            tempo_espera = 0.5;
        elseif(strcmp(nivel,'expert_slower'))
            tempo_aperta = 0.493;
            tempo_espera = 0.5;
        elseif(strcmp(nivel,'expert_slow'))
            tempo_aperta = 0.402;
            tempo_espera = 0.5;
        elseif(strcmp(nivel,'expert_full_speed'))
            tempo_aperta = 0.307;
            tempo_espera = 0.5;
        end
        
    end