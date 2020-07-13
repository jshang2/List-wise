clear;clc;
addpath(genpath(pwd));

word='PortlandSTREET'; % PAI PASDA 86.95683693 TAMERZONE 83.94753617
%word='PortlandALL'; % PAI Codilime 60.52651667	PASDA 58.80171595	TAMERZONE 59.1736587

data = fopen('data/portland_street.csv', 'rt');
%data = fopen('data/portland_all.csv', 'rt');
a = textscan(data, '%s %f %f %s', ...
      'Delimiter',',', 'HeaderLines',1);
fclose(data);

rng(1);

date=a{1};
lat=a{2};
long=a{3};
type=a{4};


[~,~,new_type] = unique(type,'stable');
%cell_size=76.2;
cell_size = 2000;

date_num=datenum(date);
[year, mnth, day, hr, mn, sec]=datevec(date_num);
date_mnth=mnth;
date_day=day;

latmax=max(lat);
latmin=min(lat);
longmax=max(long);
longmin=min(long);


train_start_date=datenum('03/01/2012');
train_end_date=datenum('05/31/2017');

[cell_polygons, geo_id]=assing_geoid(latmax, latmin, longmax, longmin, cell_size,date_num,lat,long);

N = length(date_num);
ranlist = floor(3*rand(N,1));
raceb = zeros(N, 1);
raceb(find(ranlist==0),:) = 1;
racew = zeros(N, 1);
racew(find(ranlist==1),:) = 1;
raceh = zeros(N, 1);
raceh(find(ranlist==2),:) = 1;

mint = floor(min(date_num));
date_num = date_num-mint+1;

c=[lat long date_num raceb racew raceh geo_id];


x = c(:,1);
y = c(:,2);
%time = datetime(data(:,1),data(:,2),data(:,3),data(:,4),0,0);
%t = datenum(time);
t = c(:,3);
%mint = floor(min(t));
%t = t-mint+1;

race=c(:,4:6);
geoid=c(:,7);


unique_geoids=unique(geoid);
save(strcat(word,num2str(cell_size),'.mat'),'x','y','t','race','geoid', 'unique_geoids');