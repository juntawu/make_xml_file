
fpath_mark = 'J:\my_document\data\train_data_png\mark\';
fpath_1 = 'J:\my_document\data\train_data_png\1\';
flist_mark = dir(sprintf('%s/*.png', fpath_mark));
flist_1 = dir(sprintf('%s/*.png', fpath_1));
% flist_mark(1265).name;
% flist_1(1265).name;
% img = imread(sprintf('%s%s',fpath_mark, flist_mark(1).name));
% imshow(img);

fid = fopen('J:\my_document\data\box_data\data_box_1.txt', 'w');
for i = 1 : length(flist_mark)
    img_1 = imread(sprintf('%s%s',fpath_1, flist_1(i).name));
    img_mark = imread(sprintf('%s%s',fpath_mark, flist_mark(i).name));

    % 原图像先进行差分后， 再灰度化及二值化，否则引入噪声！！！
    img = img_mark - img_1;
    img = rgb2gray(img);
    thresh = 128;
    thresh = graythresh(thresh);
    img = im2bw(img, thresh);
    %[L,num] = bwlabel(img,4);
    img_reg = regionprops(img,  'area', 'boundingbox');  
    areas = [img_reg.Area];  
    % 返回的矩形框信息：左上角坐标，宽，高
    rects = cat(1,  img_reg.BoundingBox); 
    % ground truth 信息是左上角坐标，右下角坐标
    for j = 1:size(rects, 1)
        fprintf(fid, '%s ', flist_mark(i).name);
        fprintf(fid, '%s ', '1');
        fprintf(fid, '%g ', round( rects(j, 1) ) );
        fprintf(fid, '%g ', round( rects(j, 2) ) );
        fprintf(fid, '%g ', round( rects(j, 1) + rects(j, 3) ) );
        fprintf(fid, '%g%s', round( rects(j, 2) + rects(j, 4) ), sprintf('\n') );
%         fprintf(fid, '%s', sprintf('\n'));
    end
    
end
fclose(fid);

%     handle = figure(1),  
%     imshow(img);  
%     hold on 
%     for i = 1:size(rects, 1)  
%         rectangle('position', rects(i, :), 'EdgeColor', 'r', 'LineWidth', 1);  
%     end 