function hough_img = generateHoughAccumulator(img, theta_num_bins, rho_num_bins)
hough_img  = zeros(rho_num_bins, theta_num_bins);  % x is rho_num_bins, y is theta_num_bins
image(hough_img)
rho_max = sqrt(size(img, 1)^2 + size(img, 2)^2);
theta_max = pi;
[yPoint, xPoint] = find(img == 255);
%ratio = rho_max / rho_num_bins;
thetas = linspace(-theta_max, theta_max, theta_num_bins);rhos = linspace(-rho_max, rho_max, rho_num_bins);

for i = 1 : size(yPoint, 1)  % go through number of edge points
    for j = 1 : theta_num_bins  % each edge point goes with different theta to calculate rho
        rho = cal_rho(thetas(j), xPoint(i), yPoint(i));
        for k = 1 : (rho_num_bins - 1)  % find the correct rho_bin position
            if(rho > rhos(k) && rho <= rhos(k + 1))
                hough_img(k, j) = hough_img(k, j) + 1;
            end
        end
    end
end
end

% calculate rho
function rho = cal_rho(theta, x, y)
rho = y * cos(theta) - x * sin(theta);
end