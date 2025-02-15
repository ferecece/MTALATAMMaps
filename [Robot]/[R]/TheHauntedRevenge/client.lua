setWorldSpecialPropertyEnabled("aircars",true)
setWorldSpecialPropertyEnabled("hovercars",true)
setTrafficLightsLocked(true)
setTrafficLightState(2)
setDevelopmentMode(false)

LightState = 0
function handleTrafficLightsOutOfOrder()

	if LightState ~= 0 then
		return
	end

    -- See if the lights are currently off
    local lightsOff = getTrafficLightState() == 9
    
    if lightsOff then
        -- If they're off, turn them on
        setTrafficLightState(6)
    else
        -- If they're on, turn them off
        setTrafficLightState(9)
    end
end
-- Repeat it every half a second
setTimer(handleTrafficLightsOutOfOrder,200,0)

stateTimer = nil
function onClientColShapeHit( hitElement, matchingDimension )
	local target = getCameraTarget()

	if hitElement == target then -- This way the effect also works for spectators

		LightState = cols[source]
		--outputChatBox(LightState)
	    setTrafficLightState(LightState)
	    if isTimer(stateTimer) then
	    	resetTimer(stateTimer)
	    else
	    	stateTimer = setTimer(function()
	    		LightState = 0
	    		--outputChatBox(LightState)
	    	end,5000,1)
	    end
	   
	end
end

 --https://wiki.multitheftauto.com/wiki/Traffic_light_states
	    --state 2: red
	    --state 5: green
	    --state 6: orange
objs = {"red","orange","green"}
states = {2,6,5}
cols = {}
for i, id in ipairs (objs) do
	o = getElementByID(id)
	local x,y,z = getElementPosition(o)
	local c = createColRectangle ( x, y, 100, 1)
	cols[c] = states[i]
	addEventHandler("onClientColShapeHit", c, onClientColShapeHit)	
end

--SFbuilding = createObject(10945, -1910.26, 487.13, 121.5)
--setElementCollisionsEnabled(SFbuilding,false)
--engineSetModelLODDistance(10945,100)


function cpChange(theKey, oldValue, newValue)

    if (source == localPlayer) and (theKey == "race.checkpoint") then

    	-- Interesting times:
    	-- 21:30 spooky sky
    	-- 23:30 crystal water

		if newValue == 1 then
    		--setWeather ( 11 )
    		--setTime(12,00)

    	elseif newValue == 2 then
    		setWeather ( 118 )
    		setTime(21,30) --crystal water

    	elseif newValue == 10 then
    		setWeather ( 118 )
			setTime(21,30) --spooky clouds
    	
    	elseif newValue == 23 or newValue == 24 or newValue == 25  then
    		--aircars must be off to smoothly boost velocity
			setWorldSpecialPropertyEnabled("aircars",false)
    	
    	elseif newValue >= 29 and newValue <= 34 then
    		setWaterLevel(25)
    		setWorldSpecialPropertyEnabled("aircars",false)
    		setWorldSpecialPropertyEnabled("aircars",true)

    	else
    		setWorldSpecialPropertyEnabled("aircars",true)
    		setWaterLevel(0)
    	end


    end

end
addEventHandler("onClientElementDataChange", root, cpChange)

setTimer(function()
	local journey = createVehicle(508,-2323.1396484375,-1638.6103515625, 486.35998535156,0,0,math.random(22100,22400)/100)
	setElementAlpha(journey, 0)
	local journey_driver = createPed(288, 1600,-1720,13)
	warpPedIntoVehicle ( journey_driver, journey)
	setPedControlState(journey_driver,"accelerate",true)
	if math.random(1,2) == 1 then
		setPedControlState(journey_driver,"steer_forward",true)
	end

	-- setTimer(function()
	-- 	setElementData ( journey, 'race.collideothers', 1 )
	-- end,5000,1)

	setTimer(function()
		local a = getElementAlpha(journey)
		setElementAlpha(journey, a+5)
	end,100,30)


	setTimer(function()
		destroyElement(journey_driver)
		destroyElement(journey)
	end,30000,1)
end,1000,0)
