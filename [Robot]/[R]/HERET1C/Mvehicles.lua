vehiclesync = false
setSkyGradient (0,0,0,6.7, 10, 10, 10)

 local car = {}
 car[1] = 602
 car[2] = 496
 car[3] = 518		
 car[4] = 518		
 car[5] = 491
 car[6] = 405 
 car[7] = 445
 car[8] = 467
 car[9] = 516
 car[10] = 587
 car[11] = 420
 car[12] = 415
 car[13] = 597
 car[14] = 529

randveh1 = car[math.random(#car)]
randveh2 = car[math.random(#car)]
randveh3 = car[math.random(#car)]
randveh4 = car[math.random(#car)]
randveh5 = car[math.random(#car)]
randveh6 = car[math.random(#car)]
randvelo1 = math.random(0.8,1.0)
randvelo2 = math.random(0.8,1.1)
randvelo3 = math.random(0.5,0.75)
randvelo4 = math.random(0.5,0.78)

function mveh1()
randcar1 = createVehicle(randveh1,-1765.9768066406,734.63195800781,31.521182785034,350.99670410156,0,270)
			setElementData (randcar1,'race.collideothers', 1 )
    			setElementSyncer(randcar1,vehiclesync) 
			setVehicleEngineState (randcar1, true )
			setVehicleOverrideLights (randcar1, 2 )
			setElementVelocity(randcar1,randvelo1,0,-0.1)
			setTimer(destroyElement,3999,1,randcar1)
randcar2 = createVehicle(randveh2,-1766.2408447266,728.13720703125,31.521182785034,350.99670410156,0,270)
			setElementData (randcar2, 'race.collideothers', 1 )
    			setElementSyncer(randcar2,vehiclesync) 
			setVehicleEngineState (randcar2, true )
			setVehicleOverrideLights (randcar2, 2 )
			setElementVelocity(randcar2,randvelo2,0,-0.1)
			setTimer(destroyElement,3999,1,randcar2)
randcar3 = createVehicle(randveh3,-1779.7950439453,735.76940917969,34.09178588867,351,0,270)
			setElementData (randcar3, 'race.collideothers', 1 )
    			setElementSyncer(randcar3,vehiclesync) 
			setVehicleEngineState (randcar3, true )
			setVehicleOverrideLights (randcar3, 2 )
			setElementVelocity(randcar3,randvelo3,0,-0.1)
			setTimer(destroyElement,3999,1,randcar3)
randcar4 = createVehicle(randveh4,-1779.6257324219,729.25219726563,34.096178588867,350.99670410156,0,270)
			setElementData (randcar4, 'race.collideothers', 1 )
    			setElementSyncer(randcar4,vehiclesync) 
			setVehicleEngineState (randcar4, true )
			setVehicleOverrideLights (randcar4, 2 )
			setElementVelocity(randcar4,randvelo4,0,-0.1)
			setTimer(destroyElement,3999,1,randcar4)

end
setTimer (mveh1,4000,30)
function mveh2 ()

randcar5 = createVehicle(randveh1,-1690.8363037109,836.53179931641,24.834375,0,0,90)
			setElementData (randcar5,'race.collideothers', 1 )
    			setElementSyncer(randcar5,vehiclesync) 
			setVehicleEngineState (randcar5, true )
			setVehicleOverrideLights (randcar5, 2 )
			setElementVelocity(randcar5,-randvelo1,0,-0.5)
			setTimer(destroyElement,3999,1,randcar5)
randcar6 = createVehicle(randveh2,-1685.9152832031,844.73944091797,24.834375,0,0,90)
			setElementData (randcar6, 'race.collideothers', 1 )
    			setElementSyncer(randcar6,vehiclesync) 
			setVehicleEngineState (randcar6, true )
			setVehicleOverrideLights (randcar6, 2 )
			setElementVelocity(randcar6,-randvelo2,0,-0.5)
			setTimer(destroyElement,3999,1,randcar6)
randcar7 = createVehicle(randveh3,-1679.1478271484,838.25921630859,24.834375,0,0,90)
			setElementData (randcar7, 'race.collideothers', 1 )
    			setElementSyncer(randcar7,vehiclesync) 
			setVehicleEngineState (randcar7, true )
			setVehicleOverrideLights (randcar7, 2 )
			setElementVelocity(randcar7,-randvelo3,0,-0.5)
			setTimer(destroyElement,3999,1,randcar7)
randcar8 = createVehicle(randveh4,-1674.2934570313,848.42132568359,24.834375,0,0,90)
			setElementData (randcar8, 'race.collideothers', 1 )
    			setElementSyncer(randcar8,vehiclesync) 
			setVehicleEngineState (randcar8, true )
			setVehicleOverrideLights (randcar8, 2 )
			setElementVelocity(randcar8,-randvelo4,0,-0.5)
			setTimer(destroyElement,3999,1,randcar8)
end
setTimer(mveh2,5000,30)

function mveh3 ()
randcar9 = createVehicle(randveh1,-1671.2957763672,914.53491210938,24.8421875,0,0,90)
			setElementData (randcar9, 'race.collideothers', 1 )
    			setElementSyncer(randcar9,vehiclesync) 
			setVehicleEngineState (randcar9, true )
			setVehicleOverrideLights (randcar9, 2 )
			setElementVelocity(randcar9,-randvelo4,0,-0.5)
			setTimer(destroyElement,3999,1,randcar9)
randcar10 = createVehicle(randveh2,-1680.7138671875,926.05773925781,24.8421875,0,0,90)
			setElementData (randcar10, 'race.collideothers', 1 )
    			setElementSyncer(randcar10,vehiclesync) 
			setVehicleEngineState (randcar10, true )
			setVehicleOverrideLights (randcar10, 2 )
			setElementVelocity(randcar10,-randvelo3,0,-0.5)
			setTimer(destroyElement,3999,1,randcar10)
randcar11 = createVehicle(randveh3,-1688.6575927734,931.07257080078,24.8421875,0,0,90)
			setElementData (randcar11, 'race.collideothers', 1 )
    			setElementSyncer(randcar11,vehiclesync) 
			setVehicleEngineState (randcar11, true )
			setVehicleOverrideLights (randcar11, 2 )
			setElementVelocity(randcar11,-randvelo2,0,-0.5)
			setTimer(destroyElement,3999,1,randcar11)
randcar13 = createVehicle(randveh4,-1751.5050048828,935.12341308594,24.8421875,0,0,270)
			setElementData (randcar13, 'race.collideothers', 1 )
    			setElementSyncer(randcar13,vehiclesync) 
			setVehicleEngineState (randcar13, true )
			setVehicleOverrideLights (randcar13, 2 )
			setElementVelocity(randcar13,randvelo2,0,-0.5)
			setTimer(destroyElement,3999,1,randcar13)
randcar14 = createVehicle(randveh5,-1760.2214355469,921.00091552734,24.8421875,0,0,270)
			setElementData (randcar14, 'race.collideothers', 1 )
    			setElementSyncer(randcar14,vehiclesync) 
			setVehicleEngineState (randcar14, true )
			setVehicleOverrideLights (randcar14, 2 )
			setElementVelocity(randcar14,randvelo3,0,-0.5)
			setTimer(destroyElement,3999,1,randcar14)
randcar15 = createVehicle(randveh6,-1749.4949951172,919.34130859375,24.8421875,0,0,270)
			setElementData (randcar15, 'race.collideothers', 1 )
    			setElementSyncer(randcar15,vehiclesync) 
			setVehicleEngineState (randcar15, true )
			setVehicleOverrideLights (randcar15, 2 )
			setElementVelocity(randcar15,randvelo4,0,-0.5)
			setTimer(destroyElement,3999,1,randcar15)
end
setTimer (mveh3,6000, 40)

addEventHandler ( "onResourceStart", getRootElement(),mveh1,mveh2,mveh3)