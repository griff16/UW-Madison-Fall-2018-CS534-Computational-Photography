function refocusApp(rgb_stack, depth_map)
    img = zeros(size(rgb_stack, 1), size(rgb_stack, 2));
    img(:, :, 1) = rgb_stack(:, :, 1);
    img(:, :, 2) = rgb_stack(:, :, 2);
    img(:, :, 3) = rgb_stack(:, :, 3);
    
    while 1 
        imshow(uint8(img))
        [x, y] = ginput(1);
        x = uint16(x); y = uint16(y);
        disp([x, y])
        if (x <= size(rgb_stack, 2) && y <= size(rgb_stack, 1) &&...
                x >= 0 && y >= 0)
            index = depth_map(y, x); 
            img = rgb_stack(:, :, 3 * index - 2);
            img = cat(3, img, rgb_stack(:, :, 3 * index - 1));
            img = cat(3, img, rgb_stack(:, :, 3 * index));
            imshow(img);
        else
            break;
        end
    end
end
