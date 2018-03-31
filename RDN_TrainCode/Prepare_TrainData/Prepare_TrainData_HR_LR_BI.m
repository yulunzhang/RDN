function Prepare_TrainData_HR_LR_BI()
%% settings
path_save = './DIV2K';
path_src = './DIV2K/DIV2K_HR';
ext               =  {'*.jpg','*.png','*.bmp'};
filepaths           =  [];
for i = 1 : length(ext)
    filepaths = cat(1,filepaths, dir(fullfile(path_src, ext{i})));
end
nb_im = length(filepaths);
DIV2K_HR = [];

for idx_im = 1:nb_im
    fprintf('Read HR :%d\n', idx_im);
    ImHR = imread(fullfile(path_src, filepaths(idx_im).name));
    DIV2K_HR{idx_im} = ImHR;
end
%% generate and save LR via imresize() with Bicubic

for IdxIm = 1:nb_im
    fprintf('IdxIm=%d\n', IdxIm);
    ImHR = DIV2K_HR{IdxIm};
    
    ImLRx2 = imresize(ImHR, 1/2, 'bicubic');
    ImLRx3 = imresize(ImHR, 1/3, 'bicubic');
    ImLRx4 = imresize(ImHR, 1/4, 'bicubic');
    % name image
    digit = IdxIm;
    fileName = num2str(IdxIm);
    while digit < 1000
        fileName = ['0', fileName];
        digit = digit*10;
    end

    FolderLRx2 = fullfile(path_save, 'DIV2K_LR_bicubic', 'X2');
    FolderLRx3 = fullfile(path_save, 'DIV2K_LR_bicubic', 'X3');
    FolderLRx4 = fullfile(path_save, 'DIV2K_LR_bicubic', 'X4');

    if ~exist(FolderLRx2)
        mkdir(FolderLRx2)
    end
    if ~exist(FolderLRx3)
        mkdir(FolderLRx3)
    end
    if ~exist(FolderLRx4)
        mkdir(FolderLRx4)
    end

    NameLRx2 = fullfile(FolderLRx2, [fileName, 'x2.png']);
    NameLRx3 = fullfile(FolderLRx3, [fileName, 'x3.png']);
    NameLRx4 = fullfile(FolderLRx4, [fileName, 'x4.png']);
    % save image
 
    imwrite(ImLRx2, NameLRx2, 'png');
    imwrite(ImLRx3, NameLRx3, 'png');
    imwrite(ImLRx4, NameLRx4, 'png');
end


end