%===============================================================================
%                   UNIVERSIDADE FEDERAL DE RONDONÓPOLIS
%                       CURSO DE ENGENHARIA MECÂNICA
%                 SEMANA ACADÊMICA DA ENGENHARIA MECÂNICA
%                                SAEMEC 2022
%===============================================================================


%===============================================================================
%========================          CABEÇALHO            ========================
%===============================================================================
clear ; close all; clc;           #Limpeza da janela de comandos
source("extras.m");



%===============================================================================
%========================      INICIALIZANDO A NN       ========================
%===============================================================================
tam_entrada = 20*20; tam_oculta = 20; tam_saida = 9; #Definindo o tamano da rede

#W_inicial = inicializarPesos((tam_entrada+1)*tam_oculta +...
#                             (tam_oculta + 1)*tam_saida); #inicializar rede com valores aleatórios de -1 a 1



%===============================================================================
%========================  EXTRAINDO SAIDAS E ENTRADAS  ========================
%===============================================================================
y = criarTabela(tam_saida);       #Tabela com os valores corretos de saída
#X = extrairEntradasImg();         #Montar a tabela de entradas que a RN vai receber
X = extrairEntradasArq();


%===============================================================================
%========================          TREINAMENTO          ========================
%===============================================================================

#W = treinamento(W_inicial, X, y, tam_entrada, tam_oculta, tam_saida);

#salvarPesos(W)
W = carregarPesosArq();

%===============================================================================
%=========================          VALIDAÇÃO          =========================
%===============================================================================


img = imread("./img/teste/teste 1 - simbolo 4.png");
determinar(img, W, tam_entrada, tam_oculta, tam_saida);

