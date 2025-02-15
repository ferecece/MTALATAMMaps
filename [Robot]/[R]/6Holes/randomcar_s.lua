
	local cp3ids = {579, 599, 489, 490, 495, 470}

	local cp6ids = {407, 544, 528, 433}

	local cp9ids = {573, 455, 403, 514, 515, 524, 578}

	local cp12ids = {444, 556, 557}

	local cp15ids = {406, 486, 601}

    function randomCar(checkpoint, time)
        local veh = getPedOccupiedVehicle(source)

        if checkpoint == 3 then
			zmodifier(veh,1)
            setElementModel (veh, cp3ids[math.random(#cp3ids)])
	end

        if checkpoint == 6 then
			zmodifier(veh,1)
            setElementModel (veh, cp6ids[math.random(#cp6ids)])
	end

        if checkpoint == 9 then
			zmodifier(veh,1)
            setElementModel (veh, cp9ids[math.random(#cp9ids)])
	end

        if checkpoint == 12 then
			zmodifier(veh,1)
            setElementModel (veh, cp12ids[math.random(#cp12ids)])
	end

        if checkpoint == 15 then
			zmodifier(veh,1)
            setElementModel (veh, cp15ids[math.random(#cp15ids)])
	end

end
    addEvent('onPlayerReachCheckpoint')
    addEventHandler('onPlayerReachCheckpoint', getRootElement(), randomCar)

	function zmodifier (theVehicle,height)
		x, y, z = getElementPosition (theVehicle)
		setElementPosition (theVehicle, x, y, z+height)
		setVehicleLocked (theVehicle, true)
		setVehicleDoorsUndamageable (theVehicle, true)
		setTimer (function ()
			setVehiclePanelState (theVehicle, 0, 0)
			setVehiclePanelState (theVehicle, 1, 0)
			setVehiclePanelState (theVehicle, 2, 0)
			setVehiclePanelState (theVehicle, 3, 0)
			setVehiclePanelState (theVehicle, 4, 0)
			setVehiclePanelState (theVehicle, 5, 0)
			setVehiclePanelState (theVehicle, 6, 0)
		end, 750, 1)
	end