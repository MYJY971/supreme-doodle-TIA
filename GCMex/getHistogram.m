function [ histogramClass] = getHistogram( img, mask, color)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
[height,width]=size(img);
sizeImg = height*width;

histogramClass = zeros(256,1);

for i=1:sizeImg
    if(mask(i)==color)
        histogramClass(img(i)+1)=histogramClass(img(i)+1)+1;
    end
end

end

