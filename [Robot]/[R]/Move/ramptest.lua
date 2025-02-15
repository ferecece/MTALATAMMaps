function omg_ramptest()  
	r1 = createObject(18450, 159.96374511719, 2493.6240234375, 7, 0, 350, 0)
	omgMover1(1)
	r2 = createObject(18450, 159.96374511719, 2509.6240234375, 21, 0, 350, 0)
	omgMover2(1)
	r3 = createObject(18450, 450, 2501, 20, 90, 0, 0)
	omgMover3(1)
	r4 = createObject(18450, 837, 1669, 20, -15, 0, 100)
	omgMover4(1)
	r5 = createObject(18450, 851, 1582, 19, 15, 0, 100)
	omgMover5(1)
	r6 = createObject(3374, 1027, 1386, 11, 0, 0, 0)
	r7 = createObject(3374, 1067, 1386, 11, 0, 0, 0)
	r8 = createObject(3374, 1107, 1386, 11, 0, 0, 0)
	r9 = createObject(3374, 1147, 1386, 11, 0, 0, 0)
	omgMover6(1)
	r10 = createObject(3374, 1047, 1361, 11, 0, 0, 0)
	r11 = createObject(3374, 1087, 1361, 11, 0, 0, 0)
	r12 = createObject(3374, 1127, 1361, 11, 0, 0, 0)
	r13 = createObject(3374, 1167, 1361, 11, 0, 0, 0)
	omgMover7(1)
	r14 = createObject(3330, 1403, 1520, 72, 0, 0, 0)
	r15 = createObject(3330, 1375, 1520, -1, 0, 0, 0)
	omgMover8(1)
	r16 = createObject(18450, 1485, 1625, 12, 0, 0, 90)
	r17 = createObject(18450, 1470, 1625, 12, 0, 90, 90)
	omgMover9(1)
	r18 = createObject(1655, 1614, 1250, 10.8, 0, 0, 270)
	r19 = createObject(1655, 1614, 1258, 10.8, 0, 0, 270)
	omgMover10(1)
end
function omgMover1(point)
	if point == 1 then
		moveObject(r1, 3000, 159.96374511719, 2493.6240234375, 21, 0, 0, 0)
		setTimer(omgMover1, 3000, 1, 2)
	elseif point == 2 then
		moveObject(r1, 3000, 159.96374511719, 2493.6240234375, 7, 0, 0, 0)
		setTimer(omgMover1, 3000, 1, 1)
	end
end
function omgMover2(point)
	if point == 1 then
		moveObject(r2, 3000, 159.96374511719, 2509.6240234375, 7, 0, 0, 0)
		setTimer(omgMover2, 3000, 1, 2)
	elseif point == 2 then
		moveObject(r2, 3000, 159.96374511719, 2509.6240234375, 21, 0, 0, 0)
		setTimer(omgMover2, 3000, 1, 1)
	end
end
function omgMover3(point)
	if point == 1 then
		moveObject(r3, 10000, 450, 2501, 20, 0, 0, 360)
		setTimer(omgMover3, 10000, 1, 1)
	end
end
function omgMover4(point)
	if point == 1 then
		moveObject(r4, 3000, 837, 1669, 20, 30, 0, 0)
		setTimer(omgMover4, 3000, 1, 2)
	elseif point == 2 then
		moveObject(r4, 3000, 837, 1669, 20, -30, 0, 0)
		setTimer(omgMover4, 3000, 1, 1)
	end
end
function omgMover5(point)
	if point == 1 then
		moveObject(r5, 3000, 851, 1582, 19, -30, 0, 0)
		setTimer(omgMover5, 3000, 1, 2)
	elseif point == 2 then
		moveObject(r5, 3000, 851, 1582, 19, 30, 0, 0)
		setTimer(omgMover5, 3000, 1, 1)
	end
end
function omgMover6(point)
	if point == 1 then
		moveObject(r6, 3000, 1027, 1361, 11, 0, 0, 0)
		moveObject(r7, 3000, 1067, 1361, 11, 0, 0, 0)
		moveObject(r8, 3000, 1107, 1361, 11, 0, 0, 0)
		moveObject(r9, 3000, 1147, 1361, 11, 0, 0, 0)
		setTimer(omgMover6, 3000, 1, 2)
	elseif point == 2 then
		moveObject(r6, 3000, 1027, 1386, 11, 0, 0, 0)
		moveObject(r7, 3000, 1067, 1386, 11, 0, 0, 0)
		moveObject(r8, 3000, 1107, 1386, 11, 0, 0, 0)
		moveObject(r9, 3000, 1147, 1386, 11, 0, 0, 0)
		setTimer(omgMover6, 3000, 1, 1)
	end
end
function omgMover7(point)
	if point == 1 then
		moveObject(r10, 3000, 1047, 1386, 11, 0, 0, 0)
		moveObject(r11, 3000, 1087, 1386, 11, 0, 0, 0)
		moveObject(r12, 3000, 1127, 1386, 11, 0, 0, 0)
		moveObject(r13, 3000, 1167, 1386, 11, 0, 0, 0)
		setTimer(omgMover7, 3000, 1, 2)
	elseif point == 2 then
		moveObject(r10, 3000, 1047, 1361, 11, 0, 0, 0)
		moveObject(r11, 3000, 1087, 1361, 11, 0, 0, 0)
		moveObject(r12, 3000, 1127, 1361, 11, 0, 0, 0)
		moveObject(r13, 3000, 1167, 1361, 11, 0, 0, 0)
		setTimer(omgMover7, 3000, 1, 1)
	end
end
function omgMover8(point)
	if point == 1 then
		moveObject(r14, 100, 1403, 1520, -1, 0, 0, 0)
		moveObject(r15, 100, 1375, 1520, 72, 0, 0, 0)
		setTimer(omgMover8, 2000, 1, 2)
	elseif point == 2 then
		moveObject(r14, 100, 1403, 1520, 72, 0, 0, 0)
		moveObject(r15, 100, 1375, 1520, -1, 0, 0, 0)
		setTimer(omgMover8, 2000, 1, 1)
	end
end
function omgMover9(point)
	if point == 1 then
		moveObject(r16, 7500, 1485, 1625, 12, 0, -360, 0)
		moveObject(r17, 7500, 1470, 1625, 12, 0, -360, 0)
		setTimer(omgMover9, 7500, 1, 1)
	end
end
function omgMover10(point)
	if point == 1 then
		moveObject(r18, 6000, 1614, 1290, 10.8, 0, 0, 0)
		moveObject(r19, 6000, 1614, 1298, 10.8, 0, 0, 0)
		setTimer(omgMover10, 6000, 1, 2)
	elseif point == 2 then
		moveObject(r18, 6000, 1614, 1250, 10.8, 0, 0, 0)
		moveObject(r19, 6000, 1614, 1258, 10.8, 0, 0, 0)
		setTimer(omgMover10, 6000, 1, 1)
	end
end
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), omg_ramptest)