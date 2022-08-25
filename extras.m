extraspkg load image


img = imread("carro.jpg");
img = imresize(img, [100, 100]);
image(img);
imwrite(img, "img.jpg");

%=============================================
%TABELA

y_new = zeros(num_labels, m); % 10*5000
for i=1:m,
  y_new(y(i),i)=1;
end

%============================================
%INICIALIZAR PESOS ALEATORIAMENTE
function W = inicializarPesos(tam_entrada, tam_saida)

  W = zeros(tam_saida, tam_entrada + 1);
  W = rand(tam_saida, tam_entrada +1);
 end

