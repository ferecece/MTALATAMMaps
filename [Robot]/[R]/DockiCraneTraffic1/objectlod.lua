function changeDistance()
    for i,object in pairs(getElementsByType("object")) do
        if isElement(object) then
            local elementID = getElementModel(object)
			if elementID == 5046 then
				local x, y, z = getElementPosition(object)
				local a, b, c = getElementRotation(object)
				createObject(5047, x, y, z, a, b, c, true)
			end
        end
    end
end
addEventHandler("onClientResourceStart",getResourceRootElement(getThisResource()),changeDistance)