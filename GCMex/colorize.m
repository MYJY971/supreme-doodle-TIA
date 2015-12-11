function [ imgSegColor ] = colorize( img, imgSeg )

imgSegColor = img;
[H,W,C]=size(img);


%In my implemention, background is always black
for h=1:H
    for w=1:W
        if(imgSeg(h,w)==0)
            imgSegColor(h,w,:)=0;
        end
    end
end

end

