function clasificarImagen(imagen,method)

    S1 = 'netTransferImage';
    S2 = method;
    S3 = '.mat';
    fichero = [S1,S2,S3];
    fichero = convertCharsToStrings(fichero);

    load(fichero);
    
    Img = imread(imagen);
    [YTestPred,probs] = classify(netTransfer,Img);

    imshow(Img)
    title(string(YTestPred) + ", " + num2str(100*max(probs),3) + "%");
end

