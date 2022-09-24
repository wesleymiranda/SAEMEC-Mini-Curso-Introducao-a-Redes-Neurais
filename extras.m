%UNIVERSIDADE FEDERAL DE RONDONÓPOLIS
%CURSO DE ENGENHARIA MECÂNICA

%===============================================================================
%                              CABEÇALHO
%===============================================================================

1; %Usado para o Octave identificar que se trata de um script file,
   %e não confundir com um function file

%===============================================================================
%                         PREPARANDO A TABELA VERDADE
%===============================================================================

function [arquivos, pasta, formato] = lendoArquivos()
  pasta = '.\img\CODES 2D\';
  formato = '.png';
  arquivos = glob(strcat(pasta, "*", formato));
endfunction

%===============================================================================
%                         PREPARANDO A TABELA VERDADE
%===============================================================================

function tabela = criarTabela(n_saidas)

  [arquivos_dir, pasta, formato] = lendoArquivos();
  arquivos_format = strrep(arquivos_dir, pasta, "");
  arquivos_nome = strrep(arquivos_format, formato, "");

  m = size(arquivos_nome, 1);

  tabela = zeros(m, n_saidas);

  for i = 1:m
   tabela(i, str2num(arquivos_nome{i, 1})) = 1;
  endfor

endfunction

%===============================================================================
%                         EXTRAIR ENTRADAS
%===============================================================================

function entradas = extrairEntradas()

  arquivos_dir = lendoArquivos();
  m = size(arquivos_dir, 1);

  entradas = []

  for i = 1:m
    img = imread(arquivos_dir{i, 1});
    img_bn = threshold(img)
    entradas = [img_bn, entradas];
  endfor

endfunction

%===============================================================================
%                         PREPARANDO A TABELA VERDADE
%===============================================================================

function pesos = inicializarPesos(tam_anterior, tam_prox)
  pesos = rand(tam_prox, tam_anterior);          #pesos(w) randomicos [linhas]=saidas [colunas]=entradas
  pesos = [ones(tam_prox, 1), pesos];            #Bias
 endfunction

%===============================================================================
%                                  THRESHOLD
%===============================================================================

function img_bn = threshold(img_rgb, thresh)

  img_bn = rgb2gray(img_rgb);
  m = size(img_bn);

  for i = 1:m(1)
    for j = 1:m(2)
      if img_bn(i, j) >= thresh
        img_bn(i, j) = 1;
      else
        img_bn(i, j) = 0;
      endif
   endfor
  endfor
 endfunction


%===============================================================================
%                               FUNÇÃO DE CUSTO
%===============================================================================
 function J = funcaoCusto(W1, W2, entrada)
  m = size(W1, 1)                   #Camada entrada: linhas x 1


endfunction


