I=vl_impattern('roofs1');
image(I);
I=single(rgb2gray(I));
[f,d]=vl_sift(I);

perm=randperm(size(f,2));
sel =perm(1:50);
h1=v1_plotframe(f(:,sel));
h2=v1_plotframe(f(:,sel));
set(h1,'color','k','linewidth',3);
set(h2,'color','y','linewidth',2);
image(h1)