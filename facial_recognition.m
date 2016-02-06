samples=[];

for i=1:40
    for j=1:5
        a=imread(strcat('/Users/xuchuwen/Downloads/Day2matlab/ORL/s',num2str(i),'/',num2str(j),'.pgm'));
        %figure,imshow(a)
        [x,y]=size(a);
        b=a(1:x*y);
        b=double(b);
        samples=[samples;b];
    end
end


smean=mean(samples); %average image
mean_img=reshape(smean,x,y);
img=mat2gray(mean_img);
figure,imshow(img)

for i=1:200
    xdiff(i,:)=samples(i,:)-smean;  %difference between average and each image
end



covx=xdiff*xdiff'; %covariance matrix
[v,d]=eig(covx);
d1=diag(d);        %eigenvalue

[d1,ix]=sort(d1,'descend');%descend order for eigenvalues
figure,plot(d1,'x')
title('descending order of eigenvalues')

v1=v(:,ix(:));  %corresponding eigenvectors



Acc=[];

for s=1:5:200
    s
    %s=200;

    v_us=v1(:,1:s);
    v_u=xdiff'*v_us;
    clear v_un;
    for n=1:s
        v_un(:,n)=v_u(:,n)/norm(v_u(:,n));
    end
    size(v_un)
    
    u=v_un;
    [eh,ew]=size(u);

     pca=u'*xdiff';
 
     %get the mean of every five imagesm
%      m_label=[];
%      m_li=1;
     m=[];
     for I=1:5:size(pca,2)
         mi=mean(pca(:,I:(I+4)),2);
         m=[m mi];
%          m_label=[m_label m_li];
%          m_li=m_li+1;
     end


% u=v_u(:,1:30);
% u=u';
%pca=u'*xdiff';
% 

    test=[];
    test_label=[];
    test_l=1;
    for i=1:40
        for j=6:10
            at=imread(strcat('/Users/xuchuwen/Downloads/Day2matlab/ORL/s',num2str(i),'/',num2str(j),'.pgm'));
            bt=at(1:10304);
            bt=double(bt);
            test=[test;bt];
            test_label=[test_label test_l];
        end
        test_l=test_l+1;
    end

    test_img=test-repmat(smean,200,1);
    pca_test=u'*test_img';


% get result
    result_label=[];
    for i=1:size(pca_test,2)
        for j=1:size(m,2)
            distance(:,j)=norm(pca_test(:,i)-m(:,j));
        end
        [class_test,class_index]=min(distance);
        result_label=[result_label class_index];
  
    end

%check if the image is classified correctly
    Acc_count=0;
    C=test_label-result_label;
    for i=1:size(C,2)
        if(C(i)==0)
            Acc_count=Acc_count+1;
        else
      
        end
        
    end

    Accuracy=Acc_count/200
    Acc=[Acc Accuracy];

end
figure;plot(Acc,'o')
figure;
for k=1:25
    im=reshape(u(:,k),x,y);
    eimg=mat2gray(im);
    subplot(5,5,k)
    imshow(eimg)
end    
    
