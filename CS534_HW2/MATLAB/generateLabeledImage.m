function labeled_img = generateLabeledImage(gray_img, threshold)
    BW = im2bw(gray_img, threshold);
    labeled_img = bwlabel(BW);
end 