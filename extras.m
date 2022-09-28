%                   UNIVERSIDADE FEDERAL DE RONDONÓPOLIS
%                       CURSO DE ENGENHARIA MECÂNICA
%                 SEMANA ACADÊMICA DA ENGENHARIA MECÂNICA
%                                SAEMEC 2022

%===============================================================================
%                              CABEÇALHO
%===============================================================================

1; %Usado para o Octave identificar que se trata de um script file,
   %e não confundir com um function file

%===============================================================================
%                               ABRIR IMAGENS
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

  entradas = [];

  for i = 1:m
    img = imread(arquivos_dir{i, 1});
    img_bn = threshold(img, 0.3);
    img_linha = reshape(img_bn, numel(img_bn), 1);
    entradas = [entradas, img_linha];
  endfor



endfunction

%===============================================================================
%                              INICIALIZAR PESOS
%===============================================================================

function pesos = inicializarPesos(tam_anterior, tam_prox)
  pesos = rand(tam_prox, tam_anterior+1);          #pesos(w) randomicos [linhas]=saidas [colunas]=entradas
  pesos = pesos - 0.5

 endfunction

%===============================================================================
%                                  THRESHOLD
%===============================================================================

function img_bn = threshold(img_rgb, thresh)


  img_bn = rgb2gray(img_rgb);
  img_bn = im2double(img_bn);
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
%                                   SIGMOID
%===============================================================================

function g = sigmoid(z)
  g = 1 ./ (1 + e.^-z);
endfunction

%===============================================================================
%                              SIGMOID GRADIENT
%===============================================================================

function g = sigmoidGradient(z)
  g = sigmoid(z).*(1-sigmoid(z));
endfunction

%===============================================================================
%                               FUNÇÃO DE CUSTO
%===============================================================================
 function [J] = funcaoCusto(pesos,tam_cam_input, tam_cam_hiden, X, y, lambda)

  W1 = reshape(pesos(1:tam_cam_hiden*(tam_cam_input+1)), tam_cam_hiden, tam_cam_input+1);
  W2 = reshape(pesos(tam_cam_hiden*(tam_cam_input+1)+1:end), length(y), tam_cam_hiden+1);

  m = size(X, 2);                   #Camada entrada: linhas x 1
  J = 0;

  X = [ones(1, columns(X)); X];
  a1 = W1*X;
  z1 = sigmoid(a1);

  a2 = [ones(1, columns(a1)); z1];
  z2 = W2*a2;
  h = sigmoid(z2);

  J = (1/m) * sum(sum((-y).*log(h)-(1-y).*log(1-h)))

endfunction
%===============================================================================
%                               FUNÇÃO DE CUSTO
%===============================================================================
function h = predicao(X, W, tam_cam_input, tam_cam_hiden, tam_cam_out, y)

  W1 = reshape(W(1:tam_cam_hiden*(tam_cam_input+1)), tam_cam_hiden, tam_cam_input+1);
  W2 = reshape(W(tam_cam_hiden*(tam_cam_input+1)+1:end), tam_cam_out, tam_cam_hiden+1);
  m = size(X, 2);

  X = [ones(1, columns(X)); X]
  a1 = W1*X
  z1 = sigmoid(a1)

  a2 = [ones(1, columns(a1)); z1]
  z2 = W2*a2
  h = sigmoid(z2)

  J = (1/m) * sum(sum((-y).*log(h)-(1-y).*log(1-h)));

  endfunction

