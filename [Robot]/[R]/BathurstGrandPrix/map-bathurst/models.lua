local models = {

[4000] = { txd = "map-bathurst/bld.txd", dff="map-bathurst/bld_006.dff", col="map-bathurst/bld_006.col", lod=2000 },
[4001] = { txd = "map-bathurst/bld.txd", dff="map-bathurst/bld_004.dff", col="map-bathurst/bld_004.col", lod=2000 },
[4002] = { txd = "map-bathurst/bld.txd", dff="map-bathurst/bld_005.dff", col="map-bathurst/bld_005.col", lod=2000 },
[4003] = { txd = "map-bathurst/bld.txd", dff="map-bathurst/bld_007.dff", col="map-bathurst/bld_007.col", lod=2000 },
[4004] = { txd = "map-bathurst/bld.txd", dff="map-bathurst/bld_011.dff", col="map-bathurst/bld_011.col", lod=2000 },
[4005] = { txd = "map-bathurst/bld.txd", dff="map-bathurst/bld_010.dff", col="map-bathurst/bld_010.col", lod=2000 },
[4006] = { txd = "map-bathurst/bld.txd", dff="map-bathurst/bld_009.dff", col="map-bathurst/bld_009.col", lod=2000 },
[4007] = { txd = "map-bathurst/bld.txd", dff="map-bathurst/bld_008.dff", col="map-bathurst/bld_008.col", lod=2000 },
[4008] = { txd = "map-bathurst/bld.txd", dff="map-bathurst/bld_001.dff", col="map-bathurst/bld_001.col", lod=2000 },
[4009] = { txd = "map-bathurst/bld.txd", dff="map-bathurst/bld_002.dff", col="map-bathurst/bld_002.col", lod=2000 },
[4010] = { txd = "map-bathurst/bld.txd", dff="map-bathurst/bld_003.dff", col="map-bathurst/bld_003.col", lod=2000 },
[4011] = { txd = "map-bathurst/track.txd", dff="map-bathurst/track_001.dff", col="map-bathurst/track_001.col", lod=2000 },
[4012] = { txd = "map-bathurst/track.txd", dff="map-bathurst/track_002.dff", col="map-bathurst/track_002.col", lod=2000 },
[4013] = { txd = "map-bathurst/track.txd", dff="map-bathurst/track_003.dff", col="map-bathurst/track_003.col", lod=2000 },
[4014] = { txd = "map-bathurst/track.txd", dff="map-bathurst/track_004.dff", col="map-bathurst/track_004.col", lod=2000 },
[4015] = { txd = "map-bathurst/track.txd", dff="map-bathurst/track_005.dff", col="map-bathurst/track_005.col", lod=2000 },
[4016] = { txd = "map-bathurst/track.txd", dff="map-bathurst/track_006.dff", col="map-bathurst/track_006.col", lod=2000 },
[4017] = { txd = "map-bathurst/track.txd", dff="map-bathurst/track_007.dff", col="map-bathurst/track_007.col", lod=2000 },
[4018] = { txd = "map-bathurst/track.txd", dff="map-bathurst/track_008.dff", col="map-bathurst/track_008.col", lod=2000 },
[4019] = { txd = "map-bathurst/track.txd", dff="map-bathurst/track_009.dff", col="map-bathurst/track_009.col", lod=2000 },
[4020] = { txd = "map-bathurst/track.txd", dff="map-bathurst/track_010.dff", col="map-bathurst/track_010.col", lod=2000 },
[4021] = { txd = "map-bathurst/track.txd", dff="map-bathurst/track_011.dff", col="map-bathurst/track_011.col", lod=2000 },
[4022] = { txd = "map-bathurst/track.txd", dff="map-bathurst/track_012.dff", col="map-bathurst/track_012.col", lod=2000 },
[4023] = { txd = "map-bathurst/track.txd", dff="map-bathurst/track_013.dff", col="map-bathurst/track_013.col", lod=2000 },
[4024] = { txd = "map-bathurst/track.txd", dff="map-bathurst/track_014.dff", col="map-bathurst/track_014.col", lod=2000 },
[4025] = { txd = "map-bathurst/track.txd", dff="map-bathurst/track_015.dff", col="map-bathurst/track_015.col", lod=2000 },
[4026] = { txd = "map-bathurst/track.txd", dff="map-bathurst/track_016.dff", col="map-bathurst/track_016.col", lod=2000 },
[4027] = { txd = "map-bathurst/track.txd", dff="map-bathurst/track_017.dff", col="map-bathurst/track_017.col", lod=2000 },
[4028] = { txd = "map-bathurst/track.txd", dff="map-bathurst/track_018.dff", col="map-bathurst/track_018.col", lod=2000 },
[4029] = { txd = "map-bathurst/track.txd", dff="map-bathurst/track_022.dff", col="map-bathurst/track_022.col", lod=2000 },
[4030] = { txd = "map-bathurst/track.txd", dff="map-bathurst/track_019.dff", col="map-bathurst/track_019.col", lod=2000 },
[4031] = { txd = "map-bathurst/track.txd", dff="map-bathurst/track_020.dff", col="map-bathurst/track_020.col", lod=2000 },
[4032] = { txd = "map-bathurst/track.txd", dff="map-bathurst/track_023.dff", col="map-bathurst/track_023.col", lod=2000 },
[4033] = { txd = "map-bathurst/track.txd", dff="map-bathurst/track_021.dff", col="map-bathurst/track_021.col", lod=2000 },


}

function ReplaceTexture(modelId, texture)
 if texture then
  local txd = engineLoadTXD(texture)
  if not txd then
   outputConsole(texture .." couldn't be loaded")
  else
   return engineImportTXD(txd, modelId)
  end
 end
 return false
end


function ReplaceModel(modelId, modelData)
 if modelData.dff then
  local dff = engineLoadDFF(modelData.dff, 0)
  if not dff then
   outputConsole(modelData.dff .." couldn't be loaded")
  else
   engineReplaceModel(dff, modelId)
  end
 end
 if modelData.col then
  local col = engineLoadCOL(modelData.col, modelId)
  if not col then
   outputConsole(modelData.col .." couldn't be loaded")
  else 
   engineReplaceCOL(col, modelId)
  end
 end 
 if modelData.lod then
  engineSetModelLODDistance(modelId, modelData.lod)
 end
end


addEventHandler("onClientResourceStart", getResourceRootElement(), 
 function()
  for modelId,modelData in pairs(models) do
   if ReplaceTexture(modelId, modelData.txd) then
    ReplaceModel(modelId, modelData)
   end
  end
 end 
)
