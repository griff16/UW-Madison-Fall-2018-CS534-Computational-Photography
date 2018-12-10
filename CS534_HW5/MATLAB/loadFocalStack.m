function [rgb_stack, gray_stack] = loadFocalStack(focal_stack_dir)
       fileName = dir([focal_stack_dir '/*.jpg']);
       cd stack;
       rgb_stack = imread(fileName(1).name);
       gray_stack = rgb2gray(imread(fileName(1).name));
       for i = 2 : size(fileName, 1)
           img = imread(fileName(i).name);
           %imshow(img)
           rgb_stack = cat(3, rgb_stack, img);
           grayImg = rgb2gray(img);
           gray_stack = cat(3, gray_stack, grayImg);
       end
       cd ..;
end
