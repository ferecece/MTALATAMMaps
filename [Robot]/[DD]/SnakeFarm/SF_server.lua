
--Make sure there are as many item IDs as players and they do not appear in the .map or other resources
items = {   -- 1337, --bin
            -- 2880, --bin2
            -- 1212, --: Money (wad of cash)
            -- 1240, --: Health (heart)
            -- 1242, --: Armour
            -- 1239, --: Info icon
            -- 1272, --: House (blue)
            -- 1273, --: House (green)
            -- 1241, --: Adrenaline
            -- 1247, --: Bribe
            -- 1248, --: GTA III sign
            -- 1252, --: Bomb from GTA III
            -- 1253, --: Photo op
            -- 1254, --: Skull
            -- 1274, --: Money icon
            -- 1275, --: Blue t-shirt
            -- 1277, --: Save disk
            -- 1313, --: 2 Skulls
            -- 1314, --: 2 Players icon
            -- 1276, --: Tiki statue
            -- 1310, --: Parachute (with leg straps)
            -- 1318, --: Down arrow
            -- 1279, --: Drug bundle
            
            1851, --casino items, chips and chip stacks. Very small items.
            1852,
            1853,
            1854,
            1855,
            1856,
            1857,
            1858,
            1859,
            1860,
            1861,
            1862,
            1863,
            1864,
            1865,
            1866,
            1867,
            1868,
            1869,
            1871,
            1872,
            1873,
            1874,
            1875,
            1876,
            1877,
            1878,
            1879,
            1880,
            1881,
            1882,
            1899,
            1900,
            1901,
            1902,
            1903,
            1904,
            1905,
            1906,
            1907,
            1908,
            1909,
            1910,
            1911,
            1912,
            1913,
            1914,
            1915,
            1916,
            1917,
            1918,
            1919,
            1920,
            1921,
            1922,
            1923,
            1924,
            1925,
            1926,
            1927,
            1928,
            1930,
            1931,
            1932,
            1933,
            1934,
            1935,
            1936,
            1937,
            1938,
            1939,
            1940,
            1941,
        }

itemID = 1
playerObject = {} --stores the assigned objects

function raceState(newstate,oldstate)

    if (newstate == "Running" and oldstate == "GridCountdown") then

        for i,v in ipairs(getElementsByType("vehicle")) do
            setVehicleDoorState(v,1,1)
            setVehicleDoorOpenRatio(v,1,0.2)
            setVehicleDoorsUndamageable(v,true)
            setVehicleHeadLightColor(v,255,164,0)
        end

        playerPos = {}
        idToVeh = {}

        setTimer(function()

            -- Loop through alive players
            for i,p in ipairs(getAlivePlayers()) do
                
                -- Get the player vehicle
                local v = getPedOccupiedVehicle(p)
                if v then

                    -- Speed check, lose health if not moving:
                    local vx,vy,vz = getElementVelocity(v)
                    if (vx^2+vy^2+vz^2) < 0.1^2 then
                        local h = getElementHealth(v)
                        setElementHealth(v,h-10) --disable for debug
                    end

                    local x,y,z = getPositionFromElementOffset(v) --get point ~2m behind vehicle
                    if playerPos[v] and z < 20000 then --if we have a previous position entry for this player
                        
                        local xPrev,yPrev,zPrev = unpack(playerPos[v]) --get previous pos.

                        if getDistanceBetweenPoints3D(x,y,z,xPrev,yPrev,zPrev) > 1 then --if you have moved
                            local o = createObject(playerObject[p],x,y,z,_,_,_,true) --create new line node, make it lowLOD
                            setElementCollisionsEnabled(o,false)
                            setElementAlpha(o,0)
                            playerPos[v] = {x,y,z} --save to table
                            --iprint(o)
                        end
                    else
                        playerPos[v] = {x,y,z} --add new value
                        playerObject[p] = items[itemID] --get player an object
                        idToVeh[items[itemID]] = v --data to send to client
                        itemID = itemID + 1 --increase ID for next player
                        triggerClientEvent("idAssigned",resourceRoot,idToVeh)
                        --iprint(itemID,playerObject[p])
                    end

                end
            end
        end,300,0)

    end

end
addEvent ( "onRaceStateChanging", true )
addEventHandler ( "onRaceStateChanging", getRootElement(), raceState )

-- give boosts for players that drive through the markers
boost = {}
boost["marker1"]={-0.6,0.6,1.2} --velx, vely,velz
boost["marker2"]={1.4,0,1.2}
boost["marker3"]={-1,1,2}

function jumpBoost(hitElement)
    if (getElementType(hitElement)=="vehicle") then
        local ID = getElementID(source)
        if ID then
            local a = boost[ID]
            if a then
                local x,y,z = unpack(a)
                setElementVelocity(hitElement,x,y,z)
                fixVehicle(hitElement)
            end
        end
    end
end
addEventHandler("onMarkerHit",root,jumpBoost)


function vehEnter(v,seat,jacked)
    setVehicleColor(v, 0,0,0, 255,164,0) --black and orange
    setTimer(function()
        --for i=0,5 do
            setVehicleDoorState(v,1,1)
            setVehicleDoorOpenRatio(v,1,0.2)
            setVehicleDoorsUndamageable(v,true)
            setVehicleHeadLightColor(v,255,164,0)
            --setVehicleDoorState(v,i,4)
        --end
    end,500,1) --door, state 4 = missing
end
addEventHandler("onPlayerVehicleEnter",root,vehEnter)

function getPositionFromElementOffset(element)
    local vx,vy,vz = getElementVelocity(element)
    local speed = (vx^2+vy^2+vz^2)^0.5
    local offX,offY,offZ = 0,-3 + speed*1.1,0
    local m = getElementMatrix ( element )  -- Get the matrix
    local x = offX * m[1][1] + offY * m[2][1] + offZ * m[3][1] + m[4][1]  -- Apply transform
    local y = offX * m[1][2] + offY * m[2][2] + offZ * m[3][2] + m[4][2]
    local z = offX * m[1][3] + offY * m[2][3] + offZ * m[3][3] + m[4][3]
    return x, y, z                               -- Return the transformed point
end