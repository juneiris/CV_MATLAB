%kmean function
%N is the number of cluster
%data is input data 
%u is the center of each cluster
%re is data with label 

function [u re]=KMeans(data,N)   
    [m n]=size(data);   
    ma=zeros(n);        
    mi=zeros(n);        
    u=zeros(N,n);       
    for j=1:n
       ma(j)=max(data(:,j));    
       mi(j)=min(data(:,j));   
       for i=1:N
            u(i,j)=ma(j)+(mi(j)-ma(j))*rand();  %initialization
       end      
    end
   
    while 1
        pre_u=u;            %store u
        for i=1:N
            tmp{i}=[];      % Xi-uj
            for j=1:m
                tmp{i}=[tmp{i};data(j,:)-u(i,:)];
            end
        end
        
        R=zeros(m,N);
        for i=1:m        %equation J
            c=[];
            for j=1:N
                c=[c norm(tmp{j}(i,:))];
            end
            [C index]=min(c);
            R(i,index)=norm(tmp{index}(i,:));           
        end
        
        for i=1:N            %equation Uk
           for j=1:n
                u(i,j)=sum(R(:,i).*data(:,j))/sum(R(:,i));
           end           
        end
        
        if norm(pre_u-u)<0.1  %iteration until no change
            break;
        end
    end
    
    re=[];
    for i=1:m
        tmp=[];
        for j=1:N
            tmp=[tmp norm(data(i,:)-u(j,:))];
        end
        [C index]=min(tmp);
        re=[re;data(i,:) index];
    end
    
end