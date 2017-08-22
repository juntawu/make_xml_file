
% img = imread('J:\my_document\000097.png');
% size(img)
% r = img(:, :, 1);
% g = img(:, :, 2);
% b = img(:, :, 3);
% 
% index_r = (r == 237);
% index_g = (g == 28);
% index_b = (b == 36);
% 
% index = index_r & index_g & index_b;
% img(:,:,1) = img(:,:,1) & index;
% img(:,:,2) = img(:,:,2) & index;
% img(:,:,3) = img(:,:,3) & index;
% 
% img = 255 * img;
% 
% imwrite(img, 'thres.png')


fpath_mark = 'J:\my_document\data\box_data\mark\';
flist_mark = dir(sprintf('%s/*.bmp', fpath_mark));

fid = fopen('J:\my_document\data\box_data\data_box_mark.txt', 'w');
for i = 1 : length(flist_mark)
    img = imread(sprintf('%s%s',fpath_mark, flist_mark(i).name));
    r = img(:, :, 1);
    g = img(:, :, 2);
    b = img(:, :, 3);
    
    index_r = (r == 237);
    index_g = (g == 28);
    index_b = (b == 36);
    
    index = index_r & index_g & index_b;
    img(:,:,1) = img(:,:,1) & index;
    img(:,:,2) = img(:,:,2) & index;
    img(:,:,3) = img(:,:,3) & index;
    img = 255 * img;

    % ???????????????????? ????????????????????????????????????
    img = rgb2gray(img);
    thresh = 128;
    thresh = graythresh(thresh);
    img = im2bw(img, thresh);
    img_reg = regionprops(img,  'area', 'boundingbox');  
    areas = [img_reg.Area];  
    % ????????????????????????????????????
    rects = cat(1,  img_reg.BoundingBox); 
    % ground truth ????????????????????????????
    for j = 1:size(rects, 1)
        fprintf(fid, '%s ', flist_mark(i).name);
        fprintf(fid, '%s ', '1');
        fprintf(fid, '%g ', round( rects(j, 1) ) );
        fprintf(fid, '%g ', round( rects(j, 2) ) );
        fprintf(fid, '%g ', round( rects(j, 1) + rects(j, 3) ) );
        fprintf(fid, '%g%s', round( rects(j, 2) + rects(j, 4) ), sprintf('\n') );
    end
    
end
fclose(fid);