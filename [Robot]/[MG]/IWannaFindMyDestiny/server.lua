uniqueKey = tostring(getResourceName(getThisResource()))
resourceRoot = getResourceRootElement(getThisResource())

function raceState(newstate,oldstate)
	setElementData(resourceRoot,uniqueKey.."raceState",newstate)
	if (newstate == "GridCountdown") then
		outputChatBox("Beware - any damage to your vehicle is instant death! Good luck!",root,255,0,0)
	end
end
addEvent ( "onRaceStateChanging", true )
addEventHandler ( "onRaceStateChanging", getRootElement(), raceState )

--moving spikes--
	function startmove1 ()
		spike1 = createObject (2386, 5343.5, -3611, 19, 0, 0, 0)
		spike2 = createObject (2386, 5339.5, -3584, 19, 0, 0, 0)
		setElementData(spike1, "killontouch", true)
		setElementData(spike2, "killontouch", true)
		move1 ()
	end
	addEventHandler ("onResourceStart", resourceRoot, startmove1)

		function move1 ()
			moveObject (spike1, 2000, 5343.5, -3584, 19, 0, 0, 0)
			moveObject (spike2, 2000, 5339.5, -3611, 19, 0, 0, 0)
			setTimer (move2, 2000, 1)
		end

		function move2 ()
			moveObject (spike1, 2000, 5343.5, -3611, 19, 0, 0, 0)
			moveObject (spike2, 2000, 5339.5, -3584, 19, 0, 0, 0)
			setTimer (move1, 2000, 1)
		end



--moving platform--
	function startmove2 ()
		platform1 = createObject (2388, 5325.38, -3578.40, 16.37, 0, 0, 0)
		platform2 = createObject (2388, 5325.38, -3611.19, 16.37, 0, 0, 0)
		move3 ()
	end
	addEventHandler ("onResourceStart", resourceRoot, startmove2)

		function move3 ()
			moveObject (platform1, 10000, 5325.38, -3611.19, 16.37, 0, 0, 0)
			moveObject (platform2, 10000, 5325.38, -3578.40, 16.37, 0, 0, 0)
			setTimer (move4, 11000, 1)
		end

		function move4 ()
			moveObject (platform1, 10000, 5325.38, -3578.40, 16.37, 0, 0, 0)
			moveObject (platform2, 10000, 5325.38, -3611.19, 16.37, 0, 0, 0)
			setTimer (move3, 11000, 1)
		end


--circle bridge--
	function startmove3 ()
		ring1 = createObject (2390, 5368.11, -3604, 27.087, 0, 0, 0)
		ring2 = createObject (2390, 5368.11, -3602, 27.087, 0, 0, 0)
		ring3 = createObject (2390, 5368.11, -3600, 27.087, 0, 0, 0)
		ring4 = createObject (2390, 5368.11, -3598, 27.087, 0, 0, 0)
		ring5 = createObject (2390, 5368.11, -3596, 27.087, 0, 0, 0)
		setElementData(ring1, "killontouch", true)
		setElementData(ring2, "killontouch", true)
		setElementData(ring3, "killontouch", true)
		setElementData(ring4, "killontouch", true)
		setElementData(ring5, "killontouch", true)
		move5 ()
	end
	addEventHandler ("onResourceStart", resourceRoot, startmove3)

		function move5 ()
			moveObject (ring1, 2000, 5368.11, -3604, 24, 0, 0, 0)
			moveObject (ring2, 2000, 5368.11, -3602, 24, 0, 0, 0)
			moveObject (ring3, 2000, 5368.11, -3600, 24, 0, 0, 0)
			moveObject (ring4, 2000, 5368.11, -3598, 24, 0, 0, 0)
			moveObject (ring5, 2000, 5368.11, -3596, 24, 0, 0, 0)
			setTimer (move6, 2000, 1)
		end

		function move6 ()
			moveObject (ring1, 2000, 5368.11, -3604, 27.087, 0, 0, 0)
			moveObject (ring2, 2000, 5368.11, -3602, 27.087, 0, 0, 0)
			moveObject (ring3, 2000, 5368.11, -3600, 27.087, 0, 0, 0)
			moveObject (ring4, 2000, 5368.11, -3598, 27.087, 0, 0, 0)
			moveObject (ring5, 2000, 5368.11, -3596, 27.087, 0, 0, 0)
			setTimer (move5, 2000, 1)
		end

--rotating barrels--
	function startmove4 ()
		barrel1 = createObject (2383, 5222.8510742188, -3588.6748046875, 27.237800598145, 0, 0, 0)
		barrel2 = createObject (2383, 5215.7265625, -3595.1997070313, 27.237800598145, 0, 0, 0)
		setElementData(barrel1, "killontouch", true)
		setElementData(barrel2, "killontouch", true)
		move7 ()
	end
	addEventHandler ("onResourceStart", resourceRoot, startmove4)

		function move7 ()
			moveObject (barrel1, 750, 5222.8510742188, -3595.1997070313, 27.237800598145, 0, 0, 0)
			moveObject (barrel2, 750, 5215.7265625, -3588.6748046875, 27.237800598145, 0, 0, 0)
			setTimer (move8, 750, 1)
		end

		function move8 ()
			moveObject (barrel1, 750, 5215.7265625, -3595.1997070313, 27.237800598145, 0, 0, 0)
			moveObject (barrel2, 750, 5222.8510742188, -3588.6748046875, 27.237800598145, 0, 0, 0)
			setTimer (move9, 750, 1)
		end

		function move9 ()
			moveObject (barrel1, 750, 5215.7265625, -3588.6748046875, 27.237800598145, 0, 0, 0)
			moveObject (barrel2, 750, 5222.8510742188, -3595.1997070313, 27.237800598145, 0, 0, 0)
			setTimer (move10, 750, 1)
		end
		function move10 ()
			moveObject (barrel1, 750, 5222.8510742188, -3588.6748046875, 27.237800598145, 0, 0, 0)
			moveObject (barrel2, 750, 5215.7265625, -3595.1997070313, 27.237800598145, 0, 0, 0)
			setTimer (move7, 750, 1)
		end



--4 barrels--
	function startmove5 ()
		barrel3 = createObject (2383, 5174.767578125, -3598.7478027344, 27.237800598145, 0, 0, 0)
		barrel4 = createObject (2383, 5174.767578125, -3595.8979492188, 27.237800598145, 0, 0, 0)
		barrel5 = createObject (2383, 5171.892578125, -3588.0480957031, 27.237800598145, 0, 0, 0)
		barrel6 = createObject (2383, 5171.892578125, -3585.0979003906, 27.237800598145, 0, 0, 0)
		setElementData(barrel3, "killontouch", true)
		setElementData(barrel4, "killontouch", true)
		setElementData(barrel5, "killontouch", true)
		setElementData(barrel6, "killontouch", true)
		move11 ()
	end
	addEventHandler ("onResourceStart", resourceRoot, startmove5)

		function move11 ()
			moveObject (barrel3, 1500, 5174.767578125, -3588.1223144531, 27.237800598145, 0, 0, 0)
			moveObject (barrel4, 1500, 5174.767578125, -3585.1975097656, 27.237800598145, 0, 0, 0)
			moveObject (barrel5, 1500, 5171.892578125, -3598.4729003906, 27.237800598145, 0, 0, 0)
			moveObject (barrel6, 1500, 5171.892578125, -3595.84765625, 27.237800598145, 0, 0, 0)
			setTimer (move12, 1500, 1)
		end

		function move12 ()
			moveObject (barrel3, 1500, 5174.767578125, -3598.7478027344, 27.237800598145, 0, 0, 0)
			moveObject (barrel4, 1500, 5174.767578125, -3595.8979492188, 27.237800598145, 0, 0, 0)
			moveObject (barrel5, 1500, 5171.892578125, -3588.0480957031, 27.237800598145, 0, 0, 0)
			moveObject (barrel6, 1500, 5171.892578125, -3585.0979003906, 27.237800598145, 0, 0, 0)
			setTimer (move11, 1500, 1)
		end


--10 barrels--
	function startmove6 ()
		barrel7 = createObject (2383, 5038, -3585.3283691406, 27.237800598145, 0, 0, 0)
		barrel8 = createObject (2383, 5034.5, -3585.3283691406, 27.237800598145, 0, 0, 0)
		barrel9 = createObject (2383, 5031, -3585.3283691406, 27.237800598145, 0, 0, 0)
		barrel10 = createObject (2383, 5027.5, -3585.3283691406, 27.237800598145, 0, 0, 0)
		barrel11 = createObject (2383, 5024, -3585.3283691406, 27.237800598145, 0, 0, 0)
		barrel12 = createObject (2383, 5020.5, -3585.3283691406, 27.237800598145, 0, 0, 0)
		barrel13 = createObject (2383, 5017, -3598.6630859375, 27.237800598145, 0, 0, 0)
		barrel14 = createObject (2383, 5013.5, -3598.6630859375, 27.237800598145, 0, 0, 0)
		barrel15 = createObject (2383, 5010, -3598.6630859375, 27.237800598145, 0, 0, 0)
		barrel16 = createObject (2383, 5006.5, -3598.6630859375, 27.237800598145, 0, 0, 0)
		setElementData(barrel7, "killontouch", true)
		setElementData(barrel8, "killontouch", true)
		setElementData(barrel9, "killontouch", true)
		setElementData(barrel10, "killontouch", true)
		setElementData(barrel11, "killontouch", true)
		setElementData(barrel12, "killontouch", true)
		setElementData(barrel13, "killontouch", true)
		setElementData(barrel14, "killontouch", true)
		setElementData(barrel15, "killontouch", true)
		setElementData(barrel16, "killontouch", true)
		move13 ()
	end
	addEventHandler ("onResourceStart", resourceRoot, startmove6)
	

		function move13 ()
			moveObject (barrel7, 1000, 5038, -3598.6630859375, 27.237800598145, 0, 0, 0)
			moveObject (barrel8, 1000, 5034.5, -3598.6630859375, 27.237800598145, 0, 0, 0)
			moveObject (barrel9, 7000, 5031, -3598.6630859375, 27.237800598145, 0, 0, 0)
			moveObject (barrel10, 7000, 5027.5, -3598.6630859375, 27.237800598145, 0, 0, 0)
			moveObject (barrel11, 1000, 5024, -3598.6630859375, 27.237800598145, 0, 0, 0)
			moveObject (barrel12, 1000, 5020.5, -3598.6630859375, 27.237800598145, 0, 0, 0)
			moveObject (barrel13, 7000, 5017, -3585.3283691406, 27.237800598145, 0, 0, 0)
			moveObject (barrel14, 7000, 5013.5, -3585.3283691406, 27.237800598145, 0, 0, 0)
			moveObject (barrel15, 1000, 5010, -3585.3283691406, 27.237800598145, 0, 0, 0)
			moveObject (barrel16, 1000, 5006.5, -3585.3283691406, 27.237800598145, 0, 0, 0)
			setTimer (move14, 2000, 1)
		end

		function move14 ()
			moveObject (barrel7, 1000, 5038, -3585.3283691406, 27.237800598145, 0, 0, 0)
			moveObject (barrel8, 1000, 5034.5, -3585.3283691406, 27.237800598145, 0, 0, 0)
			moveObject (barrel9, 1000, 5031, -3585.3283691406, 27.237800598145, 0, 0, 0)
			moveObject (barrel10, 1000, 5027.5, -3585.3283691406, 27.237800598145, 0, 0, 0)
			moveObject (barrel11, 1000, 5024, -3585.3283691406, 27.237800598145, 0, 0, 0)
			moveObject (barrel12, 1000, 5020.5, -3585.3283691406, 27.237800598145, 0, 0, 0)
			moveObject (barrel13, 1000, 5017, -3598.6630859375, 27.237800598145, 0, 0, 0)
			moveObject (barrel14, 1000, 5013.5, -3598.6630859375, 27.237800598145, 0, 0, 0)
			moveObject (barrel15, 1000, 5010, -3598.6630859375, 27.237800598145, 0, 0, 0)
			moveObject (barrel16, 1000, 5006.5, -3598.6630859375, 27.237800598145, 0, 0, 0)
			setTimer (move13, 2000, 1)
		end


--random eye--
	function startmove7 ()
		eye1 = createObject (2392, 5370.3452148438, -3596.1987304688, 15.97500038147, 90, 0, 14)
		move15 ()
	end
	addEventHandler ("onResourceStart", resourceRoot, startmove7)

		function move15 ()
			moveObject (eye1, 2000, 5374.095703125, -3598.4482421875, 14.47500038147, 0, 0, 0)
			setTimer (move16, 2000, 1)
		end

		function move16 ()
			moveObject (eye1, 4000, 5361.595703125, -3588.9482421875, 20.97500038147, 0, 0, 0)
			setTimer (move17, 4000, 1)
		end

		function move17 ()
			moveObject (eye1, 4000, 5375.845703125, -3589.9482421875, 19.200000762939, 0, 0, 0)
			setTimer (move18, 4000, 1)
		end
		function move18 ()
			moveObject (eye1, 3000, 5370.3452148438, -3596.1987304688, 15.97500038147, 0, 0, 0)
			setTimer (move15, 3000, 1)
		end


--moving tubes--
	function startmove8 ()
		tube1 = createObject (2385, 4946.3095703125, -3587.548828125, 28.273700714111, 0, 90, 0)
		tube2 = createObject (2385, 4946.3095703125, -3596.673828125, 28.273700714111, 0, 90, 0)
		setElementData(tube1, "killontouch", true)
		setElementData(tube2, "killontouch", true)
		move19 ()
	end
	addEventHandler ("onResourceStart", resourceRoot, startmove8)

		function move19 ()
			moveObject (tube1, 750, 4921.189453125, -3587.548828125, 28.273700714111, 0, 0, 0)
			moveObject (tube2, 750, 4921.189453125, -3596.673828125, 28.273700714111, 0, 0, 0)
			setTimer (move20, 750, 1)
		end

		function move20 ()
			moveObject (tube1, 750, 4921.189453125, -3596.673828125, 28.273700714111, 0, 0, 0)
			moveObject (tube2, 750, 4921.189453125, -3587.548828125, 28.273700714111, 0, 0, 0)
			setTimer (move21, 750, 1)
		end

		function move21 ()
			moveObject (tube1, 750, 4946.3095703125, -3596.673828125, 28.273700714111, 0, 0, 0)
			moveObject (tube2, 750, 4946.3095703125, -3587.548828125, 28.273700714111, 0, 0, 0)
			setTimer (move22, 750, 1)
		end
		function move22 ()
			moveObject (tube1, 750, 4946.3095703125, -3587.548828125, 28.273700714111, 0, 0, 0)
			moveObject (tube2, 750, 4946.3095703125, -3596.673828125, 28.273700714111, 0, 0, 0)
			setTimer (move19, 750, 1)
		end

--lift--
	function startmove9 ()
		lift1 = createObject (2381, 4812.6059570313, -3590.970703125, 35.880001068115, 0, 0, 90)
		lift2 = createObject (2381, 4812.6064453125, -3587, 40.979999542236, 0, 0, 90)
		lift3 = createObject (2381, 4812.6064453125, -3593.1706542969, 35.880001068115, 0, 0, 90)
		lift4 = createObject (2381, 4812.6064453125, -3596, 40.979999542236, 0, 0, 90)
		move23 ()
	end
	addEventHandler ("onResourceStart", resourceRoot, startmove9)

		function move23 ()
			moveObject (lift1, 5000, 4812.6064453125, -3590.970703125, 40.979999542236, 0, 0, 0)
			moveObject (lift2, 5000, 4812.6064453125, -3587, 35.880001068115, 0, 0, 0)
			moveObject (lift3, 5000, 4812.6064453125, -3593.1708984375, 40.979999542236, 0, 0, 0)
			moveObject (lift4, 5000, 4812.6064453125, -3596, 35.880001068115, 0, 0, 0)
			setTimer (move24, 6000, 1)
		end

		function move24 ()
			moveObject (lift1, 500, 4812.6064453125, -3587, 40.979999542236, 0, 0, 0)
			moveObject (lift2, 500, 4812.6059570313, -3590.970703125, 35.880001068115, 0, 0, 0)
			moveObject (lift3, 500, 4812.6064453125, -3596, 40.979999542236, 0, 0, 0)
			moveObject (lift4, 500, 4812.6064453125, -3593.1706542969, 35.880001068115, 0, 0, 0)
			setTimer (move25, 1500, 1)
		end

		function move25 ()
			moveObject (lift1, 5000, 4812.6064453125, -3587, 35.880001068115, 0, 0, 0)
			moveObject (lift2, 5000, 4812.6064453125, -3590.970703125, 40.979999542236, 0, 0, 0)
			moveObject (lift3, 5000, 4812.6064453125, -3596, 35.880001068115, 0, 0, 0)
			moveObject (lift4, 5000, 4812.6064453125, -3593.1708984375, 40.979999542236, 0, 0, 0)
			setTimer (move26, 6000, 1)
		end
		function move26 ()
			moveObject (lift1, 500, 4812.6059570313, -3590.970703125, 35.880001068115, 0, 0, 0)
			moveObject (lift2, 500, 4812.6064453125, -3587, 40.979999542236, 0, 0, 0)
			moveObject (lift3, 500, 4812.6064453125, -3593.1706542969, 35.880001068115, 0, 0, 0)
			moveObject (lift4, 500, 4812.6064453125, -3596, 40.979999542236, 0, 0, 0)
			setTimer (move23, 1500, 1)
		end


--spike platform--
	function startmove10 ()
		spike3 = createObject (2386, 4777.0146484375, -3560.427734375, 44.794998168945, 0, 0, 0)
		spike4 = createObject (2386, 4777.0146484375, -3554.0026855469, 44.794998168945, 0, 0, 0)
		platform3 = createObject (2388, 4780.2407226563, -3557.2338867188, 43.645000457764, 0, 0, 0)
		setElementData(spike3, "killontouch", true)
		setElementData(spike4, "killontouch", true)
		move27 ()
	end
	addEventHandler ("onResourceStart", resourceRoot, startmove10)

		function move27 ()
			moveObject (spike3, 5000, 4777.0146484375, -3549.7028808594, 44.794998168945, 0, 0, 0)
			moveObject (spike4, 5000, 4777.0146484375, -3543.2373046875, 44.794998168945, 0, 0, 0)
			moveObject (platform3, 5000, 4780.2412109375, -3546.4833984375, 43.645000457764, 0, 0, 0)
			setTimer (move28, 5000, 1)
		end

		function move28 ()
			moveObject (spike3, 5000, 4777.0146484375, -3560.427734375, 44.794998168945, 0, 0, 0)
			moveObject (spike4, 5000, 4777.0146484375, -3554.0026855469, 44.794998168945, 0, 0, 0)
			moveObject (platform3, 5000, 4780.2407226563, -3557.2338867188, 43.645000457764, 0, 0, 0)
			setTimer (move27, 6000, 1)
		end


--moving platform with spikes--
	function startmove11 ()
		platform4 = createObject (2388, 4741.3208007813, -3571.4404296875, 49.825000762939, 0, 350, 0)	
		move29 ()
	end
	addEventHandler ("onResourceStart", resourceRoot, startmove11)

		function move29 ()
			moveObject (platform4, 3000, 4772.6020507813, -3571.4404296875, 55.424991607666, 0, 0, 0)
			setTimer (move30, 4000, 1)
		end

		function move30 ()
			moveObject (platform4, 3000, 4741.3208007813, -3571.4404296875, 49.825000762939, 0, 0, 0)
			setTimer (move29, 4000, 1)
		end


--spikes fucking everywhere--
	function startmove12 ()
		spike5 = createObject (2386, 4771.0576171875, -3529.5346679688, 64.449996948242, 0, 0, 0)
		spike6 = createObject (2386, 4771.0576171875, -3532.2099609375, 64.449996948242, 0, 0, 0)
		spike7 = createObject (2386, 4771.0576171875, -3534.8591308594, 64.449996948242, 0, 0, 0)
		spike8 = createObject (2386, 4768.3828125, -3534.859375, 64.449996948242, 0, 0, 0)
		spike9 = createObject (2386, 4765.6826171875, -3534.859375, 64.449996948242, 0, 0, 0)
		spike10 = createObject (2386, 4762.8325195313, -3534.859375, 64.449996948242, 0, 0, 0)
		spike11 = createObject (2386, 4762.8330078125, -3532.2094726563, 64.449996948242, 0, 0, 0)
		spike12 = createObject (2386, 4762.8330078125, -3529.5339355469, 64.449996948242, 0, 0, 0)
		setElementData(spike5, "killontouch", true)
		setElementData(spike6, "killontouch", true)
		setElementData(spike7, "killontouch", true)
		setElementData(spike8, "killontouch", true)
		setElementData(spike9, "killontouch", true)
		setElementData(spike10, "killontouch", true)
		setElementData(spike11, "killontouch", true)
		setElementData(spike12, "killontouch", true)
		move31 ()
	end
	addEventHandler ("onResourceStart", resourceRoot, startmove12)

		function move31 ()
			moveObject (spike5, 850, 4771.0576171875, -3532.2099609375, 64.449996948242, 0, 0, 0)
			moveObject (spike6, 850, 4771.0576171875, -3534.8591308594, 64.449996948242, 0, 0, 0)
			moveObject (spike7, 850, 4768.3828125, -3534.859375, 64.449996948242, 0, 0, 0)
			moveObject (spike8, 850, 4765.6826171875, -3534.859375, 64.449996948242, 0, 0, 0)
			moveObject (spike9, 850, 4762.8325195313, -3534.859375, 64.449996948242, 0, 0, 0)
			moveObject (spike10, 850, 4762.8330078125, -3532.2094726563, 64.449996948242, 0, 0, 0)
			moveObject (spike11, 850, 4762.8330078125, -3529.5339355469, 64.449996948242, 0, 0, 0)
			moveObject (spike12, 850, 4765.5581054688, -3529.5341796875, 64.449996948242, 0, 0, 0)
			setTimer (move32, 850, 1)
		end

		function move32 ()
			moveObject (spike5, 850, 4771.0576171875, -3534.8591308594, 64.449996948242, 0, 0, 0)
			moveObject (spike6, 850, 4768.3828125, -3534.859375, 64.449996948242, 0, 0, 0)
			moveObject (spike7, 850, 4765.6826171875, -3534.859375, 64.449996948242, 0, 0, 0)
			moveObject (spike8, 850, 4762.8325195313, -3534.859375, 64.449996948242, 0, 0, 0)
			moveObject (spike9, 850, 4762.8330078125, -3532.2094726563, 64.449996948242, 0, 0, 0)
			moveObject (spike10, 850, 4762.8330078125, -3529.5339355469, 64.449996948242, 0, 0, 0)
			moveObject (spike11, 850, 4765.5581054688, -3529.5341796875, 64.449996948242, 0, 0, 0)
			moveObject (spike12, 850, 4768.2587890625, -3529.5341796875, 64.449996948242, 0, 0, 0)
			setTimer (move33, 850, 1)
		end

		function move33 ()
			moveObject (spike5, 850, 4768.3828125, -3534.859375, 64.449996948242, 0, 0, 0)
			moveObject (spike6, 850, 4765.6826171875, -3534.859375, 64.449996948242, 0, 0, 0)
			moveObject (spike7, 850, 4762.8325195313, -3534.859375, 64.449996948242, 0, 0, 0)
			moveObject (spike8, 850, 4762.8330078125, -3532.2094726563, 64.449996948242, 0, 0, 0)
			moveObject (spike9, 850, 4762.8330078125, -3529.5339355469, 64.449996948242, 0, 0, 0)
			moveObject (spike10, 850, 4765.5581054688, -3529.5341796875, 64.449996948242, 0, 0, 0)
			moveObject (spike11, 850, 4768.2587890625, -3529.5341796875, 64.449996948242, 0, 0, 0)
			moveObject (spike12, 850, 4771.0576171875, -3529.5346679688, 64.449996948242, 0, 0, 0)
			setTimer (move34, 850, 1)
		end

		function move34 ()
			moveObject (spike5, 850, 4765.6826171875, -3534.859375, 64.449996948242, 0, 0, 0)
			moveObject (spike6, 850, 4762.8325195313, -3534.859375, 64.449996948242, 0, 0, 0)
			moveObject (spike7, 850, 4762.8330078125, -3532.2094726563, 64.449996948242, 0, 0, 0)
			moveObject (spike8, 850, 4762.8330078125, -3529.5339355469, 64.449996948242, 0, 0, 0)
			moveObject (spike9, 850, 4765.5581054688, -3529.5341796875, 64.449996948242, 0, 0, 0)
			moveObject (spike10, 850, 4768.2587890625, -3529.5341796875, 64.449996948242, 0, 0, 0)
			moveObject (spike11, 850, 4771.0576171875, -3529.5346679688, 64.449996948242, 0, 0, 0)
			moveObject (spike12, 850, 4771.0576171875, -3532.2099609375, 64.449996948242, 0, 0, 0)
			setTimer (move35, 850, 1)
		end

		function move35 ()
			moveObject (spike5, 850, 4762.8325195313, -3534.859375, 64.449996948242, 0, 0, 0)
			moveObject (spike6, 850, 4762.8330078125, -3532.2094726563, 64.449996948242, 0, 0, 0)
			moveObject (spike7, 850, 4762.8330078125, -3529.5339355469, 64.449996948242, 0, 0, 0)
			moveObject (spike8, 850, 4765.5581054688, -3529.5341796875, 64.449996948242, 0, 0, 0)
			moveObject (spike9, 850, 4768.2587890625, -3529.5341796875, 64.449996948242, 0, 0, 0)
			moveObject (spike10, 850, 4771.0576171875, -3529.5346679688, 64.449996948242, 0, 0, 0)
			moveObject (spike11, 850, 4771.0576171875, -3532.2099609375, 64.449996948242, 0, 0, 0)
			moveObject (spike12, 850, 4771.0576171875, -3534.8591308594, 64.449996948242, 0, 0, 0)
			setTimer (move36, 850, 1)
		end

		function move36 ()
			moveObject (spike5, 850, 4762.8330078125, -3532.2094726563, 64.449996948242, 0, 0, 0)
			moveObject (spike6, 850, 4762.8330078125, -3529.5339355469, 64.449996948242, 0, 0, 0)
			moveObject (spike7, 850, 4765.5581054688, -3529.5341796875, 64.449996948242, 0, 0, 0)
			moveObject (spike8, 850, 4768.2587890625, -3529.5341796875, 64.449996948242, 0, 0, 0)
			moveObject (spike9, 850, 4771.0576171875, -3529.5346679688, 64.449996948242, 0, 0, 0)
			moveObject (spike10, 850, 4771.0576171875, -3532.2099609375, 64.449996948242, 0, 0, 0)
			moveObject (spike11, 850, 4771.0576171875, -3534.8591308594, 64.449996948242, 0, 0, 0)
			moveObject (spike12, 850, 4768.3828125, -3534.859375, 64.449996948242, 0, 0, 0)
			setTimer (move37, 850, 1)
		end

		function move37 ()
			moveObject (spike5, 850, 4762.8330078125, -3529.5339355469, 64.449996948242, 0, 0, 0)
			moveObject (spike6, 850, 4765.5581054688, -3529.5341796875, 64.449996948242, 0, 0, 0)
			moveObject (spike7, 850, 4768.2587890625, -3529.5341796875, 64.449996948242, 0, 0, 0)
			moveObject (spike8, 850, 4771.0576171875, -3529.5346679688, 64.449996948242, 0, 0, 0)
			moveObject (spike9, 850, 4771.0576171875, -3532.2099609375, 64.449996948242, 0, 0, 0)
			moveObject (spike10, 850, 4771.0576171875, -3534.8591308594, 64.449996948242, 0, 0, 0)
			moveObject (spike11, 850, 4768.3828125, -3534.859375, 64.449996948242, 0, 0, 0)
			moveObject (spike12, 850, 4765.6826171875, -3534.859375, 64.449996948242, 0, 0, 0)
			setTimer (move38, 850, 1)
		end

		function move38 ()
			moveObject (spike5, 850, 4765.5581054688, -3529.5341796875, 64.449996948242, 0, 0, 0)
			moveObject (spike6, 850, 4768.2587890625, -3529.5341796875, 64.449996948242, 0, 0, 0)
			moveObject (spike7, 850, 4771.0576171875, -3529.5346679688, 64.449996948242, 0, 0, 0)
			moveObject (spike8, 850, 4771.0576171875, -3532.2099609375, 64.4499969482425, 0, 0, 0)
			moveObject (spike9, 850, 4771.0576171875, -3534.8591308594, 64.449996948242, 0, 0, 0)
			moveObject (spike10, 850, 4768.3828125, -3534.859375, 64.449996948242, 0, 0, 0)
			moveObject (spike11, 850, 4765.6826171875, -3534.859375, 64.449996948242, 0, 0, 0)
			moveObject (spike12, 850, 4762.8325195313, -3534.859375, 64.449996948242, 0, 0, 0)
			setTimer (move39, 850, 1)
		end

		function move39 ()
			moveObject (spike5, 850, 4768.2587890625, -3529.5341796875, 64.449996948242, 0, 0, 0)
			moveObject (spike6, 850, 4771.0576171875, -3529.5346679688, 64.449996948242, 0, 0, 0)
			moveObject (spike7, 850, 4771.0576171875, -3532.2099609375, 64.449996948242, 0, 0, 0)
			moveObject (spike8, 850, 4771.0576171875, -3534.8591308594, 64.449996948242, 0, 0, 0)
			moveObject (spike9, 850, 4768.3828125, -3534.859375, 64.449996948242, 0, 0, 0)
			moveObject (spike10, 850, 4765.6826171875, -3534.859375, 64.449996948242, 0, 0, 0)
			moveObject (spike11, 850, 4762.8325195313, -3534.859375, 64.449996948242, 0, 0, 0)
			moveObject (spike12, 850, 4762.8330078125, -3532.2094726563, 64.449996948242, 0, 0, 0)
			setTimer (move40, 850, 1)
		end

		function move40 ()
			moveObject (spike5, 850, 4771.0576171875, -3529.5346679688, 64.449996948242, 0, 0, 0)
			moveObject (spike6, 850, 4771.0576171875, -3532.2099609375, 64.449996948242, 0, 0, 0)
			moveObject (spike7, 850, 4771.0576171875, -3534.8591308594, 64.449996948242, 0, 0, 0)
			moveObject (spike8, 850, 4768.3828125, -3534.859375, 64.449996948242, 0, 0, 0)
			moveObject (spike9, 850, 4765.6826171875, -3534.859375, 64.449996948242, 0, 0, 0)
			moveObject (spike10, 850, 4762.8325195313, -3534.859375, 64.449996948242, 0, 0, 0)
			moveObject (spike11, 850, 4762.8330078125, -3532.2094726563, 64.449996948242, 0, 0, 0)
			moveObject (spike12, 850, 4762.8330078125, -3529.5339355469, 64.449996948242, 0, 0, 0)
			setTimer (move31, 850, 1)
		end