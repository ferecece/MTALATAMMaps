local ZeroPed
function ServerStart()
	setTimer(function()
		ZeroPed = getElementByID("Zero")
		--setPedGravity(ZeroPed, 0)
		setPedAnimation(ZeroPed, "crib", "ped_console_loop", 10000, true, false, false, true, 0)
		giveWeapon(ZeroPed, 40, 1, true)

		JethroPed = getElementByID("Jethro")
		setPedAnimation(JethroPed, "car", "fixn_car_loop", 10000, true, false, false, true, 0)
	end, 1000, 1)
end
addEventHandler("onResourceStart",root,ServerStart)