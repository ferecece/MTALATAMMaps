function startText()
	outputChatBox("if u press A or D ur banned perma -msg by console (REAL)!! !!!!!!!!",255,0,0,true)
    outputChatBox("if u press A or D ur banned perma -msg by console (REAL)!! !!!!!!!!",255,0,0,true)
    outputChatBox("if u press A or D ur banned perma -msg by console (REAL)!! !!!!!!!!",255,0,0,true)
end
addEventHandler("onClientResourceStart",getResourceRootElement(getThisResource()),startText)
--addEventHandler("onClientResourceStop",getResourceRootElement(getThisResource()),startText)

function changeDistance()
    for i,object in pairs(getElementsByType("object")) do
        if isElement(object) then
            local elementID = getElementModel(object)
            engineSetModelLODDistance(elementID,1000)
        end
    end
end
addEventHandler("onClientResourceStart",getResourceRootElement(getThisResource()),changeDistance)

function autokill()
    local x, y, z = getElementPosition(localPlayer)
    local vehicle = getPedOccupiedVehicle(localPlayer)
	if z < 9800 then 
        setElementHealth(vehicle, getElementHealth(vehicle) - 500)
    end
end
addEventHandler("onClientRender", getRootElement(), autokill)