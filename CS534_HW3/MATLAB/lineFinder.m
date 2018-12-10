function line_detected_img = lineFinder(orig_img, hough_img, hough_threshold)
line_detected_img = orig_img;

theta_max = pi;
rho_max = sqrt(size(orig_img, 1)^2 + size(orig_img, 2)^2);
theta_num_bins = size(hough_img, 2); rho_num_bins = size(hough_img, 1);
thetas = linspace(-theta_max, theta_max, theta_num_bins);rhos = linspace(-rho_max, rho_max, rho_num_bins);
f = figure();
imshow(line_detected_img);
hold on;

for i = 1 : rho_num_bins
    temp_rho = rhos(i);
    for j = 1 : theta_num_bins
        if(hough_img(i, j) >= hough_threshold)
            %fprintf('hough_threshold: %d, hough_img(%d, %d): %d\n', hough_threshold, i, j, hough_img(i, j));
            temp_theta = thetas(j);
            %fprintf('temp_theta(%d): %d, temp_rho: %d\n', j, temp_theta * 180 / pi, temp_rho);
            
            % calculate x and y
            x1 = 0;
            x2 = size(orig_img, 2);
            y1 =  (x1 * sin(temp_theta) + temp_rho) / cos(temp_theta);
            y2 =  (x2 * sin(temp_theta) + temp_rho) / cos(temp_theta);
            %disp([temp_rho x1 x2 y1 y2]);
            line([x1 x2], [y1 y2]);
        end
    end
    %fprintf('\n');
end
line_detected_img = saveAnnotatedImg(f);
end

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
frame = getframe(fh);
pause(0.5);
% Because getframe tries to perform a screen capture. it somehow
% has some platform depend issues. we should calling
% getframe twice in a row and adding a pause afterwards make getframe work
% as expected. This is just a walkaround.
annotated_img = frame.cdata;
end