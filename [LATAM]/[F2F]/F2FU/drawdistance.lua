function changeDistance()
    for i,object in pairs(getElementsByType("object")) do
        if isElement(object) then
            local elementID = getElementModel(object )
            engineSetModelLODDistance(elementID,1000)
        end
    end
end
addEventHandler("onClientResourceStart",getResourceRootElement(getThisResource()),changeDistance)