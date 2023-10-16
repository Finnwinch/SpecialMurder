return function()
    include("certif/interface/color.lua")
    local BoxInput = include("certif/util/interface/BoxInput.lua")
    local ModelsInput = include("certif/util/interface/ModelsInput.lua")
    local DFrame = vgui.Create("DFrame")
        DFrame:SetTitle("")
        DFrame:SetSize(400,420)
        DFrame:Center()
        DFrame:MakePopup()
        DFrame:SetDraggable(false)
        DFrame.btnClose:SetVisible(false)
        DFrame.btnMaxim:SetVisible(false)
        DFrame.btnMinim:SetVisible(false)
        function DFrame:Paint(w,h) 
            draw.RoundedBoxEx(12,0,0,w,h,BleuFonce,true,true,true,true)
        end
    local mp = BoxInput(DFrame,"Map")
    local vg = BoxInput(DFrame,"Viewmodel pour le gun")
    local wg = BoxInput(DFrame,"Worldmodel pour le gun")
    local vk = BoxInput(DFrame,"Viewmodel pour le couteau")
    local wk = BoxInput(DFrame,"Worldmodel pour le couteau")
    local Section = vgui.Create("DPanel", DFrame)
        Section:Dock(FILL)
        Section:DockMargin(10, 10, 10, 0)
        Section:SetTall(30)
        function Section:Paint(w,h) end
    local scrollPanel = vgui.Create("DScrollPanel", Section)
        scrollPanel:Dock(FILL)
    local vbar = scrollPanel:GetVBar() 
        vbar:SetWide(5)
        vbar:SetHideButtons(true)
    ModelsInput(scrollPanel)
    local Validate = vgui.Create("DButton",DFrame)
        Validate:Dock(BOTTOM)
        Validate:SetTall(30)
        Validate:SetText("")
        Validate:DockMargin(DFrame:GetWide()*0.38,10,DFrame:GetWide()*0.38,10)
        function Validate:Paint(w,h)
            draw.RoundedBoxEx(25,0,0,w,h,VertPale,true,true,true,true)
            draw.SimpleText("Save","new-button",w/2,h/2,Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
        end
        function Validate:DoClick()
            DFrame:Remove()
            if (not LocalPlayer():IsSuperAdmin()) then return end
            net.Start("RequestAdd")
            net.WriteTable({
                map = mp:GetText(),
                vg = vg:GetText(),
                wg = wg:GetText(),
                vk = vk:GetText(),
                wk = wk:GetText(),
                models = models
            })
            net.SendToServer()
        end
end