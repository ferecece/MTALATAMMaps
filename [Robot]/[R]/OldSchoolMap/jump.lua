setWaterColor(246,235,74)
bindKey ( "lshift","down",  
function ()       
    local vehicle = getPedOccupiedVehicle(localPlayer) 
    if (isVehicleOnGround( vehicle ) == true) then           
    local sx,sy,sz = getElementVelocity ( vehicle ) 
                    setElementVelocity( vehicle ,sx, sy, sz+0.2 ) 
    end 
end 
) 
