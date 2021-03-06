%%  
%??????????box_data_0??box_data_1??????VOC2007??????????trainval.txt;train.txt;test.txt??val.txt  
%trainval????????????90%??test????????????10%??train??trainval??90%??val??trainval??10%??  
%????????????????????????????????????????????????????????test??val????????  
%%  
%??????????????  
xmlfilepath='J:\my_document\data\train_data_png\Annotations'; 
imgpath = 'J:\my_document\data\train_data_png\all_png_image'; 
imgpath_0='J:\my_document\data\train_data_png\0';  
imgpath_1='J:\my_document\data\train_data_png\1'; 
txtsavepath='J:\my_document\data\train_data_png\ImageSets\Main_1\';  
trainval_percent=0.9;%trainval??????????????????????????????????test??????????  
train_percent=0.8;%train??trainval??????????????????????val??????????  

%{
%% ??????0????????????
fid=fopen(boxfilepath_0); % ????????
row_0=0;
while ~feof(fid) % ??????????????????
    [~] = fgets(fid); % ????fgetl
    row_0 = row_0 + 1; % ????????
end
fclose(fid); % ??????????????????????

%% ??????1????????????
fid=fopen(boxfilepath_1); % ????????
row_1=0;
while ~feof(fid) % ??????????????????
    [~] = fgets(fid); % ????fgetl
    row_1 = row_1 + 1; % ????????
end
fclose(fid); % ??????????????????????
%}

% '0'??????????
img_0 = dir(imgpath_0);  
num_0 = length(img_0) - 2 ;  %????.??..
% '1'??????????
img_1 = dir(imgpath_1);  
num_1 = length(img_1) - 2;   %????.??..
% ????????????????
flist_0 = dir(sprintf('%s/*.png', imgpath_0));
flist_1 = dir(sprintf('%s/*.png', imgpath_1));

%% '0'??????
% trainval=sort(randperm(num_0,floor(num_0 * trainval_percent)));
% test=sort(setdiff(1:num_0,trainval));
% trainvalsize=length(trainval); %trainval??????
% train=sort(trainval(randperm(trainvalsize,floor(trainvalsize*train_percent))));
% val=sort(setdiff(trainval,train));
% ftrainval=fopen([txtsavepath 'trainval.txt'],'w');
% ftest=fopen([txtsavepath 'test.txt'],'w');
% ftrain=fopen([txtsavepath 'train.txt'],'w');
% fval=fopen([txtsavepath 'val.txt'],'w');
% 
% for i=1:num_0
%     str = regexp(flist_0(i).name, '\.','split');
%     name = str{1};
%     if ismember(i,trainval)
%         fprintf(ftrainval,'%s\n', name);
%         if ismember(i,train)
%             fprintf(ftrain,'%s\n', name);
%         else
%             fprintf(fval,'%s\n', name);
%         end
%     else
%         fprintf(ftest,'%s\n', name);
%     end
% end
% fclose(ftrainval);
% fclose(ftrain);
% fclose(fval);
% fclose(ftest);


%% ??1????????
trainval=sort(randperm(num_1,floor(num_1 * trainval_percent)));
test=sort(setdiff(1:num_1,trainval));
trainvalsize=length(trainval);%trainval??????
train=sort(trainval(randperm(trainvalsize,floor(trainvalsize*train_percent))));
val=sort(setdiff(trainval,train));
ftrainval=fopen([txtsavepath 'trainval.txt'],'a+');
ftest=fopen([txtsavepath 'test.txt'],'a+');
ftrain=fopen([txtsavepath 'train.txt'],'a+');
fval=fopen([txtsavepath 'val.txt'],'a+');

for i=1:num_1
    str = regexp(flist_1(i).name, '\.','split'); % ??????????.????regexp????????????\.??
    name = str{1};
    if ismember(i,trainval)
        fprintf(ftrainval,'%s\n', name);
        if ismember(i,train)
            fprintf(ftrain,'%s\n', name);
        else
            fprintf(fval,'%s\n', name);
        end
    else
        fprintf(ftest,'%s\n', name);
    end
end
fclose(ftrainval);
fclose(ftrain);
fclose(fval);
fclose(ftest);


% while ~feof(fidin)
%      tline=fgetl(fidin);
%      str = regexp(tline, ' ','split');
%      filepath=[imgpath,str{1}];