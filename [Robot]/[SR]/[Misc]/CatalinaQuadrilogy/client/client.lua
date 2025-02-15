local CatalinaQuadrilogy = {
    blips = {
        tanker_commander = Blip(651.7, -559.8, 15, 52),
        small_town_bank = Blip(2299, -12.6, 25, 52),
        liquor_store = Blip(248.8, -66.6, 0, 52),
        against_all_odds = Blip(1292.8, 269.3, 18, 52)
    },
    markers = {
        tanker_commander = Marker(651.7, -559.8, 15, 'cylinder', 3, 255, 0, 0, 128),
        small_town_bank = Marker(2299, -12.6, 25, 'cylinder', 3, 255, 0, 0, 128),
        liquor_store = Marker(248.8, -66.6, 0, 'cylinder', 3, 255, 0, 0, 128),
        against_all_odds = Marker(1292.8, 269.3, 18, 'cylinder', 3, 255, 0, 0, 128)
    },
    current_mission = nil,
    progress = {}
}

CatalinaQuadrilogy.onClientResourceStart = function()
    local sW, sH = GuiElement.getScreenSize()
    local w = 684 / sW
    local h = 169 / sH
    local x = 0.5 - (w / 2)
    local y = 0.5 - (h / 2)
    CatalinaQuadrilogy.mission_passed = GuiStaticImage(x, y, w, h, 'img/mission_passed.png', true)
    CatalinaQuadrilogy.mission_passed.alpha = 0
    CatalinaQuadrilogy.mission_passed.visible = false
end
addEventHandler('onClientResourceStart', resourceRoot, CatalinaQuadrilogy.onClientResourceStart)

CatalinaQuadrilogy.onClientScreenFadedIn = function(mapinfo) -- Hide checkpoint marker
    for i, v in pairs(Element.getAllByType('blip')) do
        if v.position.x == 872 and v.position.y == -21 and v.position.z == 180 then
            v.visibleDistance = 0
        end
    end
end
addEvent('onClientScreenFadedIn')
addEventHandler('onClientScreenFadedIn', resourceRoot, CatalinaQuadrilogy.onClientScreenFadedIn)

CatalinaQuadrilogy.updateBlips = function()
    for i, blip in pairs(CatalinaQuadrilogy.blips) do
        blip.visibleDistance = (CatalinaQuadrilogy.current_mission or CatalinaQuadrilogy.progress[i]) and 0 or 65535
    end
    for i, marker in pairs(CatalinaQuadrilogy.markers) do
        local alpha = (CatalinaQuadrilogy.current_mission or CatalinaQuadrilogy.progress[i]) and 0 or 128
        marker:setColor(255, 0, 0, alpha)
    end
end

CatalinaQuadrilogy.startMission = function(missionID)
    CatalinaQuadrilogy.current_mission = missionID

    CatalinaQuadrilogy.updateBlips()
end
addEvent('cat_quad:start_mission', true)
addEventHandler('cat_quad:start_mission', resourceRoot, CatalinaQuadrilogy.startMission)

CatalinaQuadrilogy.endMission = function(missionID, success)
    if success then
        CatalinaQuadrilogy.progress[missionID] = true

        local sound = playSound('audio/mission_accomplished.mp3')
        if isElement(sound) then
            sound.volume = 0.5
        end

        if isTimer(CatalinaQuadrilogy.mission_passed_timer) then
            CatalinaQuadrilogy.mission_passed_timer:destroy()
        end
        CatalinaQuadrilogy.mission_passed_timer =
            Timer(
            function()
                CatalinaQuadrilogy.mission_passed.alpha = CatalinaQuadrilogy.mission_passed.alpha + 0.1
                CatalinaQuadrilogy.mission_passed.visible = true

                local _, left = CatalinaQuadrilogy.mission_passed_timer:getDetails()
                if left == 1 then
                    CatalinaQuadrilogy.mission_passed_timer =
                        Timer(
                        function()
                            CatalinaQuadrilogy.mission_passed_timer =
                                Timer(
                                function()
                                    CatalinaQuadrilogy.mission_passed.alpha =
                                        CatalinaQuadrilogy.mission_passed.alpha - 0.1

                                    if CatalinaQuadrilogy.mission_passed.alpha <= 0 then
                                        CatalinaQuadrilogy.mission_passed.visible = false
                                    end

                                    local _, left = CatalinaQuadrilogy.mission_passed_timer:getDetails()
                                    if left == 1 then
                                        CatalinaQuadrilogy.mission_passed_timer = nil
                                    end
                                end,
                                50,
                                10
                            )
                        end,
                        8000,
                        1
                    )
                end
            end,
            50,
            10
        )
    end

    CatalinaQuadrilogy.current_mission = nil

    CatalinaQuadrilogy.updateBlips()
end
addEvent('cat_quad:end_mission', true)
addEventHandler('cat_quad:end_mission', resourceRoot, CatalinaQuadrilogy.endMission)

CatalinaQuadrilogy.playSFX = function(container, bank, id)
    local sound = playSFX(container, bank, id) -- Catalina "I cannot love a stupid man"
    if isElement(sound) then
        sound.volume = 0.5
        sound:setEffectEnabled('compressor', true)
    end
end
addEvent('cat_quad:play_sfx', true)
addEventHandler('cat_quad:play_sfx', resourceRoot, CatalinaQuadrilogy.playSFX)
