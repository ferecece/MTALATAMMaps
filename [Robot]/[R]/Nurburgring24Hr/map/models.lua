local models = {

[4000] = { txd = "map/coldfftxd/bld.txd", dff="map/coldfftxd/bld_009.dff", col="map/coldfftxd/bld_009.col", lod=2000 },
[4001] = { txd = "map/coldfftxd/bld.txd", dff="map/coldfftxd/bld_001.dff", col="map/coldfftxd/bld_001.col", lod=2000 },
[4002] = { txd = "map/coldfftxd/bld.txd", dff="map/coldfftxd/bld_002.dff", col="map/coldfftxd/bld_002.col", lod=2000 },
[4003] = { txd = "map/coldfftxd/bld.txd", dff="map/coldfftxd/bld_007.dff", col="map/coldfftxd/bld_007.col", lod=2000 },
[4004] = { txd = "map/coldfftxd/trackc.txd", dff="map/coldfftxd/track_068.dff", col="map/coldfftxd/track_068.col", lod=2000 },
[4005] = { txd = "map/coldfftxd/bld.txd", dff="map/coldfftxd/bld_006.dff", col="map/coldfftxd/bld_006.col", lod=2000 },
[4006] = { txd = "map/coldfftxd/bld.txd", dff="map/coldfftxd/bld_004.dff", col="map/coldfftxd/bld_004.col", lod=2000 },
[4007] = { txd = "map/coldfftxd/bld.txd", dff="map/coldfftxd/bld_005.dff", col="map/coldfftxd/bld_005.col", lod=2000 },
[4008] = { txd = "map/coldfftxd/bld.txd", dff="map/coldfftxd/bld_014.dff", col="map/coldfftxd/bld_014.col", lod=2000 },
[4009] = { txd = "map/coldfftxd/trackc.txd", dff="map/coldfftxd/track_011.dff", col="map/coldfftxd/track_011.col", lod=2000 },
[4010] = { txd = "map/coldfftxd/trackc.txd", dff="map/coldfftxd/track_066.dff", col="map/coldfftxd/track_066.col", lod=2000 },
[4011] = { txd = "map/coldfftxd/trackc.txd", dff="map/coldfftxd/track_065.dff", col="map/coldfftxd/track_065.col", lod=2000 },
[4012] = { txd = "map/coldfftxd/trackc.txd", dff="map/coldfftxd/track_067.dff", col="map/coldfftxd/track_067.col", lod=2000 },
[4013] = { txd = "map/coldfftxd/bld.txd", dff="map/coldfftxd/bld_015.dff", col="map/coldfftxd/bld_015.col", lod=2000 },
[4014] = { txd = "map/coldfftxd/trackc.txd", dff="map/coldfftxd/track_001.dff", col="map/coldfftxd/track_001.col", lod=2000 },
[4015] = { txd = "map/coldfftxd/trackc.txd", dff="map/coldfftxd/track_002.dff", col="map/coldfftxd/track_002.col", lod=2000 },
[4016] = { txd = "map/coldfftxd/trackc.txd", dff="map/coldfftxd/track_003.dff", col="map/coldfftxd/track_003.col", lod=2000 },
[4017] = { txd = "map/coldfftxd/trackc.txd", dff="map/coldfftxd/track_004.dff", col="map/coldfftxd/track_004.col", lod=2000 },
[4018] = { txd = "map/coldfftxd/trackc.txd", dff="map/coldfftxd/track_005.dff", col="map/coldfftxd/track_005.col", lod=2000 },
[4019] = { txd = "map/coldfftxd/trackc.txd", dff="map/coldfftxd/track_006.dff", col="map/coldfftxd/track_006.col", lod=2000 },
[4020] = { txd = "map/coldfftxd/trackc.txd", dff="map/coldfftxd/track_007.dff", col="map/coldfftxd/track_007.col", lod=2000 },
[4021] = { txd = "map/coldfftxd/trackc.txd", dff="map/coldfftxd/track_008.dff", col="map/coldfftxd/track_008.col", lod=2000 },
[4022] = { txd = "map/coldfftxd/trackc.txd", dff="map/coldfftxd/track_009.dff", col="map/coldfftxd/track_009.col", lod=2000 },
[4023] = { txd = "map/coldfftxd/trackc.txd", dff="map/coldfftxd/track_010.dff", col="map/coldfftxd/track_010.col", lod=2000 },
[4024] = { txd = "map/coldfftxd/trackc.txd", dff="map/coldfftxd/track_012.dff", col="map/coldfftxd/track_012.col", lod=2000 },
[4025] = { txd = "map/coldfftxd/trackc.txd", dff="map/coldfftxd/track_013.dff", col="map/coldfftxd/track_013.col", lod=2000 },
[4026] = { txd = "map/coldfftxd/trackc.txd", dff="map/coldfftxd/track_014.dff", col="map/coldfftxd/track_014.col", lod=2000 },
[4027] = { txd = "map/coldfftxd/trackc.txd", dff="map/coldfftxd/track_015.dff", col="map/coldfftxd/track_015.col", lod=2000 },
[4028] = { txd = "map/coldfftxd/trackc.txd", dff="map/coldfftxd/track_016.dff", col="map/coldfftxd/track_016.col", lod=2000 },
[4029] = { txd = "map/coldfftxd/trackc.txd", dff="map/coldfftxd/track_017.dff", col="map/coldfftxd/track_017.col", lod=2000 },
[4030] = { txd = "map/coldfftxd/trackc.txd", dff="map/coldfftxd/track_018.dff", col="map/coldfftxd/track_018.col", lod=2000 },
[4031] = { txd = "map/coldfftxd/trackc.txd", dff="map/coldfftxd/track_019.dff", col="map/coldfftxd/track_019.col", lod=2000 },
[4032] = { txd = "map/coldfftxd/trackc.txd", dff="map/coldfftxd/track_020.dff", col="map/coldfftxd/track_020.col", lod=2000 },
[4033] = { txd = "map/coldfftxd/trackc.txd", dff="map/coldfftxd/track_021.dff", col="map/coldfftxd/track_021.col", lod=2000 },
[4034] = { txd = "map/coldfftxd/trackc.txd", dff="map/coldfftxd/track_022.dff", col="map/coldfftxd/track_022.col", lod=2000 },
[4035] = { txd = "map/coldfftxd/trackc.txd", dff="map/coldfftxd/track_023.dff", col="map/coldfftxd/track_023.col", lod=2000 },
[4036] = { txd = "map/coldfftxd/trackc.txd", dff="map/coldfftxd/track_024.dff", col="map/coldfftxd/track_024.col", lod=2000 },
[4037] = { txd = "map/coldfftxd/trackc.txd", dff="map/coldfftxd/track_025.dff", col="map/coldfftxd/track_025.col", lod=2000 },
[4038] = { txd = "map/coldfftxd/trackc.txd", dff="map/coldfftxd/track_026.dff", col="map/coldfftxd/track_026.col", lod=2000 },
[4039] = { txd = "map/coldfftxd/trackc.txd", dff="map/coldfftxd/track_027.dff", col="map/coldfftxd/track_027.col", lod=2000 },
[4040] = { txd = "map/coldfftxd/trackc.txd", dff="map/coldfftxd/track_028.dff", col="map/coldfftxd/track_028.col", lod=2000 },
[4041] = { txd = "map/coldfftxd/trackc.txd", dff="map/coldfftxd/track_029.dff", col="map/coldfftxd/track_029.col", lod=2000 },
[4042] = { txd = "map/coldfftxd/trackc.txd", dff="map/coldfftxd/track_030.dff", col="map/coldfftxd/track_030.col", lod=2000 },
[4043] = { txd = "map/coldfftxd/trackc.txd", dff="map/coldfftxd/track_031.dff", col="map/coldfftxd/track_031.col", lod=2000 },
[4044] = { txd = "map/coldfftxd/trackc.txd", dff="map/coldfftxd/track_032.dff", col="map/coldfftxd/track_032.col", lod=2000 },
[4045] = { txd = "map/coldfftxd/trackc.txd", dff="map/coldfftxd/track_033.dff", col="map/coldfftxd/track_033.col", lod=2000 },
[4046] = { txd = "map/coldfftxd/trackc.txd", dff="map/coldfftxd/track_034.dff", col="map/coldfftxd/track_034.col", lod=2000 },
[4047] = { txd = "map/coldfftxd/trackc.txd", dff="map/coldfftxd/track_035.dff", col="map/coldfftxd/track_035.col", lod=2000 },
[4048] = { txd = "map/coldfftxd/trackc.txd", dff="map/coldfftxd/track_036.dff", col="map/coldfftxd/track_036.col", lod=2000 },
[4049] = { txd = "map/coldfftxd/trackc.txd", dff="map/coldfftxd/track_037.dff", col="map/coldfftxd/track_037.col", lod=2000 },
[4050] = { txd = "map/coldfftxd/trackc.txd", dff="map/coldfftxd/track_038.dff", col="map/coldfftxd/track_038.col", lod=2000 },
[4051] = { txd = "map/coldfftxd/trackc.txd", dff="map/coldfftxd/track_039.dff", col="map/coldfftxd/track_039.col", lod=2000 },
[4052] = { txd = "map/coldfftxd/trackc.txd", dff="map/coldfftxd/track_040.dff", col="map/coldfftxd/track_040.col", lod=2000 },
[4053] = { txd = "map/coldfftxd/trackc.txd", dff="map/coldfftxd/track_041.dff", col="map/coldfftxd/track_041.col", lod=2000 },
[4054] = { txd = "map/coldfftxd/trackc.txd", dff="map/coldfftxd/track_042.dff", col="map/coldfftxd/track_042.col", lod=2000 },
[4055] = { txd = "map/coldfftxd/trackc.txd", dff="map/coldfftxd/track_043.dff", col="map/coldfftxd/track_043.col", lod=2000 },
[4056] = { txd = "map/coldfftxd/trackc.txd", dff="map/coldfftxd/track_044.dff", col="map/coldfftxd/track_044.col", lod=2000 },
[4057] = { txd = "map/coldfftxd/trackc.txd", dff="map/coldfftxd/track_045.dff", col="map/coldfftxd/track_045.col", lod=2000 },
[4058] = { txd = "map/coldfftxd/trackc.txd", dff="map/coldfftxd/track_047.dff", col="map/coldfftxd/track_047.col", lod=2000 },
[4059] = { txd = "map/coldfftxd/trackc.txd", dff="map/coldfftxd/track_048.dff", col="map/coldfftxd/track_048.col", lod=2000 },
[4060] = { txd = "map/coldfftxd/trackc.txd", dff="map/coldfftxd/track_049.dff", col="map/coldfftxd/track_049.col", lod=2000 },
[4061] = { txd = "map/coldfftxd/trackc.txd", dff="map/coldfftxd/track_050.dff", col="map/coldfftxd/track_050.col", lod=2000 },
[4062] = { txd = "map/coldfftxd/trackc.txd", dff="map/coldfftxd/track_051.dff", col="map/coldfftxd/track_051.col", lod=2000 },
[4063] = { txd = "map/coldfftxd/trackc.txd", dff="map/coldfftxd/track_052.dff", col="map/coldfftxd/track_052.col", lod=2000 },
[4064] = { txd = "map/coldfftxd/trackc.txd", dff="map/coldfftxd/track_053.dff", col="map/coldfftxd/track_053.col", lod=2000 },
[4065] = { txd = "map/coldfftxd/trackc.txd", dff="map/coldfftxd/track_054.dff", col="map/coldfftxd/track_054.col", lod=2000 },
[4066] = { txd = "map/coldfftxd/trackc.txd", dff="map/coldfftxd/track_055.dff", col="map/coldfftxd/track_055.col", lod=2000 },
[4067] = { txd = "map/coldfftxd/trackc.txd", dff="map/coldfftxd/track_056.dff", col="map/coldfftxd/track_056.col", lod=2000 },
[4068] = { txd = "map/coldfftxd/trackc.txd", dff="map/coldfftxd/track_057.dff", col="map/coldfftxd/track_057.col", lod=2000 },
[4069] = { txd = "map/coldfftxd/trackc.txd", dff="map/coldfftxd/track_058.dff", col="map/coldfftxd/track_058.col", lod=2000 },
[4070] = { txd = "map/coldfftxd/trackc.txd", dff="map/coldfftxd/track_059.dff", col="map/coldfftxd/track_059.col", lod=2000 },
[4071] = { txd = "map/coldfftxd/trackc.txd", dff="map/coldfftxd/track_060.dff", col="map/coldfftxd/track_060.col", lod=2000 },
[4072] = { txd = "map/coldfftxd/trackc.txd", dff="map/coldfftxd/track_061.dff", col="map/coldfftxd/track_061.col", lod=2000 },
[4073] = { txd = "map/coldfftxd/trackc.txd", dff="map/coldfftxd/track_062.dff", col="map/coldfftxd/track_062.col", lod=2000 },
[4074] = { txd = "map/coldfftxd/trackc.txd", dff="map/coldfftxd/track_063.dff", col="map/coldfftxd/track_063.col", lod=2000 },
[4075] = { txd = "map/coldfftxd/trackc.txd", dff="map/coldfftxd/track_064.dff", col="map/coldfftxd/track_064.col", lod=2000 },
[4076] = { txd = "map/coldfftxd/bld.txd", dff="map/coldfftxd/bld_003.dff", col="map/coldfftxd/bld_003.col", lod=2000 },
[4077] = { txd = "map/coldfftxd/bld.txd", dff="map/coldfftxd/bld_013.dff", col="map/coldfftxd/bld_013.col", lod=2000 },
[4078] = { txd = "map/coldfftxd/bld.txd", dff="map/coldfftxd/bld_008.dff", col="map/coldfftxd/bld_008.col", lod=2000 },
[4079] = { txd = "map/coldfftxd/bld.txd", dff="map/coldfftxd/bld_010.dff", col="map/coldfftxd/bld_010.col", lod=2000 },
[4080] = { txd = "map/coldfftxd/bld.txd", dff="map/coldfftxd/bld_011.dff", col="map/coldfftxd/bld_011.col", lod=2000 },
[4081] = { txd = "map/coldfftxd/bld.txd", dff="map/coldfftxd/bld_012.dff", col="map/coldfftxd/bld_012.col", lod=2000 },
[4082] = { txd = "map/coldfftxd/trackc.txd", dff="map/coldfftxd/track_046.dff", col="map/coldfftxd/track_046.col", lod=2000 },




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
