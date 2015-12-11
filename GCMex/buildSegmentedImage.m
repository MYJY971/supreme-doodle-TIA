function [ segImg ] = buildSegmentedImage( labels, W, H, nbClass )

%Give each class a color by normalizing [1;nbClass] into [0,255]
classColors = zeros(nbClass,1);

for i=1:nbClass
    classColors(i)= floor ( ( 255*i - 255)/(nbClass - 1) );
end

segImg = uint8(zeros(H, W));

%Build the segmented image
for row = 1:H
    for col = 1:W
        pixel  = (row-1)*W + col;
        for c = 1:nbClass
            if(labels(pixel) == c-1)
                segImg(row, col) = classColors(c);
            end
        end
    end
end


end

