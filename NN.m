%UNIVERSIDADE FEDERAL DE RONDONÓPOLIS
%CURSO DE ENGENHARIA MECÂNICA
%
clear ; close all; clc

%===============================================================================
%                             INICIALIZANDO A NN
%===============================================================================
tam_camada_entrada = 20;
tam_camada_oculta = 20;
tam_camada_saida = 10;
lambda = 1;

W1_inicial = inicializarPesos(tam_camada_entrada, tam_camada_oculta);
W2_inicial = inicializarPesos(tam_camada_oculta, tam_camada_saida);



