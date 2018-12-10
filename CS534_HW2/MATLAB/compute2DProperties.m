function [db, out_img] = compute2DProperties(orig_img, labeled_img)
m = max(max(labeled_img,[], 2));
db  = zeros(7, m);

for i = 1 : m
    [row, col] = find(labeled_img == i);
    r = size(row, 1);
    c = size(col, 1);
    A = r;
    db(7,i) = A;
    a_prime = 0; b_prime = 0; c_prime = 0;
    theta_one = 0; theta_two = 0;
    
    % initialize first row
    db(1, i) = i;
    
    % calculate y bar
    y_bar = 0;
    for j = 1 : r
        y_bar = y_bar + col(j);
    end
    y_bar = y_bar / A;
    db(2, i) = y_bar;
    
    % calculate x bar
    x_bar = 0;
    for j=1 : r
        x_bar = x_bar + row(j);
    end
    x_bar = x_bar / A;
    db(3, i) = x_bar;
    
    % calculate orientation
    % calculating a
    for j = 1 : r
        a_prime = a_prime + (row(j))^2;
    end
    a = a_prime - A * (x_bar)^2;  
    
    % calculating b
    for j = 1 : r
        b_prime = b_prime + col(j) * row(j);
    end
    b_prime = 2 * b_prime;
    b = b_prime - 2 * A * x_bar * y_bar;
    
    % calculating c
    for j = 1 : r
        c_prime = c_prime + (col(j))^2;
    end
    c = c_prime - A * (y_bar)^2;
    
    
    theta_one = atan2(b, a-c) / 2; % orientation
    theta_two = theta_one + pi / 2;
    db(5, i) = theta_one;
    
    %calculate inertia
    e_min = a*(sin(theta_one))^2 - b*sin(theta_one)*cos(theta_one) + c*(cos(theta_one))^2;
    e_max = a*(sin(theta_two))^2 - b*sin(theta_two)*cos(theta_two) + c*(cos(theta_two))^2;
    db(4, i) = e_min;
    
    % calculate roundness
    db(6, i) = e_min/e_max;
end

ary = ones(size(db, 2));
out_img = annotate(ary, db, orig_img);
end
