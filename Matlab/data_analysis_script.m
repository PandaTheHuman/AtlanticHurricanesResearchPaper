[num text all]=xlsread("final spreadsheetz.xls");
year = num(:,1);
SST = num(:,5);
CO2 = num(:,6);
cat5raw = num(:,2);
cat4raw = num(:,3);
sumraw = num(:,4);
majhur = num(:,9);
totalstorm = num(:,10);
adjusthurr = num(:,11);
SSTNOAA = num(:,12);
PDI = num(:,13);
SSTcel = num(:,14);
sumraw2 = num(:,15);
%% CO2 and SSTcel correlation

masknan = ((SSTcel ~= -999) & (CO2 ~= -999));
[R, p] = corrcoef(SSTcel(masknan),CO2(masknan));
X = [ones(size(CO2(masknan))) CO2(masknan)];
[coef,bint,r,rint,stats] = regress(SSTcel(masknan), X);
scatter(CO2(masknan), SSTcel(masknan))
hold on
SSTpred = X*coef
plot(CO2(masknan),SSTpred)
xlabel('atmospheric CO2 (ppm)')
ylabel('SST (C)')
gtext('slope = 0.0101 C/ppm')
gtext('R2 = 0.7310')
%% regression of SST OBSOLETE!!! using SSTcel instead
% masknan = (SST ~= -999)
% X = [ones(size(year(masknan))) year(masknan)];
% [coef,bint,r,rint,stats] = regress(SST(masknan), X);
% scatter(year(masknan),SST(masknan))
% hold on
% SSTpred = X*coef
% plot(year(masknan),SSTpred)
%% regression of sumraw OBSOLETE!!! using sumraw2 instead
% X = [ones(size(year)) year]
% [coef,bint,r,rint,stats] = regress(sumraw, X);
% plot(year, sumraw)
% hold on
% sumrawpred = X*coef
% plot(year,sumrawpred)

%% correlation SST and hurricanes RAW OBSOLETE - using sumraw2 instead
% masknan = (SSTcel ~= -999)
% X = [ones(size(SSTcel(masknan))) SSTcel(masknan)];
% [coef,bint,r,rint,stats] = regress(sumraw(masknan), X);
% scatter(SSTcel(masknan), sumraw(masknan))
% hold on
% sumrawpred = X*coef
% plot(SSTcel(masknan),sumrawpred)
% ylim([0 60])
% [R, p] = corrcoef(SSTcel(masknan),sumraw(masknan));
% %% correlation SST and hurricanes
% finalSST = SSTcel(2:64,1)
% Y = [ones(size(finalSST)) finalSST]
% [R, p] = corrcoef(finalSST,totalstorm(2:64,1));
% [R2, p2] = corrcoef(finalSST,majhur(2:64,1))
% %% plot adjusted hurricanes by year
% masknan = (adjusthurr > 0)
% plot(year(masknan),adjusthurr(masknan))
% %% plot SSTcel by year
% masknan = (SSTcel > 0)
% plot(year(masknan), SSTcel(masknan))
% %% corr SSTcel and hurradjusted
% masknan = ((SSTcel ~= -999) & (adjusthurr ~= -999));
% X = [ones(size(SSTcel(masknan))) SSTcel(masknan)];
% [coef,bint,r,rint,stats] = regress(adjusthurr(masknan), X);
% %% corr SSTcel and PDI
% masknan = ((SSTcel ~= -999) & (PDI ~= -999));
% X = [ones(size(SSTcel(masknan))) SSTcel(masknan)];
% [coef,bint,r,rint,stats] = regress(PDI(masknan), X);
%% plot CO2 by year
masknan = (CO2 > 0)
plot(year(masknan), CO2(masknan))
xlabel('Year')
ylabel('atmospheric CO2 (ppm)')
xlim([-inf inf])
hold on
X = [ones(size(year(masknan))) year(masknan)];
[coef,bint,r,rint,stats] = regress(CO2(masknan), X);
CO2pred = X*coef
plot(year(masknan),CO2pred)
gtext('slope = 1.5371 ppm/year')
gtext('R2 = 0.9852')
%% plot SST by year
masknan = (SSTcel > 0)
plot(year(masknan), SSTcel(masknan))
xlabel('Year')
ylabel('Sea Surface Temperature (C)')
xlim([-inf inf])
hold on
X = [ones(size(year(masknan))) year(masknan)];
[coef,bint,r,rint,stats] = regress(SSTcel(masknan), X);
SSTpred = X*coef
plot(year(masknan),SSTpred)
gtext('slope = 0.0098 C/year')
gtext('R2 = 0.4534')
%% %% plot PDI by year
masknan = (PDI > 0)
plot(year(masknan), PDI(masknan))
xlabel('Year')
ylabel('Power Dissipation Index')
xlim([-inf inf])
hold on
X = [ones(size(year(masknan))) year(masknan)];
[coef,bint,r,rint,stats] = regress(PDI(masknan), X);
PDIpred = X*coef
plot(year(masknan),PDIpred)
gtext('slope = 0.0243 per year')
gtext('R2 = 0.2000')

%% %% SSTcel and PDI correlation
masknan = ((PDI ~= -999) & ( SSTcel ~= -999));
[R, p] = corrcoef(PDI(masknan),SSTcel(masknan));
X = [ones(size(SSTcel(masknan))) SSTcel(masknan)];
[coef,bint,r,rint,stats] = regress(PDI(masknan), X);
scatter(SSTcel(masknan), PDI(masknan))
hold on
PDIpred = X*coef
plot(SSTcel(masknan),PDIpred)
xlabel('Sea Surface Temperature (C)')
ylabel('Power Dissipation Index')
ylim([1 6.5])
gtext('slope = 2.8749 per degree celsius')
gtext('R2 = 0.5993')

%% SST and sumraw2
masknan = ((sumraw2 ~= -999) & ( SSTcel ~= -999));
[R, p] = corrcoef(sumraw2(masknan),SSTcel(masknan));
X = [ones(size(SSTcel(masknan))) SSTcel(masknan)];
[coef,bint,r,rint,stats] = regress(sumraw2(masknan), X);
scatter(SSTcel(masknan), sumraw2(masknan))
hold on
sumraw2pred = X*coef
plot(SSTcel(masknan),sumraw2pred)
xlabel('Sea Surface Temperature (C)')
ylabel('Frequency of pressure centres classified as category 3, 4 or 5')
ylim([0 inf])
gtext('slope = 65.9401 per degree celsius')
gtext('R2 = 0.3729')
%% %% %% plot adjusthurr by year
masknan = (adjusthurr > 0)
plot(year(masknan), adjusthurr(masknan))
xlabel('Year')
ylabel('Total Hurricanes (adjusted)')
xlim([-inf inf])
% hold on
X = [ones(size(year(masknan))) year(masknan)];
[coef,bint,r,rint,stats] = regress(adjusthurr(masknan), X);
% adjusthurrpred = X*coef
% plot(year(masknan),adjusthurrpred)
% gtext('slope = 0.0243 per year')
% gtext('R2 = 0.2000')
%% plot SUMRAW2 by year
hurricanedata = load('hurricanedata3.csv'); %hurricane pressure centre by date
hdate = hurricanedata(:,1);
%convert the date values into useable format
convdate = datenum(num2str(hdate),'yyyymmdd');
hpres = hurricanedata(:,2);
vecdate = datevec(convdate);
hyear = vecdate(:,1);
cat1 = hpres > 980;
cat2 = (hpres <= 980) & (hpres >965);
cat3 = (hpres <= 965) & (hpres > 945);
cat4 = (hpres <= 945) & (hpres > 920);
cat5 = hpres <= 920;
HURCAT = zeros(67,9);
for j = 1:67
    HURCAT(j,1) = j+1949;
    HURCAT(j,2) = sum(cat5(find(hyear==(j+1949))));
    HURCAT(j,3) = sum(cat4(find(hyear==(j+1949))));
    HURCAT(j,4) = sum(cat3(find(hyear==(j+1949))));
    HURCAT(j,5) = sum(cat2(find(hyear==(j+1949))));
    HURCAT(j,6) = sum(cat1(find(hyear==(j+1949))));
    %sum of all hurricanes
    HURCAT(j,7) = sum(HURCAT(j,2:6))
    %sum of all cat 4+5
    HURCAT(j,8) = sum(HURCAT(j,2:3))
    %sum of all cat 3+4+5
    HURCAT(j,9) = sum(HURCAT(j,2:4))
end

masknan = (sumraw2 > -1)
bar(HURCAT(:,1),[HURCAT(:,4) HURCAT(:,3) HURCAT(:,2)], 0.5, 'stack' )
xlabel('Year')
ylabel('Frequency of pressure centres classified as category 3, 4 or 5')
legend('Cat 3 Hurricane','Cat 4 Hurricane', 'Cat 5 Hurricane', 'Location', 'northwest')
hold on
X = [ones(size(year(masknan))) year(masknan)];
[coef,bint,r,rint,stats] = regress(sumraw2(masknan), X);
sumraw2pred = X*coef
plot(year(masknan),sumraw2pred)
gtext('slope = 0.6782 per year')
gtext('R2 = 0.2171')
