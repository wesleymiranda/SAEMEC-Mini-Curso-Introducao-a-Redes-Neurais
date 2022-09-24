%UNIVERSIDADE FEDERAL DE RONDONÓPOLIS
%CURSO DE ENGENHARIA MECÂNICA

%===============================================================================
%                               CABEÇALHO
%===============================================================================

clear ; close all; clc;
source("extras.m");


%===============================================================================
%                             INICIALIZANDO A NN
%===============================================================================
tam_camada_entrada = 50;
tam_camada_oculta = 20;
tam_camada_saida = 9;
lambda = 1;

W1_inicial = inicializarPesos(tam_camada_entrada, tam_camada_oculta);
W2_inicial = inicializarPesos(tam_camada_oculta, tam_camada_saida);

%===============================================================================
%                        EXTRAINDO SAIDAS E ENTRADAS
%===============================================================================
tabela = criarTabela(tam_camada_saida);
entradas = extrairEntradas();

