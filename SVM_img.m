clear all;


%read flower images and get histograms of each picture, store them in H_F.
%Flower images have label of 1
flower=[];
F_label=[];
label1=1;
H_F=[];
for i=257:365
    flower=imread(strcat('/Users/xuchuwen/Downloads/Lab4/Flower/0001',num2str(i),'.jpg'));
    h11=imhist(flower(:,:,1));
    h21=imhist(flower(:,:,2));
    h31=imhist(flower(:,:,3));
    
    %normalize
    H11=h11/norm(h11);
    H21=h21/norm(h21);
    H31=h31/norm(h31);
    H1=[H11;H21;H31];
    H_F=[H_F H1];
       
    F_label=[F_label;label1];
end



%read airplane images and get histograms of each picture, store them in H_A.
%Flower images have label of 0
airplane=[];
A_label=[];
label2=0;
H_A=[];

for m=823:922
    airplane=imread(strcat('/Users/xuchuwen/Downloads/Lab4/Airplane/0000',num2str(m),'.jpg'));
    h12=imhist(airplane(:,:,1));
    h22=imhist(airplane(:,:,2));
    h32=imhist(airplane(:,:,3));
    
    %normalize
    H12=h12/norm(h12);
    H22=h22/norm(h22);
    H32=h32/norm(h32); 
    H2=[H12;H22;H32];
    H_A=[H_A H2];
    
    A_label=[A_label;label2];
end


H=[H_F H_A];
Data=H';
Label=[F_label;A_label];


%select train samples randomly
randnum=randperm(size(Data,1));
train_add=randnum(1:105);
train=Data(train_add,:);

%get train data's label
train_l=Label(train_add);

%get test samples and their label
test_add=randnum(106:209);
test=Data(test_add,:);
test_l=Label(test_add);



%generate svmstruct
S=svmtrain(train,train_l);
%classification of test
G1=svmclassify(S,test);
%hold on;
% 
Test_error=[];
Ecount_test=0;
error=G1-test_l;
for i=1:size(error)
    if error(i)~=0
       Ecount_test=Ecount_test+1;
    end
end
Ecount_test
TEST_ERROR_RATE=Ecount_test/104
Test_Acuuracy=1-TEST_ERROR_RATE

%generate svmstruct
S=svmtrain(train,train_l);
%classification of train
G2=svmclassify(S,train);

Train_error=[];
Ecount_train=0;
error=G2-train_l;
for i=1:size(error)
    if error(i)~=0
       Ecount_train=Ecount_train+1;
    end
end
Ecount_train
TRAIN_ERROR_RATE=Ecount_train/105
Train_Acuuracy=1-TRAIN_ERROR_RATE



%boxconstrain
%
% %generate svmstruct
% S3=svmtrain(train,train_l,'boxconstraint',5);
% G3=svmclassify(S3,test);
% 
% Test_error_boxconstraint=[];
% Ecount_test_boxconstraint=0;
% error=G3-test_l;
% for i=1:size(error)
%     if error(i)~=0
%        Ecount_test_boxconstraint=Ecount_test_boxconstraint+1;
%     end
% end
% Ecount_test_boxconstraint
% TEST_ERROR_RATE2=Ecount_test_boxconstraint/104;
% box_constraint_accuracy=1-TEST_ERROR_RATE2



