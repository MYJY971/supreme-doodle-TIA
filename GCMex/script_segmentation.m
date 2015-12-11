%MOUNSAMY Yanis M2 ISV

%%% Segmentation %%%

%% 2 classes
%Simple case
src1=imread('images/A.png');
mask1=imread('images/A_mask.png');
segImg1 = MYsegmentation(src1, mask1, 10, 10);
imwrite(segImg1, 'images/A_segmented.png') 

figure();
subplot(2,1,1);
imshow(src1);
subplot(2,1,2);
imshow(segImg1);
drawnow;

%complex case
src2=imread('images/lion.png');
mask2=imread('images/lion_mask.png');
segImg2 = MYsegmentation(src2,mask2,100,20);
imwrite(segImg2, 'images/lion_segmented.png') 

figure();
subplot(2,1,1);
imshow(src2);
subplot(2,1,2);
imshow(segImg2);
drawnow;

%With the same color of the source image
segImg2b = colorize(src2,segImg2);
imwrite(segImg2b, 'images/lion_segmented2.png') 

figure();
subplot(2,1,1);
imshow(src2);
subplot(2,1,2);
imshow(segImg2b);
drawnow;

%% 3 classes
src3=imread('images/multihorde.png');
mask3=imread('images/multihorde_mask.png');
segImg3 = MYsegmentation(src3,mask3,30,20);
imwrite(segImg3, 'images/multihorde_segmented.png') 

figure();
subplot(2,1,1);
imshow(src3);
subplot(2,1,2);
imshow(segImg3);
drawnow;

