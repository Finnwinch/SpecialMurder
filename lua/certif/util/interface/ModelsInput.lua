return function(scrollPanel)
    ModelsInput = include("certif/util/interface/ModelsInput.lua")
    local Backgrounnd = vgui.Create("DPanel",scrollPanel)
        Backgrounnd:Dock(TOP)
        Backgrounnd:DockMargin(25,10,25,0)
        Backgrounnd:SetTall(30)
        function Backgrounnd:Paint(w,h) 
            draw.RoundedBoxEx(12,0,0,w,h,BleuFonce,true,true,true,true) 
        end
    local Element = vgui.Create("DTextEntry", Backgrounnd)
        Element:Dock(FILL)
        Element:SetPlaceholderText("Inscriver un model ici")
        Element:SetPlaceholderColor(Color(255,255,255,200))
        Element:SetTextColor(Color(255, 255, 255))
        Element:SetFont("manage-button")
        Element:SetPaintBackground(false)
        function Element:OnLoseFocus()
            for _,v in ipairs(models) do
                if v == Element:GetText() then return end
            end
            table.insert(models,Element:GetText())
        end
        function Element:OnEnter()
            ModelsInput(scrollPanel)
        end
end