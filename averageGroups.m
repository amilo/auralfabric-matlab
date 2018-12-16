% this will create a variable called "sensor"
%SUF='e';
% group1 = [101:105];

group1 = [112:115,117:119,122,126,130];%keymap red
group3 = [106:111,124,125,127,128];%ambiguous keymap blue
group2 = [101:105, 116,120,121,123,130]; %no keymap green

groupArray = [group1,group2,group3];
groupArray

count = zeros(3000,1,length(SUF));
timeArray =[];
%function averageGroups(groupArray)
%%
clf
index=0;
%ARR = ['a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s'];
sumVector=[];
%for subgroup = 1:3
    
for SUF = groupArray%[subgroup] %SUF
    SUF = num2str(SUF);
    index=index+1;


run(['sensorLog18Rev_' SUF '.m'])

filename = ['audio_' SUF '.bin'];
numChannels = 2;
Fs = 44100;

sensorMax = 255;
numSensors = 18;
timestampColumn = 19;


limit = 0.0;

 fid=fopen([filename],'r');

 %offset = 4739824; %samples
 %str='alignTime_' SUF ;
 
 offset = alignTime;
 %offset = x;
 offsetOfBytes = offset*4*numChannels;
   
 
  %audio = fread(fid, 'float');
  % audio = fread(fid, 'float');
   
  audio = fseek(fid,offsetOfBytes,'bof');
  audio = fread(fid, 'float');
  %position = ftell(fid)
 fclose(fid);
 %audio = vec2mat(audio, numChannels);
 audioMat = vec2mat(audio, numChannels);
%sound(audioMat,Fs);


 %25 columns. 1-24 are sensors and 25 is timestamp ( in samples)

s = sensor(:,1:numSensors) / sensorMax; % this is to have it from 0 to 1

T = sensor(1:3000,timestampColumn) / Fs;

activated = gt(sensor(:,1:numSensors),0) ; % matrix of 0 and 1 for each column (sensor)
%transposing the matrix would create rows for sensors and columns for data
%points.
% this would eventually lead to create a column vector having as rows the
% sensors

   sumVector(index,:) = sum(activated,1); 
   %sumVector(index,:,subgroup) = sum(activated,1); 
  % t = activated(j);
    %sumVector(1,j) = sum(t);
    
        
%sumVector

vector=zeros(2,3,2);
vector(1,3,)=56;
vector


for x=1:3
    for c=1:2
        patate(x,c)=gt(activated(x,c),0);
    end
    count=sum(activated,2);
    sumSuf(x,cound,index)

for x = 1:3000
    for c = 1 : numSensors
 %for x = 1:length(T)
     activated (x,c)= gt(activated(x,c),0); %%fill a matrix called activated with time in rows and ones if sensor is present
     %
    end
    count=sum(activated,2);
     %sumSuf(x,count,index)=
end
 
%sumSuf= sum(activated,2);
     
     
 
%count=sum(activated,2);
%size(count)



end
%end
%%
sumVector
%%
count = 0;

for c = 1 : numSensors
         
    
 for x = 1:length(T)
   
   
     activated (x,c)= gt(activated(x,c),0);
     
     
     end
     
    
     
 end

 
% count=sum(activated,2);
% size(count)
%this plots the number of counts for each participants across time
%in order to compare them across time the Matric of time needs to be
%consistent. It makes sense to trim it after 5 minutes which in sensor time
%should be 60*5*samplingRate of sensors, which is 10 Hz - 3000 samples


%%

audioTime = (0:size(audioMat,1)-1) / Fs;


%  M = mean(sumVector/length(T));
%   M1 = mean(sumVector[1:5]/length(T));
%    M2 = mean(sumVector[6:10]/length(T)); 
%    M3 = mean(sumVector[11:15]/length(T));

 %size(S)
 %length(S)
 

 %figure
 %%
 clf
 audioTime = (0:size(audioMat,1)-1) / Fs;
 count=sum(activated,2);
size(count)
 h = plot(audioTime(1:10:end), audioMat(1:10:end,2), T, count,  '.-');
 
 
 %% 
 
 clf
 audioTime = (0:size(audioMat,1)-1) / Fs;
%boxplot(sumVector/length(T),'Color','r','BoxStyle','outline');
  boxplot(sumVector(1:10,:)/length(T),'Color','r','BoxStyle','outline');
 hold on 
  boxplot(sumVector(11:20,:)/length(T),'Color','b','BoxStyle','outline');
 boxplot(sumVector(21:30,:)/length(T),'Color',[0.3,0.8,0.3],'BoxStyle','outline')
 boxplot(sumVector/length(T),'Color','k', 'BoxStyle','filled');
  grid on
 
 ax2 = gca;
 ax2.YLim = [0,0.3];
 ax2.YTick = 0:0.1:0.3;
 ax2.YLabel.String= 'Time Spent / Overall Time';
 %ax2.YTickLabels = {'0','30','60','90','120','150','180','210'};
 ax2.XTick = [ 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18];
 ax2.XTickLabels = {'Fountain ','Trinity K.C.C.','Green Wat','Q.Anne C.','Painted H.','Chapel Entr.','Undercr.','Q. Mary C.','K.William C.','K. W. Green','Market S.','Turnpin Lane','Market N.','Market St.','Cutty S.', 'Waterside' , 'Piers', 'Water'};
%ax2.XTickLabels.FontSize = 10;
%ax2.XLabel= 'Locations';
  hold off
%end

%%

%  boxplot(sumVector(1:5,:)/length(T),'Color','r','BoxStyle','outline');
%  hold on 
%  boxplot(sumVector(6:11,:)/length(T),'Color','b','BoxStyle','outline');
% boxplot(sumVector(12:15,:)/length(T),'Color',[0.3,0.8,0.3],'BoxStyle','outline')
% boxplot(sumVector/length(T),'Color','k', 'BoxStyle','filled');
%   grid on
%  
%  ax2 = gca;
%  ax2.YLim = [0,0.3];
%  ax2.YTick = 0:0.1:0.3;
%  ax2.YLabel.String= 'Time percentage';
%  %ax2.YTickLabels = {'0','30','60','90','120','150','180','210'};
%  ax2.XTick = [ 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18];
%  ax2.XTickLabels = {'Fountain ','Trinity K.C.C.','Green Wat','Q.Anne C.','Painted H.','Chapel Entr.','Undercr.','Q. Mary C.','K.William C.','K. W. Green','Market S.','Turnpin Lane','Market N.','Market St.','Cutty S.', 'Waterside' , 'Piers', 'Water'};
% %ax2.XTickLabels.FontSize = 10;
% %ax2.XLabel= 'Locations';
%   hold off
 
 
 subplot(3,1,1)
 boxplot(sumVector(1:10,:)/length(T),'Color','r','BoxStyle','outline');
 hold on 
 boxplot(sumVector/length(T),'Color','k', 'BoxStyle','filled');
 title('keymap');
 grid on
  %hold off
 ax2 = gca;
 ax2.YLim = [0,0.3];
 ax2.YTick = 0:0.1:0.3;
 ax2.YLabel.String= 'Time Spent / Overall Time';
 %ax2.YTickLabels = {'0','30','60','90','120','150','180','210'};
 ax2.XTick = [ 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18];
 ax2.XTickLabels = {'Fountain ','Trinity K.C.C.','Green Wat','Q.Anne C.','Painted H.','Chapel Entr.','Undercr.','Q. Mary C.','K.William C.','K. W. Green','Market S.','Turnpin Lane','Market N.','Market St.','Cutty S.', 'Waterside' , 'Piers', 'Water'};
%ax2.XTickLabels.FontSize = 10;
%ax2.XLabel= 'Locations';
  hold off
  
  subplot(3,1,2)
 boxplot(sumVector(11:20,:)/length(T),'Color','b','BoxStyle','outline');
hold on
 boxplot(sumVector/length(T),'Color','k', 'BoxStyle','filled');
 title('ambiguous keymap');
   grid on
  %hold off
 ax2 = gca;
 ax2.YLim = [0,0.3];
 ax2.YTick = 0:0.1:0.3;
 ax2.YLabel.String= 'Time Spent / Overall Time';
 %ax2.YTickLabels = {'0','30','60','90','120','150','180','210'};
 ax2.XTick = [ 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18];
 ax2.XTickLabels = {'Fountain ','Trinity K.C.C.','Green Wat','Q.Anne C.','Painted H.','Chapel Entr.','Undercr.','Q. Mary C.','K.William C.','K. W. Green','Market S.','Turnpin Lane','Market N.','Market St.','Cutty S.', 'Waterside' , 'Piers', 'Water'};
%ax2.XTickLabels.FontSize = 10;
%ax2.XLabel= 'Locations';
  hold off
  
 subplot(3,1,3)
 boxplot(sumVector(21:30,:)/length(T),'Color',[0.0,0.8,0.2],'BoxStyle','outline');
hold on
 boxplot(sumVector/length(T),'Color','k', 'BoxStyle','filled');
 title('no keymap');
   grid on
  %hold off
 ax2 = gca;
 ax2.YLim = [0,0.3];
 ax2.YTick = 0:0.1:0.3;
 ax2.YLabel.String= 'Time Spent / Overall Time';
 %ax2.YTickLabels = {'0','30','60','90','120','150','180','210'};
 ax2.XTick = [ 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18];
 ax2.XTickLabels = {'Fountain ','Trinity K.C.C.','Green Wat','Q.Anne C.','Painted H.','Chapel Entr.','Undercr.','Q. Mary C.','K.William C.','K. W. Green','Market S.','Turnpin Lane','Market N.','Market St.','Cutty S.', 'Waterside' , 'Piers', 'Water'};
%ax2.XTickLabels.FontSize = 10;
%ax2.XLabel= 'Locations';
