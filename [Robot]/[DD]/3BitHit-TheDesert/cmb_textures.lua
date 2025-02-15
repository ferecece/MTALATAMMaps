function loadTextures()
	IDlist = {}
	IDlist[0] = 2666
	IDlist[1] = 2667
	IDlist[2] = 2668
	IDlist[3] = 2695
	IDlist[4] = 2696
	IDlist[5] = 2697
	IDlist[6] = 2719
	IDlist[7] = 2720
	IDlist[8] = 2721
	IDlist[9] = 2722

	for i=0,9 do
		txd = engineLoadTXD ( "num"..tostring(i)..".txd" )
		engineImportTXD ( txd, IDlist[i] )
		dff = engineLoadDFF ( "cj_don_poster.dff", 0 )
		engineReplaceModel ( dff, IDlist[i]  )
	end
end
addEventHandler("onClientResourceStart",getResourceRootElement(),loadTextures)