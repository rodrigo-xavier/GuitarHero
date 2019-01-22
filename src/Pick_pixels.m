%Limpar area de trabalho
clear all;
close all;
clc;

ImOrig = imread('guitarhero3.tif');

figure, imshow(ImOrig);

%pixels de detec��o de notas em geral
                                                                                                                                                                                                                                                                                                                                                                                                                        
  ImOrig(330,245,:) = 255;
  ImOrig(330,285,:) = 255;
  ImOrig(330,325,:) = 255;
  ImOrig(330,365,:) = 255;
  ImOrig(330,405,:) = 255;
  
  figure, imshow(ImOrig);
  
%   pixels de detec��o de rastro

%   verde
  ImOrig(318,250,:) = 255;
  ImOrig(317,250,:) = 255;
  ImOrig(316,251,:) = 255;
  ImOrig(315,251,:) = 255;
  ImOrig(314,251,:) = 255;
  ImOrig(313,252,:) = 255;
  ImOrig(312,252,:) = 255;
  ImOrig(311,252,:) = 255;
  ImOrig(310,253,:) = 255;
  ImOrig(309,253,:) = 255;
  ImOrig(308,253,:) = 255;
  ImOrig(307,254,:) = 255;
  ImOrig(306,254,:) = 255;

%   vermelho
  ImOrig(318,287,:) = 255;
  ImOrig(317,287,:) = 255;
  ImOrig(316,287,:) = 255;
  ImOrig(315,288,:) = 255;
  ImOrig(314,288,:) = 255;
  ImOrig(313,288,:) = 255;
  ImOrig(312,288,:) = 255;
  ImOrig(311,288,:) = 255;
  ImOrig(310,289,:) = 255;
  ImOrig(309,289,:) = 255;
  ImOrig(308,289,:) = 255;
  ImOrig(307,289,:) = 255;
  ImOrig(306,289,:) = 255;  

%   amarelo
  ImOrig(318,325,:) = 255;
  ImOrig(317,325,:) = 255;
  ImOrig(316,325,:) = 255;
  ImOrig(315,325,:) = 255;
  ImOrig(314,325,:) = 255;
  ImOrig(313,325,:) = 255;
  ImOrig(312,325,:) = 255;
  ImOrig(311,325,:) = 255;
  ImOrig(310,325,:) = 255;
  ImOrig(309,325,:) = 255;
  ImOrig(308,325,:) = 255;
  ImOrig(307,325,:) = 255;
  ImOrig(306,325,:) = 255;
  
  %   azul
  ImOrig(318,364,:) = 255;
  ImOrig(317,363,:) = 255;
  ImOrig(316,363,:) = 255;
  ImOrig(315,363,:) = 255;
  ImOrig(314,363,:) = 255;
  ImOrig(313,363,:) = 255;
  ImOrig(312,362,:) = 255;
  ImOrig(311,362,:) = 255;
  ImOrig(310,362,:) = 255;
  ImOrig(309,362,:) = 255;
  ImOrig(308,362,:) = 255;
  ImOrig(307,361,:) = 255;
  ImOrig(306,361,:) = 255;
  
  %   laranja 
  ImOrig(318,401,:) = 255;
  ImOrig(317,401,:) = 255;
  ImOrig(316,400,:) = 255;
  ImOrig(315,400,:) = 255;
  ImOrig(314,400,:) = 255;
  ImOrig(313,399,:) = 255;
  ImOrig(312,399,:) = 255;
  ImOrig(311,399,:) = 255;
  ImOrig(310,398,:) = 255;
  ImOrig(309,398,:) = 255;
  ImOrig(308,398,:) = 255;
  ImOrig(307,397,:) = 255;
  ImOrig(306,397,:) = 255;
  
  figure, imshow(ImOrig);
[x,y] = getpts;