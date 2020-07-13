clear;clc;
%word='PortlandALL3000';
%word='RESCUE10000';
word='PortlandSTREET2000';
load(strcat(word,'.mat'));

w=-2;
K0=.8;
theta=[0 0 0 .1]';
intercept=-5;

vars=zeros(7,1);
vars(1)=intercept;
vars(2)=K0;
vars(3)=w;
vars(4:7)=theta;

Top =50;
%Top = 15;
%limi = 14;
%endt = 26;
limi = 200;
endt = 400;
loglikefun=@(vars)loglike_help(vars(1),vars(2),vars(3),x,y,t,geoid,race,vars(4:7),Top,unique_geoids,0,limi,endt);
%[vars,fval] = fminsearch(loglikefun,vars(1:7),optimset('TolX',1e-6,'MaxIter',100000000));
[vars,fval] = fminsearch(loglikefun,vars(1:7),optimset('TolX',1e-6,'MaxIter',5000));

intercept=vars(1);
K0=vars(2);
w=vars(3);
theta=vars(4:7);


[fari, races, pai15,concord,tot_cost,mu,lam,loglike,patrol,unique_x,unique_y,unique_race]=...
    calc_pai_hawkes_race(intercept,K0,w,x,y,t,geoid,race,theta,15,unique_geoids,limi,endt);

load(strcat(word,'.mat'));
raceold = race;
N = length(geoid);
race = zeros(N, 3);
for i = 1:N
    race(i,:) = races(find(geoid(i) == unique_geoids),:);
end
unique_race = races;
save(strcat(word, 'simu', int2str(limi), 'to', int2str(endt), '.mat'), 'x', 'y', 'unique_geoids', 't', 'race', 'geoid', 'raceold', 'unique_race');

%[pai50,concord,tot_cost,mu,lam,loglike,patrol,unique_x,unique_y,unique_race]=...
%    calc_pai_hawkes_race(intercept,K0,w,x,y,t,geoid,race,theta,50,unique_geoids,limi,endt);

%[pai100,concord,tot_cost,mu,lam,loglike,patrol,unique_x,unique_y,unique_race]=...
%    calc_pai_hawkes_race(intercept,K0,w,x,y,t,geoid,race,theta,100,unique_geoids,limi,endt);

%[pai200,concord,tot_cost,mu,lam,loglike,patrol,unique_x,unique_y,unique_race]=...
%    calc_pai_hawkes_race(intercept,K0,w,x,y,t,geoid,race,theta,200,unique_geoids,limi,endt);

%[pai25,concord,tot_cost,mu,lam,loglike,patrol,unique_x,unique_y,unique_race]=...
%    calc_pai_hawkes_race(intercept,K0,w,x,y,t,geoid,race,theta,25,unique_geoids,limi,endt);


%save(strcat(word,'_accuracy.mat'),'intercept','K0','w','theta','pai25','pai50',...
%                                  'pai100','pai200','mu','lam','loglike','patrol','concord');

