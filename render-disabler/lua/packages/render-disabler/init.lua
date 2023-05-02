import( gpm.LuaPackageExists( "packages/glua-extensions" ) and "packages/glua-extensions" or "https://github.com/Pika-Software/glua-extensions" )

local util_ScreenResolution = util.ScreenResolution
local packageName = gpm.Package:GetIdentifier()
local surface = surface
local cam = cam

surface.CreateFont( packageName, {
    ["font"] = "Roboto",
    ["size"] = 32,
    ["weight"] = 500,
    ["extended"] = true
} )

local status = system.HasFocus()
hook.Add( "WindowFocusChanged", packageName, function( newStatus )
    status = newStatus
end )

local text = "Render is disabled."

hook.Add( "RenderScene", packageName, function()
    if status then return end

    cam.Start2D()
        surface.SetTextColor( 255, 255, 255 )

        surface.SetFont( packageName )

        local textWidth, textHeight = surface.GetTextSize( text )
        local width, height = util_ScreenResolution()

        surface.SetTextPos( ( width - textWidth ) / 2, ( height - textHeight) / 2 )
        surface.DrawText( text )
    cam.End2D()

    return true
end )