function replaceModel() 
  txd = engineLoadTXD ("stinger/stinger.txd", 451 )
  engineImportTXD (txd, 451)
  dff = engineLoadDFF ("stinger/stinger.dff", 451 )
  engineReplaceModel (dff, 451)
end
addEventHandler ( "onClientResourceStart", getResourceRootElement(getThisResource()), replaceModel)
 
addCommandHandler ( "reloadcar", replaceModel )