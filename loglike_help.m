function loglike=loglike_help(intercept,K0,w,x,y,t,geoid,race,theta,Nrank,unique_geoids,chi,limi,endt)

[fair, races, pai,concord,tot_cost,mu,lam,loglike,patrol,unique_x,unique_y,unique_race]=...
         calc_pai_hawkes_race(intercept,K0,w,x,y,t,geoid,race,theta,Nrank,unique_geoids,limi,endt);
 loglike=-loglike;
 %loglike=loglike+(patrol(1)-patrol(2))^2*chi;
 %loglike=loglike+(patrol(3)-patrol(2))^2*chi;
 %loglike=loglike+(patrol(1)-patrol(3))^2*chi;
 %%loglike=loglike+(fair(1)-fair(2))^2*chi;
 %%loglike=loglike+(fair(3)-fair(2))^2*chi;
 loglike=loglike+(fair(1)-fair(3))^2*chi;
 loglike
 [K0 w theta' intercept pai fair' concord]
 
 %t = [loglike pai abs(fair(1)-fair(3)) concord];
 t = [loglike pai abs(fair(1)-fair(3)) concord];
 if(~exist('temp.mat'))
    c = [loglike pai abs(fair(1)-fair(3)) concord];
    save('temp.mat','c');
 else
    load('temp.mat');
    x = [c;t];
    c = x;
    save('temp.mat','c');
end