require 'nn'
require 'cunn'
require 'cudnn'
require 'model/common_dense'
--require 'model/DenseConnectLayer'

local function createModel(opt)

    local actParams = {}
    actParams.actType = opt.act
    actParams.l = opt.l
    actParams.u = opt.u
    actParams.alpha = opt.alpha
    actParams.negval = opt.negval
  

    function addLayer(model, nChannels, opt)
       if opt.optMemory >= 3 then
          model:add(nn.DenseConnectLayerCustom(nChannels, opt))
       else
          model:add(DenseConnectLayerStandard(nChannels, opt))     
       end
    end
    function DenseConnectLayerStandard(nChannels, opt)
       local net = nn.Sequential()
       net:add(nn.SpatialConvolution(nChannels, opt.growthRate, 3, 3, 1, 1, 1, 1))
       net:add(nn.ReLU(true))
       return nn.Sequential()
          :add(nn.Concat(2)
             :add(nn.Identity())
             :add(net))
    end
    local function addDenseBlock(model, nChannels, opt, N)
       -- opt.growthRate: output feature number of each conv layer
       for i = 1, N do 
          addLayer(model, nChannels, opt)
          nChannels = nChannels + opt.growthRate
       end
       return nChannels
    end
    function buildDenseBlocks(model, opt)
       local scaleRes = (opt.scaleRes and opt.scaleRes ~= 1) and opt.scaleRes or false
       local nDenseBlock = opt.nDenseBlock
       local nDenseConv  = opt.nDenseConv
       for i = 1, nDenseBlock do
          local nChannels = opt.nFeat
          local oneBlock = seq()
          nChannels = addDenseBlock(oneBlock, nChannels, opt, nDenseConv)
          oneBlock:add(nn.SpatialConvolution(nChannels, opt.nFeat, 1,1, 1,1, 0,0))
          --oneBlock:add(nn.ReLU(true))
          if scaleRes then
              oneBlock:add(nn.MulConstant(opt.scaleRes, opt.ipMulc))
          end
          if opt.addBlockSkip then
             addSkip(oneBlock)
          end
          model:add(oneBlock)
       end
       --return nChannels
    end
    -- build one DenseBlock
    function buildDenseBlockUnit(model, opt)
       local scaleRes = (opt.scaleRes and opt.scaleRes ~= 1) and opt.scaleRes or false
       local nDenseConv  = opt.nDenseConv -- conv layer number in one dense block
       local nChannels = opt.nFeaSDB        -- input feature number opt.growthRate
       local BlockUnit = nn.Sequential()
       nChannels = addDenseBlock(BlockUnit, nChannels, opt, nDenseConv)
       -- local feature fusion via 1x1 conv layer
       BlockUnit:add(nn.SpatialConvolution(nChannels, opt.nFeaSDB, 1,1, 1,1, 0,0))
       --BlockUnit:add(nn.ReLU(true))
       --if scaleRes then
       --   BlockUnit:add(nn.MulConstant(opt.scaleRes, opt.ipMulc))
       --end
       -- add local skip connection
       if opt.addBlockSkip then
          --print('add local skip')
          model:add(addSkip(BlockUnit, true))
       else
          model:add(BlockUnit)
       end
       
       return model
    end
    -- build dense blocks
    function buildRecursiveDenseBlocks(DenseBlockUnit, nDenseBlockAdd)
       local N = nDenseBlockAdd
       local blockGrow = nn.Sequential()
       if 1 == N then
          blockGrow = buildDenseBlockUnit(blockGrow, opt)
          blockGrow:add(
              nn.Concat(2)
              :add(nn.Identity())
              :add(DenseBlockUnit)
          )
       else
          blockGrow = buildDenseBlockUnit(blockGrow, opt)
          blockGrow:add(
              nn.Concat(2)
              :add(nn.Identity())
              :add(buildRecursiveDenseBlocks(DenseBlockUnit, N - 1))
          )
       end
       return blockGrow
    end
    
    local DenseBlockUnit = seq()
    local body = nn.Sequential()
    body:add(nn.SpatialConvolution(opt.nFeat, opt.nFeaSDB, 3,3, 1,1, 1,1))
    DenseBlockUnit = buildDenseBlockUnit(DenseBlockUnit, opt)
    bodyDenseBlocks = buildRecursiveDenseBlocks(DenseBlockUnit, opt.nDenseBlock-1)
    body:add(bodyDenseBlocks)
    local nFeatTransit = opt.nFeaSDB*(opt.nDenseBlock)
    -- global feature fusion via 1x1 conv layer
    body:add(nn.SpatialConvolution(nFeatTransit, opt.nFeat, 1,1, 1,1, 0,0))
    -- global conv
    body:add(conv(opt.nFeat,opt.nFeat, 3,3, 1,1, 1,1))
    -- feature extraction
    ret = seq():add(conv(opt.nChannel,opt.nFeat, 3,3, 1,1, 1,1))
    if opt.globalSkip then
        -- global skip connection
        ret:add(addSkip(body, true))
    else
        ret:add(body)
    end
    ret:add(upsample_wo_act(opt.scale[1], opt.upsample, opt.nFeat))
        :add(conv(opt.nFeat,opt.nChannel, 3,3, 1,1, 1,1))
    print(ret)
    return ret
    
end
return createModel
