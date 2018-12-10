function index_map = generateIndexMap(gray_stack, w_size)
    A = focusMeasure(gray_stack, w_size);
    index_map = zeros(size(gray_stack, 1), size(gray_stack, 2));
    for i = 1 : size(index_map, 1)
        for j = 1 : size(index_map, 2)
            [M, I] = max(A(i, j, :));
            index_map(i, j) = I;
        end
    end  
end
