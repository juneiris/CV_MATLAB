clear all;
[I1,map]=imread('/Users/xuchuwen/Downloads/CV_Lab3/boy1.png');
figure;
subplot(1,2,1),imshow(I1)
A=double(reshape(I1,size(I1,1)*size(I1,2),size(I1,3)));


%do clustering to the first image
N1=5;
[cla,cen]=kmeans(A,N1);
for i=1:N1
     index=find(cla==i);
     for j=1:size(index)
         A(index(j),:)=cen(i,:);
     end
     
end

I_r1=uint8(reshape(A,size(I1,1),size(I1,2),size(I1,3)));
subplot(1,2,2),imshow(I_r1,map);
title('boy1 clustering with matlan kmeans function')



I2=imread('/Users/xuchuwen/Downloads/CV_Lab3/boy2.png');
B=double(reshape(I2,size(I2,1)*size(I2,2),size(I2,3)));
figure;
subplot(1,2,1),imshow(I2)
B=double(reshape(I2,size(I2,1)*size(I2,2),size(I2,3)));

%do clustering to the second image
N2=15;
[cla,cen]=kmeans(B,N2);
for i=1:N2
     index=find(cla==i);
     for j=1:size(index)
         B(index(j),:)=cen(i,:);
     end
     
end
I_r2=uint8(reshape(B,size(I2,1),size(I2,2),size(I2,3)));
subplot(1,2,2),imshow(I_r2,map);
title('boy2 clustering with matlan kmeans function')
