function [ imgSeg ] = MYsegmentation( img, mask, lambda, sigma)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

%source image
imgSrc=img;

%We work with grayscale images
img=rgb2gray(img);
mask=rgb2gray(mask);


[height, width]=size(img);
sizeImg = height*width;


 %In the mask, each colors (except black) corresponds to a class
 %There are 256 possible values for a grayscale image ( [0;255] )
 nbClass=0;
 LabelColors = zeros(256,1);
 sizeClasses = zeros(256,1);

 %imhist gives us which color is used (the indice i where histogram(i)~=0),
 %we begin with i=2 because 1 is for black
 histo=imhist(mask);
 c=0;
 for i=2:256
     if(histo(i)~= 0)
         nbClass=nbClass+1;
         c=c+1;
         LabelColors(c)= i-1;
         sizeClasses(c)=histo(i);
     end
 end
 
 
 
 %We need to work with double but not in [0;1]
 img=double(img);
 mask=double(mask);
 

%get the histogram for each class
 for i=1:nbClass
     [histoClasse{i}]=getHistogram(img,mask,LabelColors(i));
     %normalize the histogram
     histoClasse{i}=histoClasse{i}/sizeClasses(i); 
 end
 

%initialize the parameters of GCMex
CLASS     = zeros(sizeImg, 1);
UNARY     = zeros(nbClass,sizeImg);
PAIRWISE  = sparse(sizeImg, sizeImg);
[X, Y]    = meshgrid(1:nbClass, 1:nbClass);
labelcost = min(4, (X - Y).*(X - Y));

epsilon = 0.00001; 

%Compute PAIRWISE to set the boundary penalties (4-connectivity)
%Compute UNARY to set regional penalties 
for row = 1:height
  for col = 1:width
    pixel = (row-1)*width + col;
    if row+1 <= height, PAIRWISE(pixel, (row-1+1)*width + col)   = lambda*exp(-(img(row,col) - img(row+1,col))^2/(2*sigma^2)); end
    if row-1 >  0, PAIRWISE(pixel, (row-1-1)*width + col)   = lambda*exp(-(img(row,col) - img(row-1,col))^2/(2*sigma^2)); end
    if col+1 <= width, PAIRWISE(pixel, (row-1)*width + (col+1)) = lambda*exp(-(img(row,col) - img(row,col+1))^2/(2*sigma^2)); end
    if col-1 >  0, PAIRWISE(pixel, (row-1)*width + (col-1)) = lambda*exp(-(img(row,col) - img(row,col-1))^2/(2*sigma^2)); end
    for c = 1:nbClass
            UNARY(c,pixel) = -log( histoClasse{c}(img(row,col)+1) + epsilon);
    end
  end
end



% Compute the GCMex library.
[labels, E, Eafter] = GCMex(CLASS, single(UNARY), PAIRWISE, single(labelcost),0);

%Use "labels" to build the segmented image
imgSeg = buildSegmentedImage(labels, width, height, nbClass);


end

