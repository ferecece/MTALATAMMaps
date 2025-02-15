    local randomPickup_vehicleID = 513 -- this is the stuntplane's vehicleID. when you place a stuntplane vehiclechange pickup, then it will give you a random vehicle instead of stuntplane. if not stuntplane, write some other vehicleID here
    local randomVehicleIDS = { 602, 496, 401, 518, 527, 389, 419, 533, 526, 474, 545, 517, 410, 600, 
436, 580, 439, 549, 491, 445, 604, 507, 585, 587, 466, 492, 546, 551, 
516, 467, 426, 547, 405, 409, 550, 566, 540, 421, 529, 485, 552, 431,
438, 437, 574, 420, 525, 408, 416, 433, 427, 490, 528, 407, 544, 470,
598, 596, 597, 599, 432, 601, 428, 499, 609, 498, 524, 532, 578, 486,
406, 573, 455, 588, 403, 423, 414, 443, 515, 531, 456, 422, 482, 605,
530, 418, 572, 582, 413, 440, 543, 583, 478, 554, 536, 575, 534, 567, 
535, 576, 412, 402, 542, 603, 475, 568, 424, 504, 457, 483, 508, 571,
500, 444, 556, 557, 471, 495, 429, 541, 415, 480, 562, 565, 434, 494,
502, 503, 411, 559, 561, 560, 506, 451, 558, 555, 477, 579, 400, 404,
489, 505, 479, 442, 458, 425 } -- these are the random vehicle ids. when you hit the random vehicle pickup, it gives you one of these vehicles.
     
    addEvent("onPlayerPickUpRacePickup", true)
    addEventHandler("onPlayerPickUpRacePickup", getRootElement(),
        function(pickupID, pickupType, vehicleModel)
            if pickupType == "vehiclechange" and vehicleModel == randomPickup_vehicleID then
                setElementModel(getPedOccupiedVehicle(source), randomVehicleIDS[math.random(1, #randomVehicleIDS)])
            end
        end
    )