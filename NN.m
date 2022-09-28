%                   UNIVERSIDADE FEDERAL DE RONDONÓPOLIS
%                       CURSO DE ENGENHARIA MECÂNICA
%                 SEMANA ACADÊMICA DA ENGENHARIA MECÂNICA
%                                SAEMEC 2022


%===============================================================================
%                               CABEÇALHO
%===============================================================================

clear ; close all; clc;
source("extras.m");


%===============================================================================



%                             INICIALIZANDO A NN
%===============================================================================
tam_camada_entrada = 20*20;
tam_camada_oculta = 20;
tam_camada_saida = 9;
lambda = 1;

W1_inicial = inicializarPesos(tam_camada_entrada, tam_camada_oculta);
W2_inicial = inicializarPesos(tam_camada_oculta, tam_camada_saida);

pesos_iniciais = [reshape(W1_inicial, numel(W1_inicial), 1);...
                 reshape(W2_inicial, numel(W2_inicial), 1)];

%===============================================================================
%                        EXTRAINDO SAIDAS E ENTRADAS
%===============================================================================
tabela = criarTabela(tam_camada_saida);
entradas = extrairEntradas();

funcCusto = @(p) funcaoCusto(p, tam_camada_entrada, tam_camada_oculta, entradas, tabela, lambda);
[pesosw] = fminunc(funcCusto, pesos_iniciais, optimset('MaxIter', 15));

imgn = imread('.\img\CODES 2D\2.png');
img_bn = threshold(imgn, 0.3);
img_linha = reshape(img_bn, numel(img_bn), 1);
img_linha = im2double(img_linha);


#predini = predicao(img_linha, pesos_iniciais, tam_camada_entrada, tam_camada_oculta, tam_camada_saida);
pred = predicao( X, pesosw, tam_camada_entrada, tam_camada_oculta, tam_camada_saida, tabela);
