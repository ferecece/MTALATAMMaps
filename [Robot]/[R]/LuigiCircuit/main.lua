txd_luigi = engineLoadTXD ( "luigi.txd" )
engineImportTXD ( txd_luigi, 8356 )
col_luigi = engineLoadCOL ( "luigi.col" )
engineReplaceCOL ( col_luigi, 8356 )
dff_luigi = engineLoadDFF ( "luigi.dff", 0 )
engineReplaceModel ( dff_luigi, 8356 )





