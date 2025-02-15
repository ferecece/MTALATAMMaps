function changeDistance()

    for i,object in pairs(getElementsByType("object")) do

        if isElement(object) then

            local elementID = getElementModel(object )
            engineSetModelLODDistance(10377,1000)
            engineSetModelLODDistance(1483,1000)
            engineSetModelLODDistance(17005,1000)
            engineSetModelLODDistance(16778,1000)	
            engineSetModelLODDistance(8399,250)
            engineSetModelLODDistance(3598,500)
            engineSetModelLODDistance(10063,300)
            engineSetModelLODDistance(3458,300)
            engineSetModelLODDistance(6874,300)
      end

    end

end

addEventHandler("onClientResourceStart",getResourceRootElement(getThisResource()),changeDistance)