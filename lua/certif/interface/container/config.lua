return function(map,vg,vk,wg,wk,p)
    local mode_edit,pointeur,CurrentModel,countModels,Attribute = false, 1, p[1].PLAYERMODEL, 0,{}
    for _,v in ipairs(p) do
        if (v.SELECTED == tostring(1)) then
            countModels = countModels + 1
        end
    end
    if ( countModels == 0 || countModels == #p) then
        countModels = "Tous"
    end
    local BoxInput = include("certif/util/interface/BoxInput.lua")
    local box = Article:Add("DPanel")
        box:Dock(TOP)
        box:SetTall(120)
        box:DockMargin(25,5,25,5)
        function box:Paint(w,h)
            draw.RoundedBoxEx(8,0,0,w,h,Color(29,47,73),true,true,true,true)
        end
        function box:Think()
            net.Receive("EditModeCall",function()
                net.Start("EditModeApplied")
                net.WriteTable(playermodels_data)
                net.WriteString(map)
                net.WriteString(Either(Tvg:GetText()=="",vg,Tvg:GetText()))
                net.WriteString(Either(Tvk:GetText()=="",vk,Tvk:GetText()))
                net.WriteString(Either(Twg:GetText()=="",wg,Twg:GetText()))
                net.WriteString(Either(Twk:GetText()=="",wk,Twk:GetText()))
                net.SendToServer()
            end)
        end
    local section_command = vgui.Create("DPanel",box)
        section_command:Dock(RIGHT)
        section_command:SetWide(75)
        function section_command:Paint() end
    local select = vgui.Create("DButton",section_command)
        select:Dock(TOP)
        select:SetText("")
        select:DockMargin(5,13.5,5,13.5)
        function select:Paint(w,h)
            if ( self:IsHovered()  ) then
                barColor = Color(16,192,104)
                txtColor = Color(197,231,255)
            else
                barColor = Color(42,186,113)
                txtColor = Color(255,255,255)
            end
            draw.RoundedBoxEx(6,0,0,w,h,barColor,true,true,true,true)
            draw.SimpleText("Select","manage-button",w/2,h/2,txtColor,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
        end
        function select:DoClick()
            net.Start("AskChangeMap")
            net.WriteString(map)
            net.SendToServer()
        end
    local edit = vgui.Create("DButton",section_command)
        edit:Dock(TOP)
        edit:SetText("")
        edit:DockMargin(5,0,5,0)
        function edit:Paint(w,h)
            if ( self:IsHovered()  ) then
                barColor = Color(227,203,51)
                txtColor = Color(197,231,255)
            else
                barColor = Color(222,203,81)
                txtColor = Color(255,255,255)
            end
            if (mode_edit) then barColor = Color(222,173,81) end
            draw.RoundedBoxEx(6,0,0,w,h,barColor,true,true,true,true)
            draw.SimpleText("Edition","manage-button",w/2,h/2,txtColor,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
        end
        function edit:DoClick()
            if (mode_edit) then
                net.Start("RequestEdit")
                net.SendToServer()
            else
            end
           mode_edit = not mode_edit
        end
    local del = vgui.Create("DButton",section_command)
        del:Dock(TOP)
        del:SetText("")
        del:DockMargin(5,13.5,5,13.5)
        function del:Paint(w,h)
            if ( self:IsHovered()  ) then
                barColor = Color(185,24,24)
                txtColor = Color(197,231,255)
            else
                barColor = Color(184,56,56)
                txtColor = Color(255,255,255)
            end
            draw.RoundedBoxEx(6,0,0,w,h,barColor,true,true,true,true)
            draw.SimpleText("Delete","manage-button",w/2,h/2,txtColor,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
        end
        function del:DoClick()
            net.Start("AskDelete")
            net.WriteString(map)
            net.SendToServer()
            self:GetParent():GetParent():GetParent():GetParent():Remove()
        end
    local section_Gun = vgui.Create("DPanel",box)   
        section_Gun:Dock(RIGHT)
        section_Gun:SetWide(245)
        function section_Gun:Paint() end
    local label_Gun = vgui.Create("DPanel",section_Gun)
        label_Gun:Dock(TOP)
        label_Gun:DockMargin(80,13.5,80,13.5)
        function label_Gun:Paint(w,h)
            draw.RoundedBoxEx(8,0,0,w,h,Color(25,31,43),true,true,true,true)
            draw.SimpleText("Pistolet","title-attributes-label",w/2,h/2,Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
        end
    local view_Gun = vgui.Create("DPanel",section_Gun)
        view_Gun:Dock(TOP)
        view_Gun:DockMargin(5,0,5,0)
        function view_Gun:Paint(w,h) draw.RoundedBoxEx(8,0,0,w,h,Color(25,31,43),true,true,true,true) end
        Tvg = BoxInput(view_Gun,vg || "ViewGun models","data-attributes-label",true)
        function view_Gun:Think()
            self:SetMouseInputEnabled(mode_edit)
        end
        function Tvg:OnLoseFocus()
            if (self:GetValue()=="") then
                self:SetValue(vg)
            end
            print(self:GetText())
        end
    local world_Gun = vgui.Create("DPanel",section_Gun)
        world_Gun:Dock(TOP)
        world_Gun:DockMargin(5,13.5,5,13.5)
        function world_Gun:Paint(w,h) draw.RoundedBoxEx(8,0,0,w,h,Color(25,31,43),true,true,true,true) end
        Twg = BoxInput(world_Gun,wg || "WorldGun models","data-attributes-label",true)
        function world_Gun:Think()
            self:SetMouseInputEnabled(mode_edit)
        end
    local section_Couteau = vgui.Create("DPanel",box)   
        section_Couteau:Dock(RIGHT)
        section_Couteau:SetWide(245)
        function section_Couteau:Paint() end
    local label_Couteau = vgui.Create("DPanel",section_Couteau)
        label_Couteau:Dock(TOP)
        label_Couteau:DockMargin(80,13.5,80,13.5)
        function label_Couteau:Paint(w,h)
            draw.RoundedBoxEx(8,0,0,w,h,Color(25,31,43),true,true,true,true)
            draw.SimpleText("Couteau","title-attributes-label",w/2,h/2,Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
        end
    local view_Couteau = vgui.Create("DPanel",section_Couteau)
        view_Couteau:Dock(TOP)
        view_Couteau:DockMargin(5,0,5,0)
        function view_Couteau:Paint(w,h) draw.RoundedBoxEx(8,0,0,w,h,Color(25,31,43),true,true,true,true) end
        Tvk = BoxInput(view_Couteau,vk || "ViewKnif models","data-attributes-label",true)
        function view_Couteau:Think()
            self:SetMouseInputEnabled(mode_edit)
        end
    local world_Couteau = vgui.Create("DPanel",section_Couteau)
        world_Couteau:Dock(TOP)
        world_Couteau:DockMargin(5,13.5,5,13.5)
        function world_Couteau:Paint(w,h) draw.RoundedBoxEx(8,0,0,w,h,Color(25,31,43),true,true,true,true) end
        Twk = BoxInput(world_Couteau,wk || "WorldKnif models","data-attributes-label",true)
        function world_Couteau:Think()
            self:SetMouseInputEnabled(mode_edit)
        end
    local section_Models = vgui.Create("DPanel",box)   
        section_Models:Dock(RIGHT)
        section_Models:SetWide(150)
        function section_Models:Paint() end
    local management = vgui.Create("DPanel",section_Models)
        management:Dock(BOTTOM)
        management:DockMargin(5,2,5,7)
        function management:Paint(w,h) draw.RoundedBoxEx(8,0,0,w,h,Color(26,39,58),true,true,true,true) end
    local precedent = vgui.Create("DButton",management)
        precedent:Dock(LEFT)
        precedent:DockMargin(0,0,5,0)
        precedent:SetWide(25)
        precedent:SetText("")
        function precedent:Paint(w,h)
            if (self:IsHovered()) then
                barColor = Color(25,31,43)
                txtColor = Color(197,231,255)
            else
                barColor = Color(27,59,104)
                txtColor = Color(255,255,255)
            end
            draw.RoundedBox(5,0,0,w,h,barColor)
            draw.SimpleText("<","default",w/2,h/2,txtColor,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
        end
        function precedent:DoClick()
            if ( pointeur - 1 <= 0) then pointeur = #p + 1 end
            pointeur = pointeur - 1
            CurrentModel = p[pointeur].PLAYERMODEL
        end
    local prochain = vgui.Create("DButton",management)
        prochain:Dock(RIGHT)
        prochain:DockMargin(5,0,0,0)
        prochain:SetWide(25)
        prochain:SetText("")
        function prochain:Paint(w,h)
            if (self:IsHovered()) then
                barColor = Color(25,31,43)
                txtColor = Color(197,231,255)
            else
                barColor = Color(27,59,104)
                txtColor = Color(255,255,255)
            end
            draw.RoundedBox(5,0,0,w,h,barColor)
            draw.SimpleText(">","default",w/2,h/2,txtColor,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
        end
        function prochain:DoClick()
            if ( pointeur + 1 > #p) then pointeur = 0 end
            pointeur = pointeur + 1
            CurrentModel = p[pointeur].PLAYERMODEL
        end
    local selection = vgui.Create("DButton",management)
        selection:Dock(FILL)
        selection:SetWide(25)
        selection:SetText("")
        function selection:Paint(w,h)
            draw.RoundedBox(5,0,0,w,h,Color(10,10,10))
        end
        function selection:Think()
            self:SetMouseInputEnabled(mode_edit)
        end
        function selection:DoClick()
            if (p[pointeur].SELECTED == tostring(1)) then
                p[pointeur].SELECTED = tostring(0)
            else
                p[pointeur].SELECTED = tostring(1)
            end
            countModels = 0
            for _,v in ipairs(p) do
                if (v.SELECTED == tostring(1)) then
                    countModels = countModels + 1
                end
            end
            if ( countModels == 0 || countModels == #p) then
                countModels = "Tous"
            end
            models_count:SetText(countModels.."\nPlayerModels\nSélectioner")
        end
    local visualisation = vgui.Create("DModelPanel",section_Models)
        visualisation:Dock(FILL)
        visualisation:SetModel(CurrentModel)
        function visualisation:LayoutEntity( Entity ) return end
        local headpos = visualisation.Entity:GetBonePosition(visualisation.Entity:LookupBone("ValveBiped.Bip01_Head1"))
        visualisation:SetLookAt(headpos)
        visualisation:SetCamPos(headpos-Vector(-25, 0, 0))
        visualisation:SetMouseInputEnabled(false)
        visualisation.Entity:SetEyeTarget(headpos-Vector(-15, 0, 0))
        function visualisation:Think()
            if (p[pointeur].SELECTED == tostring(1)) then
                function selection:Paint(w,h) draw.RoundedBox(12,0,0,w,h,Color(183,56,56)) ; draw.SimpleText("Retirer","default", w/2,h/2-1,Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER) end
            else
                function selection:Paint(w,h) draw.RoundedBox(12,0,0,w,h,Color(41,186,112)) ; draw.SimpleText("Valider","default", w/2,h/2-1,Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER) end
            end
            self:SetModel(CurrentModel)
            playermodels_data = p
        end
    
    local section_Index = vgui.Create("DPanel",box)
        section_Index:Dock(FILL)
        function section_Index:Paint() end
    local config = vgui.Create("DPanel",section_Index)
        config:Dock(TOP)
        config:DockMargin(5,13.5,5,13.5)
        config:SetWide(200)
        function config:Paint(w,h)
            draw.RoundedBox(0,0,0,w,h,Color(35,41,57))
            draw.SimpleText(map,"default",w/2,h/2,Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
        end
    models_count = vgui.Create("DLabel",section_Index)
        models_count:Dock(FILL)
        models_count:DockMargin(10,0,5,13.5)
        models_count:SetFont("data-attributes-label")
        models_count:SetText(countModels.."\nPlayerModels\nSélectioner")
end