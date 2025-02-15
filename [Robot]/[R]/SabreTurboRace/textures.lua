function replaceModel() 
  txd = engineLoadTXD ("sabre/buffalo.txd", 545 )
  engineImportTXD (txd, 545)
  dff = engineLoadDFF ("sabre/buffalo.dff", 545 )
  engineReplaceModel (dff, 545)
end
addEventHandler ( "onClientResourceStart", getResourceRootElement(getThisResource()), replaceModel)
 
addCommandHandler ( "reloadcar", replaceModel )