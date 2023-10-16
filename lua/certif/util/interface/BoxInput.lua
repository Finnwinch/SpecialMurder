return function(PARENT,MESSAGE,font,no_margin)
    include("certif/interface/color.lua")
    local Background = vgui.Create("DPanel",PARENT)
    Background:Dock(TOP)
    if (not no_margin) then
        Background:DockMargin(25,10,25,0)
        Background:SetTall(30)
    end
    function Background:Paint(w,h)
        draw.RoundedBoxEx(12,0,0,w,h,BleuFonce,true,true,true,true)
    end
    local Element = vgui.Create("DTextEntry",Background)
    Element:Dock(FILL)
    Element:SetPlaceholderText(MESSAGE)
    Element:SetPlaceholderColor(Color(255,255,255,200))
    Element:SetTextColor(Color(255, 255, 255))
    Element:SetFont( font || "manage-button")
    Element:SetPaintBackground(false)
    return Element
end