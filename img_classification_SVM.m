clear all;


%read flower images and get histograms of each picture, store them in H_F.
%Flower images have label of 1
flower=[];
F_label=[];
label1=1;

j=1;
for i=257:365
    flower=imread(strcat('/Users/xuchuwen/Downloads/Lab4/Flower/0001',num2str(i),'.jpg'));
    h11=imhist(flower(:,:,1));
    h21=imhist(flower(:,:,2));
    h31=imhist(flower(:,:,3));
    
    %normalize
    H11=h11/norm(h11);
    H21=h21/norm(h21);
    H31=h31/norm(h31);
    H_F{j,:}=[H11 H21 H31]; 
    F_label=[F_label;label1];
    j=j+1;
end



%read airplane images and get histograms of each picture, store them in H_A.
%Flower images have label of 0
airplane=[];
A_label=[];
label2=0;

k=1;
for m=823:922
    airplane=imread(strcat('/Users/xuchuwen/Downloads/Lab4/Airplane/0000',num2str(m),'.jpg'));
    h12=imhist(airplane(:,:,1));
    h22=imhist(airplane(:,:,2));
    h32=imhist(airplane(:,:,3));
    
    %normalize
    H12=h12/norm(h12);
    H22=h22/norm(h22);
    H32=h32/norm(h32);
    
    H_A{k,:}=[H12 H22 H32]; 
    A_label=[A_label;label2];
    k=k+1;
end


Data=[H_F;H_A];
Label=[F_label;A_label];


%select train samples randomly
randnum=randperm(length(Data));
train_add=randnum(1:105);
train=Data(train_add);
Train=[];
for x=1:105
    Tr=cell2mat(train(x));
    Train=[Train;Tr];
end

%get train data's label
train_l=Label(train_add);
train_Label=[];
for a=1:105
    for b=1:256
        train_L=train_l(a);
        train_Label=[train_Label;train_L];
    end
end

%get test samples and their label
test_add=randnum(106:209);
test=Data(test_add,:);
Test=[];
for y=1:104
    Te=cell2mat(test(y));
    Test=[Test;Te];
end

test_l=Label(test_add);
test_Label=[];
for a=1:104
    for b=1:256
        test_L=test_l(a);
        test_Label=[test_Label;test_L];
    end
end


%generate svmstruct
S=svmtrain(Train,train_Label);
%classification of test
G1=svmclassify(S,Test);
%hold on;

Test_error=[];
Ecount_test=0;
error=G1-test_Label;
for i=1:size(error)
    if error(i)~=0
       Ecount_test=Ecount_test+1;
    end
end
Ecount_test
TEST_ERROR_RATE=Ecount_test/104


%figure;
%generate svmstruct
S=svmtrain(Train,train_Label);
%classification of train
G2=svmclassify(S,Train);

Train_error=[];
Ecount_train=0;
error=G2-train_Label;
for i=1:size(error)
    if error(i)~=0
       Ecount_train=Ecount_train+1;
    end
end
Ecount_train
TRAIN_ERROR_RATE=Ecount_train/105



%boxconstrain
%
figure;
%generate svmstruct
S3=svmtrain(Train,train_Label,'boxconstraint',1);
G3=svmclassify(S3,Test);

Test_error2=[];
Ecount_test2=0;
error=G3-test_Label;
for i=1:size(error)
    if error(i)~=0
       Ecount_test2=Ecount_test2+1;
    end
end
Ecount_test2
TEST_ERROR_RATE2=Ecount_test2/104



