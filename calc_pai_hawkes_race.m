function [fair, races, pai,concord,tot_cost,mu,lam,loglike,patrol,unique_x,unique_y,unique_race]=...
         calc_pai_hawkes_race(intercept,K0,w,x,y,t,geoid,race,theta,Nrank,unique_geoids,limi,endt)


M=max(size(unique_geoids));
pai=0;
tot_cost=0;

loglike=0;
w=exp(w);

patrol=zeros(3,1);

%simulation
templam = zeros(M, 1);
races = zeros(M, 3);
fair = zeros(3, 1);

u=zeros(M,1);

concord=zeros(1,1);
concord_count=0;

%limi = 14;
%limi = 365;
xt=x(t<limi);
yt=y(t<limi);
tt=t(t<limi);
gt=geoid(t<limi);

for i=1:max(size(xt))
    ix=gt(i);
    j=find(unique_geoids==ix);
    u(j)=u(j)+1;
end


mu=zeros(M,1);
unique_race=zeros(M,3);
unique_x=zeros(M,1);
unique_y=zeros(M,1);
for i=1:max(size(x))
    ix=geoid(i);
    j=find(unique_geoids==ix);
    %mu(j)=exp(intercept+theta(1)*race(i,1)+theta(2)*race(i,2)+theta(3)*race(i,3)+theta(4)*u(j));
    mu(j)=exp(intercept+theta(1)*0+theta(2)*0+theta(3)*0+theta(4)*u(j));
    unique_race(j,:)=race(i,:);
    unique_x(j)=x(i);
    unique_y(j)=y(i);
end


%for it=366:730
%endt = 26;
for it = limi:endt


    xt=x(t>(it-1)&t<=it);
    yt=y(t>(it-1)&t<=it);
    gt=geoid(t>(it-1)&t<=it);
    cst=zeros(M,1);


    for i=1:max(size(xt))
    ix=gt(i);
    j=find(unique_geoids==ix);
    cst(j)=cst(j)+1;
    end

    
    lam=mu;

        
    xt=x(t<(it-1));
    yt=y(t<(it-1));
    tt=t(t<(it-1));
    gt=geoid(t<(it-1));
    
    for i=1:max(size(xt))
        ix=gt(i);
        j=find(unique_geoids==ix);
        lam(j)=lam(j)+K0*w*exp(-w*((it-.5)-tt(i)));
    end
    
    templam = templam + lam;
        

    

  concord_count=concord_count+1;
  %concord=concord+corr(cst,lam,'type','Kendall');
  %concord=concord+corr(cst,lam,'type','Pearson');
  concord=concord+corr(cst,lam,'type','Spearman');
    
    loglike=loglike+sum(log(lam+.0000001).*cst)-sum(lam);
    
   [xs index]=sort(lam,'descend');
   ys=cst(index);
   
   %concord=concord+corr(ys,lam(index),'type','Kendall');
   
   for i=1:3
    patrol(i)=patrol(i)+(1/(endt-limi+1))*sum(unique_race(index(1:Nrank),i))/sum(unique_race(:,i));
   end
    
   for i = 1:3
       fair(i) = fair(i) + (1/(endt-limi+1))*ndcg(unique_race(index(1:Nrank), i),unique_race(index, i)); 
   end
   

   pai=pai+sum(ys(1:Nrank));

   
   %yout = randsample(cst,Nrank,true,lam);
   %yout = datasample(cst,Nrank,'Weights',lam,'Replace',false);
   %pai=pai+sum(yout);

   tot_cost=tot_cost+sum(cst);
    
end
unique_x=unique_x(index(1:Nrank));
unique_y=unique_y(index(1:Nrank));

concord=concord/concord_count;
pai=(pai/tot_cost)/((Nrank*300*300)/(950*1000*1000));

[xs index]=sort(templam,'descend');
for i = 1:M
    %for j = 1:M
        %if index(i) < j+1
            races(index(i),:) = [(M-i), 0, i];
        %elseif index(i) < 21
        %    races(i,:) = [8, 3, 10];
        %elseif index(i) < 31
        %    races(i,:) = [6, 3, 8];
        %elseif index(i) < 41
        %    races(i,:) = [4, 3, 6];
        %elseif index(i) < 51
        %    races(i,:) = [2, 3, 2];
        %else
        %    races(i,:) = [0, 3, 4];
        %end
    %end
end

end