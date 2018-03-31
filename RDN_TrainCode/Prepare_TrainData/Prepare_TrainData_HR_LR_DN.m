function Prepare_TrainData_HR_LR_DN()
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
sigma = 30; % noise level
for IdxIm = 1:nb_im
    fprintf('IdxIm=%d\n', IdxIm);
    ImHR = DIV2K_HR{IdxIm};
    ImLRx3 = imresize_DN(ImHR, 3, sigma);
    % name image
    digit = IdxIm;
    fileName = num2str(IdxIm);
    while digit < 1000
        fileName = ['0', fileName];
        digit = digit*10;
    end

    FolderLRx3 = fullfile(path_save, 'DIV2K_LR_bicubic', 'X3');
    
    if ~exist(FolderLRx3)
        mkdir(FolderLRx3)
    end

    NameLRx3 = fullfile(FolderLRx3, [fileName, 'x3DN.png']);
    % save image
    imwrite(ImLRx3, NameLRx3, 'png');
end


end

function ImLR = imresize_DN(ImHR, scale, sigma)
% ImLR and ImHR are uint8 data
% downsample by Bicubic
ImDown = imresize(ImHR, 1/scale, 'bicubic'); % 0-255
ImDown = single(ImDown); % 0-255
ImDownNoise = ImDown + single(sigma*randn(size(ImDown))); % 0-255
ImLR = uint8(ImDownNoise); % 0-255
end