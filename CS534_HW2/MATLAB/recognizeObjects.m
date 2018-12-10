function output_img = recognizeObjects(orig_img, labeled_img, obj_db)
database = compute2DProperties(orig_img, labeled_img);
ary = zeros(size(database, 2));
for i = 1 : size(obj_db, 2)
    for j = 1 : size(database, 2)
        if(abs(obj_db(6, i) - database(6, j)) < 0.1)
            ary(j) = 1;
        end
    end
end
output_img = annotate(ary, database, orig_img);
end