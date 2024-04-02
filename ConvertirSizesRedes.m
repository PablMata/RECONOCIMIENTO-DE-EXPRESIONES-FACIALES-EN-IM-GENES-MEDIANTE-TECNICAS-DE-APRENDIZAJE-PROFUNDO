
%% Redimensionado de las imágenes
% Dimensión: 227x227x3: AlexNet, squeezenet

clear all; close all;

cd 'F:\Pablo\Documentos\MATLAB\TFG'
imds = imageDatastore('Imagenes por expresión',...
    'IncludeSubfolders',true,...
    'LabelSource','foldernames');

idx = size(imds.Files,1);

for i=1:1:idx
  D = cell2mat(imds.Files(i));
  Img = imread(D);


  % Variable para controlar si se graba o no la imagen que se está
  % procesando
  GrabarImagen = 1;

  %% Detectar la cara completa, eliminando el resto de partes de la imagen
  % Create a cascade detector object.
  faceDetector = vision.CascadeObjectDetector('FrontalFaceCART');
  bbox = step(faceDetector, Img);
  if isempty(bbox)
    GrabarImagen = 0;
  else
    % Convert the first box into a list of 4 points
    % This is needed to be able to visualize the rotation of the object.
    bboxPoints = bbox2points(bbox(1, :));

    % Draw the returned bounding box around the detected face.
    videoFrame = insertShape(Img, "rectangle", bbox);
    figure(1); imshow(videoFrame); title("Detected face"); impixelinfo

    RecorteImg = Img(bboxPoints(1,1):bboxPoints(2,1),bboxPoints(1,2):bboxPoints(4,2),:);
    I = imresize(RecorteImg, [227 227]);
  end
      
  [a,b] = find(D =='\');

  S1 = D(1:b(5));

  S2 = 'DATASET227x227';

  S3 = D(b(6):size(D,2));
  fichero = [S1,S2,S3];
  if GrabarImagen == 1
    imwrite(I,fichero);
  end
end
