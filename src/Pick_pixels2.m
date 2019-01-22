%Limpar area de trabalho
clear all;
close all;
clc;

ImOrig = imread('guitarhero3.tif');

figure, imshow(ImOrig);

%pixels de detecção de notas em geral
                                                                                                                                                                                                                                                                                                                                                                                                                        
  ImOrig(329,318,:) = 255;
  ImOrig(329,359,:) = 255;
  ImOrig(329,399,:) = 255;
  ImOrig(329,435,:) = 255;
  ImOrig(329,474,:) = 255;
  
  c = [329 329 329 329 329];
  r = [318 359 399 435 474];
  
  pixels = impixel(ImOrig,c,r);
  
  for i = 1:height(ImOrig)  
    if pixels(i,:) 
        
    end
  end
  
  figure, imshow(ImOrig);
  
%   pixels de detecção de rastro
%   verde
  ImOrig(318,250+73,:) = 255;
  ImOrig(317,250+73,:) = 255;
  ImOrig(316,251+73,:) = 255;
  ImOrig(315,251+73,:) = 255;
  ImOrig(314,251+73,:) = 255;
  ImOrig(313,252+73,:) = 255;
  ImOrig(312,252+73,:) = 255;
  ImOrig(311,252+73,:) = 255;
  ImOrig(310,253+73,:) = 255;
  ImOrig(309,253+73,:) = 255;
  ImOrig(308,253+73,:) = 255;
  ImOrig(307,254+73,:) = 255;
  ImOrig(306,254+73,:) = 255;
  
%   vermelho
  ImOrig(318,287+73,:) = 255;
  ImOrig(317,287+73,:) = 255;
  ImOrig(316,287+73,:) = 255;
  ImOrig(315,288+73,:) = 255;
  ImOrig(314,288+73,:) = 255;
  ImOrig(313,288+73,:) = 255;
  ImOrig(312,288+73,:) = 255;
  ImOrig(311,288+73,:) = 255;
  ImOrig(310,289+73,:) = 255;
  ImOrig(309,289+73,:) = 255;
  ImOrig(308,289+73,:) = 255;
  ImOrig(307,289+73,:) = 255;
  ImOrig(306,289+73,:) = 255;  
%   amarelo
  ImOrig(318,325+73,:) = 255;
  ImOrig(317,325+73,:) = 255;
  ImOrig(316,325+73,:) = 255;
  ImOrig(315,325+73,:) = 255;
  ImOrig(314,325+73,:) = 255;
  ImOrig(313,325+73,:) = 255;
  ImOrig(312,325+73,:) = 255;
  ImOrig(311,325+73,:) = 255;
  ImOrig(310,325+73,:) = 255;
  ImOrig(309,325+73,:) = 255;
  ImOrig(308,325+73,:) = 255;
  ImOrig(307,325+73,:) = 255;
  ImOrig(306,325+73,:) = 255;
  
  %   azul
  ImOrig(318,364+69,:) = 255;
  ImOrig(317,363+69,:) = 255;
  ImOrig(316,363+69,:) = 255;
  ImOrig(315,363+69,:) = 255;
  ImOrig(314,363+69,:) = 255;
  ImOrig(313,363+69,:) = 255;
  ImOrig(312,362+69,:) = 255;
  ImOrig(311,362+69,:) = 255;
  ImOrig(310,362+69,:) = 255;
  ImOrig(309,362+69,:) = 255;
  ImOrig(308,362+69,:) = 255;
  ImOrig(307,361+69,:) = 255;
  ImOrig(306,361+69,:) = 255;
  
  %   laranja 
  ImOrig(318,401+69,:) = 255;
  ImOrig(317,401+69,:) = 255;
  ImOrig(316,400+69,:) = 255;
  ImOrig(315,400+69,:) = 255;
  ImOrig(314,400+69,:) = 255;
  ImOrig(313,399+69,:) = 255;
  ImOrig(312,399+69,:) = 255;
  ImOrig(311,399+69,:) = 255;
  ImOrig(310,398+69,:) = 255;
  ImOrig(309,398+69,:) = 255;
  ImOrig(308,398+69,:) = 255;
  ImOrig(307,397+69,:) = 255;
  ImOrig(306,397+69,:) = 255;
  
  figure, imshow(ImOrig);
  [x,y] = getpts;