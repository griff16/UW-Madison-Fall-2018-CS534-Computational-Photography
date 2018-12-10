function output = annotate(ary, db, orig_img)
fh = figure();
imshow(orig_img);
for i = 1 : size(ary)
    if(ary(i) == 1)
        % annotating the image
        hold on; plot(db(2, i), db(3, i), 'ws', 'MarkerFaceColor', [1 0 0]);
        
        % draw lines
         r = 80;
        x2 = db(2, i) + r * sin(db(5, i)); y2 = db(3, i) + r * cos(db(5, i));
        line([db(2, i), x2],[db(3, i), y2],'LineWidth',4, 'Color', [1, 0, 0]);
    end
end
% Use the saveAnnotatedImg (below) to save both the annotations and the
annotated_img = saveAnnotatedImg(fh);
imshow(annotated_img);
output = annotated_img;

function annotated_img = saveAnnotatedImg(fh)
figure(fh); % Shift the focus back to the figure fh

% The figure needs to be undocked
set(fh, 'WindowStyle', 'normal');

% The following two lines just to make the figure true size to the
% displayed image. The reason will become clear later.
img = getimage(fh);
truesize(fh, [size(img, 1), size(img, 2)]);

% getframe does a screen capture of the figure window, as a result, the
% displayed figure has to be in true size.
frame = getframe(fh);
pause(0.5);
% Because getframe tries to perform a screen capture. it somehow
% has some platform depend issues. we should calling
% getframe twice in a row and adding a pause afterwards make getframe work
% as expected. This is just a walkaround.
annotated_img = frame.cdata;
end
end