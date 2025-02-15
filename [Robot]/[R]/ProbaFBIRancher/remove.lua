function removelantarns()
removeWorldModel(1283,10000,1546,-1731,15) --stolbec svetit
removeWorldModel(1290,10000,-1990,-780,30) --lampa
removeWorldModel(1294,10000,1808,-1731,15) --stolbec bol'woi
removeWorldModel(1413,10000,1990,-7180,30) --zabr
removeWorldModel(1412,10000,1990,-7180,30) --zabr1
removeWorldModel(1350,10000,-1990,-780,30) --svetofor
removeWorldModel(669,10000,-1990,-780,30) --derevo2
removeWorldModel(671,10000,-1990,-780,30) --derevo3
removeWorldModel(703,10000,-1990,-780,30) --derevo bol'shoe naher
removeWorldModel(672,10000,-1990,-780,30) --eto derevo ewe bol'she 4em tvoe lyubopitstvo

removeWorldModel(705,100000,-1990,-780,30) --ewe odno derevo
removeWorldModel(751,100000,-1990,-780,30) -- komenec
removeWorldModel(1294,100000,2070,1524,10)
removeWorldModel(3459,100000,2070,1524,10)
removeWorldModel(904,100000,2070,1524,10)
removeWorldModel(858,100000,2070,1524,10)
removeWorldModel(905,100000,2070,1524,10)
removeWorldModel(1350,100000,2070,1524,10)
removeWorldModel(3516,100000,2070,1524,10)
removeWorldModel(1231,100000,2070,1524,10)

--removeWorldModel(746,10000,-1990,-780,30) -- komenec1


--removeWorldModel(10967,10000,-1990,-780,30) -- doroga

removeWorldModel(1226,10000,-1990,-780,30) -- stolb bolee k koncu
removeWorldModel(1373,10000,-1990,-780,30) -- shlakboom

removeWorldModel(1374,10000,-1990,-780,30) -- shlakboom
--removeWorldModel(10791,10000,-1990,-780,30) -- kaki naher eto 4itat'?

removeWorldModel(1283,10000,-1990,-780,30) -- stolb so svetom
--removeWorldModel(10838,10000,-1990,-780,30) -- kaki naher eto 4itat'?
--removeWorldModel(10807,10000,-1990,-780,30) -- KOLL
--removeWorldModel(10815,10000,-1990,-780,30) -- kaki naher eto 4itat'?
--removeWorldModel(10874,10000,-1990,-780,30) -- privet kto bi ti ne bil

--removeWorldModel(10755,10000,-1990,-780,30) -- a eto za4em udalyat' ya ne znayu
--removeWorldModel(11373,10000,-1990,-780,30) -- lod
--removeWorldmodel(11066,10000,-1990,-780,30) -- LOD


end
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), removelantarns)

function putbacklantarns()
restoreAllWorldModels()

end
addEventHandler("onResourceStop", getResourceRootElement(getThisResource()), putbacklantarns)
