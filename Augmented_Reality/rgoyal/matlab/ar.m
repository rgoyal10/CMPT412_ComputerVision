% Q3.3.1
close all
clear variables 
book = loadVid('../data/book.mov');
ar_source = loadVid('../data/ar_source.mov');
image1 = imread('../data/cv_cover.jpg');
video = VideoWriter('../results/movie.avi');
open(video);
for i = 1: size(ar_source, 2)
    image2 = book(i).cdata;
    
    %applying ransac
    [locs1, locs2] = matchPics(image1, image2);
    [bestH2to1, ~] = computeH_ransac(locs1, locs2);
    
    image3 = ar_source(i).cdata;
    image3 = imcrop(image3, [45 45 size(image3, 2) size(image3, 1)-90]);
    scaled_hp_img = imresize(image3, [size(image1,1) size(image1,2)]);
    imshow(compositeH(bestH2to1.', scaled_hp_img, image2));
    writeVideo(video, compositeH(bestH2to1.', scaled_hp_img, image2));
end
close(video);