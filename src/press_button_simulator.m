function press_button_simulator(robot, comandoString)
    time = 0.2;
    
    if (comandoString == '0000000000000000') % APERTO SIMPLES VERDE
        robot.keyPress    (java.awt.event.KeyEvent.VK_A);
    end
    if (comandoString(1) == '1') % APERTO SIMPLES VERMELHO
        robot.keyPress    (java.awt.event.KeyEvent.VK_S);
    end
    if (comandoString(2) == '1') % APERTO SIMPLES AMARELO
        robot.keyPress    (java.awt.event.KeyEvent.VK_J);
    end
    if (comandoString(3) == '1') % APERTO SIMPLES AZUL
        robot.keyPress    (java.awt.event.KeyEvent.VK_K);
    end
    if (comandoString(4) == '1') % APERTO SIMPLES LARANJADO
        robot.keyPress    (java.awt.event.KeyEvent.VK_L);
    end
    
    pause(time);
    robot.keyRelease  (java.awt.event.KeyEvent.VK_A);
    robot.keyRelease  (java.awt.event.KeyEvent.VK_S);
    robot.keyRelease  (java.awt.event.KeyEvent.VK_J);
    robot.keyRelease  (java.awt.event.KeyEvent.VK_K);
    robot.keyRelease  (java.awt.event.KeyEvent.VK_L);

%     if comandoString(5) == '1' % APERTO SEM SOLTAR VERDE
%         robot.keyPress    (java.awt.event.KeyEvent.VK_A);
%     end
%     if comandoString(6) == '1' % APERTO SEM SOLTAR VERMELHO
%         robot.keyPress    (java.awt.event.KeyEvent.VK_S);
%     end
%     if comandoString(7) == '1' % APERTO SEM SOLTAR AMARELO
%         robot.keyPress    (java.awt.event.KeyEvent.VK_J);
%     end
%     if comandoString(8) == '1' % APERTO SEM SOLTAR AZUL
%         robot.keyPress    (java.awt.event.KeyEvent.VK_K);
%     end
%     if comandoString(9) == '1' % APERTO SEM SOLTAR LARANJADO
%         robot.keyPress    (java.awt.event.KeyEvent.VK_L);
%     end
% 
%     if comandoString(10) == '1'
%         robot.keyRelease  (java.awt.event.KeyEvent.VK_A);
%     end
%     if comandoString(11) == '1'
%         robot.keyRelease  (java.awt.event.KeyEvent.VK_S);
%     end
%     if comandoString(12) == '1'
%         robot.keyRelease  (java.awt.event.KeyEvent.VK_J);
%     end
%     if comandoString(13) == '1'
%         robot.keyRelease  (java.awt.event.KeyEvent.VK_K);
%     end
%     if comandoString(14) == '1'
%         robot.keyRelease  (java.awt.event.KeyEvent.VK_L);
%     end

end