clear all;
img=imread('/Users/xuchuwen/Downloads/CV_Lab3/Violin.jpg');
figure;imshow(img)
figure;imhist(img)
disp('there are four peaks, corresponding to the gray background,the body of the violin,string and the darkest handle')
thres_1=60;
thres_2=140;
A=img;
B=img;
C=img;
for i=1:size(img,1)
    for j=1:size(img,2)
        if img(i,j)<60
           A(i,j)=255;
        else
           A(i,j)=0;
            
        end
        if ( img(i,j)<60 )
           B(i,j)=0;
        else if img(i,j)>140
                B(i,j)=0;
            else
                B(i,j)=255;
            end
            
        end
        if img(i,j)>140
           C(i,j)=255;
        else
           C(i,j)=0;
            
        end
    end
    end
figure;
subplot(1,3,1),imshow(A)
subplot(1,3,2),imshow(B)
subplot(1,3,3),imshow(C)


%Otsu' method
level=graythresh(img);
BW=im2bw(img,level);
figure,imshow(BW)



