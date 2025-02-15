local screenWidth, screenHeight = GuiElement.getScreenSize()
local text = false
function onClientRender()
    if not text then
        return
    end

    dxDrawBorderedText(
        2,
        text,
        0,
        0,
        screenWidth,
        screenHeight - screenHeight * (150 / 1080),
        tocolor(255, 255, 255, 255),
        3,
        3,
        'default',
        'center',
        'bottom'
    )
end
addEventHandler('onClientRender', root, onClientRender)

local renderTimer = false
function setText(newText, duration)
    text = newText
    if isTimer(renderTimer) then
        renderTimer:destroy()
    end
    if duration then
        renderTimer =
            Timer(
            function()
                text = false
                renderTimer = false
            end,
            duration,
            1
        )
    end
end
addEvent('cat_quad:set_text', true)
addEventHandler('cat_quad:set_text', resourceRoot, setText)

function dxDrawBorderedText(
    outline,
    text,
    left,
    top,
    right,
    bottom,
    color,
    scale,
    font,
    alignX,
    alignY,
    clip,
    wordBreak,
    postGUI,
    colorCoded,
    subPixelPositioning,
    fRotation,
    fRotationCenterX,
    fRotationCenterY)
    for oX = (outline * -1), outline do
        for oY = (outline * -1), outline do
            dxDrawText(
                text,
                left + oX,
                top + oY,
                right + oX,
                bottom + oY,
                tocolor(0, 0, 0, 255),
                scale,
                font,
                alignX,
                alignY,
                clip,
                wordBreak,
                postGUI,
                colorCoded,
                subPixelPositioning,
                fRotation,
                fRotationCenterX,
                fRotationCenterY
            )
        end
    end
    dxDrawText(
        text,
        left,
        top,
        right,
        bottom,
        color,
        scale,
        font,
        alignX,
        alignY,
        clip,
        wordBreak,
        postGUI,
        colorCoded,
        subPixelPositioning,
        fRotation,
        fRotationCenterX,
        fRotationCenterY
    )
end
