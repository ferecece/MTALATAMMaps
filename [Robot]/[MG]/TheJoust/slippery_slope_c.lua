function setPedState(enabled)
	for i,p in pairs(getElementsByType('ped')) do
		setPedControlState(p, "brake_reverse", true)
	end
end
addEvent( "pedState", true )
addEventHandler( "pedState", root, setPedState)