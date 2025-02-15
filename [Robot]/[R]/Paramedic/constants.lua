g_MAX_PATIENTS_IN_VEHICLE = 3
g_PATIENT_PICKUP_MARKER_SIZE = 7.5
g_SPEED_CHECK_INTERVAL = 1000
g_PICKUP_SPEED_LIMIT = 0.005
g_HOSPITAL_MARKER_SIZE = 5.5

g_NUM_LEVELS = #getElementsByType("checkpoint", resourceRoot)
g_PATIENT_PICKUP_POSITIONS = getElementsByType("patient", resourceRoot)
g_HOSPITAL_POSITIONS = getElementsByType("hospital", resourceRoot)

g_SHOW_PATIENT_EVENT = "showPatient" -- id
g_HIDE_PATIENT_EVENT = "hidePatient" -- id
g_SHOW_HOSPITAL_EVENT = "showHospital" -- id
g_PATIENTS_DROPPED_OFF_EVENT = "droppedOffPatient" -- numDroppedOff
g_PATIENT_PICKED_UP = "pickedUpPatient" -- id
g_AMBULANCE_FULL_EVENT = "ambulanceFull" -- alreadyFull
g_START_SPEEDCHECK_EVENT = "startSpeedcheck" -- time
g_SUCCEED_SPEEDCHECK_EVENT = "succeedSpeedcheck"
g_FAIL_SPEEDCHECK_EVENT = "failSpeedcheck"
g_EXIT_SPEEDCHECK_EVENT = "exitSpeedcheck"
g_CLIENT_SPECTATORED_EVENT = "exploiters be like"

function g_PATIENTS_FOR_LEVEL(level)
	if g_NUM_LEVELS == 1 then return 12 end
	return level
end