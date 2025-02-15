function createobjects()
	createRandomMarker()
end
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), createobjects)

vehicles = { 602, 545, 496, 517, 401, 410, 518, 600, 527, 436, 589, 580, 419, 439, 533, 549, 526, 491, 474, 445, 467, 604, 426, 507, 547, 585,
405, 587, 409, 466, 550, 492, 566, 546, 540, 551, 421, 516, 529, 488, 511, 497, 563, 512, 476, 593, 447, 425, 519, 520, 
417, 469, 487, 513, 581, 510, 509, 522, 481, 461, 462, 448, 521, 468, 463, 586, 485, 552, 431, 
438, 437, 574, 420, 525, 408, 416, 596, 433, 597, 427, 599, 490, 432, 528, 601, 407, 428, 544, 523, 470, 598, 499, 588, 609, 403, 498, 514, 524, 
423, 532, 414, 578, 443, 486, 515, 406, 531, 573, 456, 455, 459, 543, 422, 583, 482, 478, 605, 554, 530, 418, 572, 582, 413, 440, 536, 575, 534, 
567, 535, 576, 412, 402, 542, 603, 475, 441, 464, 501, 465, 564, 568, 557, 424, 471, 504, 495, 457, 539, 483, 508, 571, 500, 
444, 556, 429, 411, 541, 559, 415, 561, 480, 560, 562, 506, 565, 451, 434, 558, 494, 555, 502, 477, 503, 579, 400, 404, 489, 505, 479, 442, 458 
}
function createRandomMarker()

if randomMarkerID == 1 then
		randommarker = createMarker(687,-2294,110,"checkpoint",5)
	elseif randomMarkerID == 2 then
		randommarker = createMarker(624,-2356,110,"checkpoint",5)
	elseif randomMarkerID == 3 then
		randommarker = createMarker(561,-2295,110,"checkpoint",5)
	elseif randomMarkerID == 4 then
		randommarker = createMarker(624,-2233,110,"checkpoint",5)	
	elseif randomMarkerID == 5 then
		randommarker = createMarker(663,-2329,110,"checkpoint",5)
	elseif randomMarkerID == 6 then
		randommarker = createMarker(593,-2322,110,"checkpoint",5)
	elseif randomMarkerID == 7 then
		randommarker = createMarker(587,-2260,110,"checkpoint",5)
	elseif randomMarkerID == 8 then
		randommarker = createMarker(658,-2268,110,"checkpoint",5)
	else
		randomMarkerID = math.random(1, 8)
		createRandomMarker()
	end
destroyElement(randommarkerblip)
randommarkerblip = createBlipAttachedTo(randommarker,0,2,0,0,255)

end

function randomMarkerHit( playerCar )
	if getElementType(playerCar) == "vehicle" and getMarkerType(source) == "checkpoint" then
		local previousMarkerID = randomMarkerID
		
		fixVehicle(playerCar)
		
		--local newCarID = (vehicles[math.random(#vehicles)])
		if (getElementModel(playerCar)) == 415 then
			setElementModel(playerCar, 565)
		elseif (getElementModel(playerCar)) == 565 then 
			setElementModel(playerCar, 402)
		elseif (getElementModel(playerCar)) == 402 then  
			setElementModel(playerCar, 605)
		elseif (getElementModel(playerCar)) == 605 then 
			setElementModel(playerCar, 418)
		elseif (getElementModel(playerCar)) == 418 then 
			setElementModel(playerCar, 583)
		elseif (getElementModel(playerCar)) == 583 then 
			setElementModel(playerCar, 425)
		elseif (getElementModel(playerCar)) == 425 then 
			setElementModel(playerCar, 608)
		elseif (getElementModel(playerCar)) == 608 then 
			setElementModel(playerCar, 415)
		end
		
		destroyElement(source)
		randomMarkerID = math.random(1, 8)
		if randomMarkerID == previousMarkerID then
			randomMarkerID = randomMarkerID + 1
		end
		createRandomMarker()
	end
end
addEventHandler("onMarkerHit",getRootElement(),randomMarkerHit)