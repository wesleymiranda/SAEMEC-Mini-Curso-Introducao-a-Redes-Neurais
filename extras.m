%===============================================================================
%                   UNIVERSIDADE FEDERAL DE RONDONÓPOLIS
%                       CURSO DE ENGENHARIA MECÂNICA
%                 SEMANA ACADÊMICA DA ENGENHARIA MECÂNICA
%                                SAEMEC 2022
%===============================================================================
%========================          CABEÇALHO            ========================
%===============================================================================
1; %Usado para o Octave identificar que se trata de um script file,
   %e não confundir com um function file.


%===============================================================================
%========================         ABRIR IMAGENS         ========================
%===============================================================================
function [arquivos, pasta, formato] = lendoArquivos()
  pasta = '.\img\CODES 2D\';
  formato = '.png';
  arquivos = glob(strcat(pasta, "*", formato));
endfunction


%===============================================================================
%========================  PREPARANDO A TABELA VERDADE  ========================
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
%========================        EXTRAIR ENTRADAS       ========================
%===============================================================================
function entradas = extrairEntradasImg()

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

function entradas = extrairEntradasArq()
  arquivo = load('entradas.mat');
  entradas = arquivo.entradas;
endfunction

function salvarEntradas(entradas)
  save("-mat", "entradas.mat", "entradas");
endfunction


%===============================================================================
%========================       INICIALIZAR PESOS       ========================
%===============================================================================
function pesos = inicializarPesos(n)
  pesos = rand(n, 1);     #intervalo de 0 a 1
  pesos = pesos*2 - 1;                        #Ajuste do intervalo para -1 a 1

 endfunction


 function [W1, W2] = MatrizParaVetor(Mat, in, hiden, out)
  W1 = reshape(Mat(1:hiden*(in+1)), hiden, in+1);
  W2 = reshape(Mat(hiden*(in+1)+1:end), out, hiden+1);

 endfunction

%===============================================================================
%=====================       SALVAR E CARREGAR PESOS       =====================
%===============================================================================

function salvarPesos(W)
  save("-mat", "W.mat", "W");
 endfunction

 function W = carregarPesosArq()
  arquivo = load('W.mat');
  W = arquivo.W;
 endfunction

%===============================================================================
%========================           THRESHOLD           ========================
%===============================================================================

function img_bn = threshold(img_rgb, thresh)
  img_gray = rgb2gray(img_rgb);
  img_bn = im2double(img_gray);

  for i = 1:rows(img_bn)
    for j = 1:columns(img_bn)
      if img_bn(i, j) >= thresh
        img_bn(i, j) = 1;
      else
        img_bn(i, j) = 0;
      endif
   endfor
  endfor
 endfunction


 function determinar(img, W, tam_input, tam_hiden, tam_out)
  img_bn = threshold(img, 0.3);
  X = reshape(img_bn, numel(img_bn), 1);

  h = predicao(X, W, tam_input, tam_hiden, tam_out);

  [porcentagem, valor] = max(h);

  porcentagem = porcentagem*100;

  resultado = cstrcat("Este é o QRCODE para o número", " " , num2str(valor), ...
                      ", com", " ",  num2str(porcentagem), "% de acuracidade");

  plotar(img, resultado, h);
endfunction

%===============================================================================
%===================           MOSTRAR RESULTADOS           ====================
%===============================================================================

function plotar(img, resultado, y)

  figure(1, 'position', [100, 100, 1100, 550])

  subplot(1, 2, 1);
  image(img);             #para plotar a imagem
  pbaspect([1 1 1]);      #para controlar a escala das plotagens
  axis off;
  xlabel(resultado);

  subplot(1, 2, 2);
  x = 1:1:9
  bar(x, y);
  pbaspect([2 2 1])
  ylim([0, 1])
endfunction


%===============================================================================
%========================             SIGMOID           ========================
%===============================================================================
function g = sigmoid(z)
  g = 1 ./ (1 + e.^-z);
endfunction


%===============================================================================
%========================           PREDIÇÃO            ========================
%===============================================================================
function h = predicao(X, W, tam_input, tam_hiden, tam_out)

  [W1, W2] = MatrizParaVetor(W, tam_input, tam_hiden, tam_out);

  m = columns(X);

  X = [ones(1, columns(X)); X];   #Adicionando a camada de bias
  a1 = W1*X;                      #20x401*401x9
  z1 = sigmoid(a1);               #20x9

  a2 = [ones(1, columns(z1)); z1];#Adicionando a camada de bias
  z2 = W2*a2;                     #9x21*21x9
  h = sigmoid(z2);                #9x9

endfunction


%===============================================================================
%========================        FUNÇÃO DE CUSTO        ========================
%===============================================================================
 function [J] = funcaoCuto(y, h)
   m = columns(y);
   J = (1/m)*sum(sum((-y).*log(h)-(1-y).*log(1-h)));

endfunction


%===============================================================================
%========================           CALCULO             ========================
%===============================================================================
function J = calculo(W, X, y, tam_input, tam_hiden, tam_out)
  h = predicao(X, W, tam_input, tam_hiden, tam_out);
  J = funcaoCuto(y, h);
endfunction


%===============================================================================
%========================         TREINAMENTO           ========================
%===============================================================================
function W_new = treinamento(W_ini, X, y, tam_input, tam_hiden, tam_out)
  f = @(p) calculo(p, X, y, tam_input, tam_hiden, tam_out);
  [W_new] = fminunc(f, W_ini, optimset('MaxIter', 50));
endfunction



