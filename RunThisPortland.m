clear;clc;

%ReadData

%HawkesExampleSimu
delete temp.mat
HawkesExample
delete temp.mat
for i = 1:7
    Trade = [1e2, 1e4, 1e5, 1e6, 1e7, 1e8, 1e10];
    Inde = [2, 4, 5, 6, 7, 8, 10];
    TradeTemp = Trade(:,i);
    IndeTemp = Inde(:,i);
    HawkesExample50
    %clear;clc;
    clear c
    load('temp.mat');
    IndeTemp = Inde(:,i);
    save(strcat(int2str(IndeTemp),'temp.mat'),'c');
    delete temp.mat
end
for i = 1:7
    Trade = [1e2, 1e4, 1e5, 1e6, 1e7, 1e8, 1e10];
    Inde = [2, 4, 5, 6, 7, 8, 10];
    %clear;clc;
    TradeTemp = Trade(:,i);
    IndeTemp = Inde(:,i);
    mHawkesExample50
    delete temp.mat
    %clear;clc;
    %load('temp.mat');
    %IndeTemp = Inde(i);
    %save(strcat(IndeTemp,'temp.mat'),'c');
end