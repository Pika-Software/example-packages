install( "packages/glua-extensions", "https://github.com/Pika-Software/glua-extensions" )

local fontName = gpm.Package:GetIdentifier( "Font" )
local util_ScreenResolution = util.ScreenResolution
local surface = surface
local cam = cam

surface.CreateFont( fontName, {
    ["font"] = "Roboto",
    ["size"] = 32,
    ["weight"] = 500,
    ["extended"] = true
} )

local status = system.HasFocus()
hook.Add( "WindowFocusChanged", "FocusChanged", function( newStatus )
    status = newStatus
end )

local text = "Render is disabled."

hook.Add( "RenderScene", "Rendering", function()
    if status then return end

    cam.Start2D()
        surface.SetTextColor( 255, 255, 255 )

        surface.SetFont( fontName )

        local textWidth, textHeight = surface.GetTextSize( text )
        local width, height = util_ScreenResolution()

        surface.SetTextPos( ( width - textWidth ) / 2, ( height - textHeight) / 2 )
        surface.DrawText( text )
    cam.End2D()

    return true
end )