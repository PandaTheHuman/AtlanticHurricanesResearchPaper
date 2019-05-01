M = load('co2_annmean_gl.txt'); % co2 levels in ppm
P = load('sea-surface-temp_fig-1.csv'); %SST anomaly in F
X = load('co2_gr_gl.txt'); %co2 growth rate in ppm/yr
%% 

%plot sea surface temp against co2 levels (ppm)
figure(1)
subplot(2,1,1)
plot(M(1:36,1),M(1:36,2))
subplot(2,1,2)
plot(P(101:136,1),P(101:136,2))
%% 

%plot sea surface temp agaist co2 increase (ppm/yr)
figure(2)
subplot(2,1,1)
plot(X(1:57,1),X(1:57,2))
subplot(2,1,2)
plot(P(80:136,1),P(80:136,2))
%% 
%plot of CO2 change
figure(3)
plot(X(1:57,1),X(1:57,2))
title('Rate of global atmospheric CO2 change')
xlabel('Year')
ylabel('CO2 growth rate (ppm/year)')
xlim([-inf inf])
%% double axis plot
yyaxis left
plot(X(1:57,1),X(1:57,2))
ylabel('CO2 growth rate (ppm/year)')
yyaxis right
plot(P(80:136,1),P(80:136,2))
ylabel('Temperature Anomaly (F)')
xlabel('Year')
xlim([-inf inf])
title('Global Atmospheric CO2 increase and SST Anomaly')
hold off
%% SST plot
%Pconv = ((P(:,2))-32)/1.8; <-- convert to celcius??
plot(P(80:136,1),P(80:136,2))
title('Global Sea-Surface Temperature anomaly')
xlabel('Year')
ylabel('Temperature Anomaly (F)')
xlim([-inf inf])
hold on
SSTzeros = zeros(57,1)
plot(P(80:136,1),SSTzeros)
gtext('1971-2000 average')
%% 
hurricanedata = load('hurricanedata3.csv'); %hurricane pressure centre by date
hdate = hurricanedata(:,1);
%convert the date values into useable format
convdate = datenum(num2str(hdate),'yyyymmdd');
hpres = hurricanedata(:,2);
scatter(convdate,hpres)
datetick
title('Pressure Centres of Tropical Cyclones in the Atlantic Basin from 1950 to 2016')
xlabel('Year')
ylabel('Minimum Pressure of Cyclone Centre (hPa)')
xlim([-inf inf])
%% hurricane pressure centres with lines for hurricate category
scatter(convdate,hpres)
datetick
title('Pressure Centres of Tropical Cyclones in the Atlantic Basin from 1950 to 2016')
xlabel('Year')
ylabel('Minimum Pressure of Cyclone Centre (hPa)')
xlim([-inf inf])
gtext('CATEGORY 1')
hold on
cat1line = zeros(size(convdate));
cat1line(:) = 980;
plot(convdate,cat1line,'-k')
gtext('CATEGORY 2')
hold on
cat2line = zeros(size(convdate));
cat2line(:) = 965;
plot(convdate,cat2line, '-k')
gtext('CATEGORY 3')
hold on
cat3line = zeros(size(convdate));
cat3line(:) = 945;
plot(convdate,cat3line, '-k')
gtext('CATEGORY 4')
hold on
cat4line = zeros(size(convdate));
cat4line(:) = 920;
plot(convdate,cat4line, '-k')
gtext('CATEGORY 5')
hold off
%% calculate avg pressure centre by year
vecdate = datevec(convdate);
hyear = vecdate(:,1);
HURDAT = zeros(67,5);
for i = 1:67
    HURDAT(i,1) = i+1949;
    HURDAT(i,2) = mean(hpres(find(hyear==(i+1949))));
    HURDAT(i,3) = std(hpres(find(hyear==(i+1949))));
    HURDAT(i,4) = max(hpres(find(hyear==(i+1949))));
    HURDAT(i,5) = min(hpres(find(hyear==(i+1949))));
end
plot(HURDAT(:,1),HURDAT(:,2))
xlim([1980 inf])
hold on
plot(HURDAT(:,1),(HURDAT(:,2)+HURDAT(:,3)))
hold on
plot(HURDAT(:,1),(HURDAT(:,2)-HURDAT(:,3)))
title('Mean Pressure Centres of Tropical Cyclones in the Atlantic Basin from 1950 to 2016')
xlabel('Year')
ylabel('Mean Pressure of Cyclone Centre (hPa)')
xlim([-inf inf])
legend('Mean - sd', 'Mean', 'Mean + sd', 'Location', 'southeast')
% hold on
% plot(HURDAT(:,1),HURDAT(:,4))
% hold on
% plot(HURDAT(:,1),HURDAT(:,5))
%% count how many category hurricanes based on Saffir-Simpson scale
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
% bar(HURCAT(:,1),HURCAT(:,8))
bar(HURCAT(:,1),[HURCAT(:,3) HURCAT(:,2)], 0.5, 'stack' )
title('Frequency of Category 4 and 5 pressure centres in the Atlantic Basin')
xlabel('Year')
ylabel('Frequency of Pressure Centres')
legend('Category 4', 'Category 5', 'Location', 'northeast')
hold off
% bar(HURCAT(:,1),HURCAT(:,3))
% hold on
% bar(HURCAT(:,1),HURCAT(:,4))
% hold on
% bar(HURCAT(:,1),HURCAT(:,5))
%% frequency stack chart w/ SST data
yyaxis left
bar(HURCAT(:,1),[HURCAT(:,3) HURCAT(:,2)], 0.5, 'stack' )
title('Frequency of Category 4 and 5 pressure centres in the Atlantic Basin with Global SST Anomaly')
xlabel('Year')
ylabel('Frequency of Pressure Centres')
yyaxis right
plot(P(80:136,1),P(80:136,2))
xlabel('Year')
ylabel('SST Anomaly (F)')
legend('Category 4', 'Category 5', 'SST Anomaly', 'Location', 'northwest')

%% 
    
% hmask2 = ( hpres > -998 & hpres < 950);
% scatter(convdate(hmask2),hpres(hmask2));
% datetick
% %% 
% %plot sea surface temp agaist co2 increase (ppm/yr) w hurricanes
% figure(4)
% subplot(4,1,1)
% plot(X(1:57,1),X(1:57,2))
% title("rate of CO2 increase")
% subplot(4,1,2)
% plot(P(80:136,1),P(80:136,2))
% title("SST anomaly")
% subplot(4,1,3)
% scatter(convdate(hmask2),hpres(hmask2))
% datetick
% title("cyclone intensity")
% subplot(4,1,4)
% plot(HURDAT(:,1),HURDAT(:,2))
% title("avg intensity")
% xlim([1960 inf])
%% 
%plot of hurricane frequency - US only, made landfall.
% figure(5)
% F = load('cyclones_fig-2csv.csv');
% scatter(F(:,1),F(:,2))
% xlim([1950 inf])
%% hurricane frequency - atlantic basin storm total
TT = load('named hurricanes.csv'); %hurricane/storm frequency - count by year
TTyear = TT(:,1); %year
TTTS = TT(:,2); %tropical storms
TTH = TT(:,3); %all hurricanes
TTMH = TT(:,4); %only major hurricanes
%sum all storms
TTsums = zeros(65,1);
for q = 1:65
    TTsums(q) = TTTS(q) + TTH(q) + TTMH(q);
end

yyaxis left
bar(TTyear, [TTTS TTH], 0.5, 'stack')
title('Frequency of Tropical Cyclones from 1950 to 2016')
xlabel('Year')
legend('Tropical Storms', 'Hurricanes', 'Location', 'northwest')
hold on
yyaxis right
plot(P(80:136,1),P(80:136,2))
ylabel('Temperature Anomaly (F)')
xlabel('Year')
% bar(TTyear,TTMH) %major hurricanes by year
% hold on
% plot(TTyear, TTH) %hurricanes by year
% hold on
% bar(TTyear,[TTTS TTH TTMH], 0.5, 'stack' )

% bar(TTyear,TTsums)
% xlabel('Year')
% ylabel('Frequency of Tropical Storms')
