function grabar = redimensionImagen(imagen)

    %Redimension de las imagenes
    Img = imread(imagen);

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

    if GrabarImagen == 1
        extension = imagen(1,[end-3:end]);
        imagen(:,[end-3:end]) = [];
        resize = 'face277x277';
        imagenW = [imagen,resize,extension];
        imwrite(I,imagenW);
    end
    grabar = GrabarImagen;
end

