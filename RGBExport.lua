-- Convert color into RGB
function RGB(Color)
    return {Color.red,Color.green,Color.blue}
end

-- Believe this just checks to see if a sprite is being worked on
local spr = app.activeSprite
if not spr then
    return app.alert('No active Sprite')
end

-- save RGB to file.txt
function Export(saveLocation)
    local currentPalette = app.activeSprite.palettes[1]
    local paletteSize = #currentPalette
    local rgb = RGB(currentPalette:getColor(2))
    local rgbfile = io.open( saveLocation ,'w')

    for i=1, paletteSize do
        rgb = RGB(currentPalette:getColor(i-1))
        local writestring = '('
        
        for j=1, 3 do
            writestring = writestring .. tostring(rgb[j])
            if j ~= 3 then
                writestring = writestring .. ', '
            end
        end
        if i ~= paletteSize then
            writestring = writestring .. '),\n'
        else
            writestring = writestring .. ')'
        end
        rgbfile:write(writestring)
    end

    rgbfile:close()
end

-- Make Dialogue box
local dlg = Dialog()
dlg:file{
    id="file_path",
    label= ' File Path:',
    open=false,
    save=true,
    filetypes={'txt'}
}
dlg:button{ id="confirm", text="Confirm" }
dlg:button{ id="cancel", text="Cancel" }
dlg:show()

local data = dlg.data
if data.confirm then
    Export(data.file_path)
    app.alert("Saved RGB values to: '" .. data.file_path .. "'")
end
