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
    --local nChannels = opt.growthRate
    --local N = opt.nDenseConv

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
          oneBlock:add(nn.ReLU(true))
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
    local body = seq()
    buildDenseBlocks(body, opt)
    --for i = 1, opt.nDenseBlock do
    --    denseBlock(body, opt.growthRate, opt.scaleRes, opt.ipMulc, opt.nDenseConv)
    --   --body:add(denseBlock(opt.nFeat, false, actParams, opt.scaleRes, opt.ipMulc, opt.nDenseConv))
    --end
    -- nChannels = addDenseBlock(body, nChannels, opt, N)
    
    -- Transition layer
    --body:add(nn.SpatialConvolution(nChannels, opt.nFeat, 1,1, 1,1, 0,0))
    --body:add(nn.ReLU(true))
    -- Constant scaling layer
    --body:add(nn.MulConstant(0.1, false))
    --addSkip(body)

    body:add(conv(opt.nFeat,opt.nFeat, 3,3, 1,1, 1,1))

    ret = seq():add(conv(opt.nChannel,opt.nFeat, 3,3, 1,1, 1,1))
    if opt.globalSkip then
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
