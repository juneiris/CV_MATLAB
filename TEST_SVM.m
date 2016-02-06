clear all
A=load('/Users/xuchuwen/Downloads/Lab4/learn_svm.mat');
Data=A.X;
Label=A.Y;

%select train samples randomly
randnum=randperm(length(Data));
train_add=randnum(1:75);
train=Data(train_add,:);

%get train data's label
train_l=Label(train_add);

%get test samples and their label
test_add=randnum(76:150);
test=Data(test_add,:);
test_l=Label(test_add);

figure;
%generate svmstruct
S=svmtrain(train,train_l,'showplot',true);
%classification of test
G1=svmclassify(S,test,'showplot',true);
hold on;





Test_error=[];
Ecount_test=0;
error=G1-test_l;
for i=1:size(error)
    if error(i)~=0
       Ecount_test=Ecount_test+1;
    end
end
Ecount_test
TEST_ERROR_RATE=Ecount_test/75


figure;
%generate svmstruct
S=svmtrain(train,train_l,'showplot',true);
%classification of train
G2=svmclassify(S,train,'showplot',true);

Train_error=[];
Ecount_train=0;
error=G2-train_l;
for i=1:size(error)
    if error(i)~=0
       Ecount_train=Ecount_train+1;
    end
end
Ecount_train
TRAIN_ERROR_RATE=Ecount_train/75



%boxconstrain
figure;
%generate svmstruct
S3=svmtrain(train,train_l,'boxconstraint',100,'showplot',true);
G3=svmclassify(S3,test,'showplot',true);
