return function(nbConfig,data)
    local Interface_NEW = include("certif/interface/layout/new.lua")
    local Interface_BOX = include("certif/interface/container/config.lua")
    local DFrame = vgui.Create("DFrame")
        DFrame:SetTitle("")
        DFrame:SetSize(ScrW()*0.6,ScrH()*0.6)
        DFrame:Center()
        DFrame:MakePopup()
        DFrame:SetDraggable(false)
        DFrame:ShowCloseButton(true)
        //DFrame.btnClose:SetVisible( false )
	    //DFrame.btnMaxim:SetVisible( false )
	    //DFrame.btnMinim:SetVisible( false )
        function DFrame:Paint() end
    local Interface = vgui.Create("DPanel")
        Interface:SetParent(DFrame)
        Interface:Dock(FILL)
        function Interface:Paint(w,h) 
            draw.RoundedBoxEx(25,0,0,w,h,Color(26,32,44),true,true,true,true)
        end
    local Header = vgui.Create("DPanel")
        Header:SetParent(Interface)
        Header:Dock(TOP)
        Header:SetTall(50)
        function Header:Paint(w,h) 
            draw.RoundedBoxEx(25,0,0,w,h,Color(18,18,18),true,true,false,false) 
        end
    local left = vgui.Create("DPanel")
        left:SetParent(Header) ; left:Dock(LEFT)
        left:SetWide(50)
        function left:Paint() end
    local center = vgui.Create("DLabel")
        center:SetParent(Header)
        center:Dock(FILL)
        center:SetContentAlignment(5)
        center:SetText("Murder - Spécial Édition")
        center:SetFont("title-label")
        center:SetTextColor(Color(255,255,255))
    local right = vgui.Create("DButton")
        right:SetParent(Header)
        right:Dock(RIGHT)
        right:SetWide(50)
        right:SetText("")
        function right:Paint(w,h)
            draw.RoundedBoxEx(25,0,0,w,h,Color(161,57,35),false,true,false,false)
            draw.SimpleText("X","close-button",w/2,h/2,Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
        end
        function right:DoClick() DFrame:Remove() end
    local Footer = vgui.Create("DButton")
        Footer:SetParent(Interface)
        Footer:Dock(BOTTOM)
        Footer:DockMargin(ScrW()*0.6/2-65,0,ScrW()*0.6/2-65,20)
        Footer:SetTall(30)
        Footer:SetText("")
        function Footer:Paint(w,h)
            draw.RoundedBoxEx(25,0,0,w,h,Color(42,186,113),true,true,true,true)
            draw.SimpleText("Nouveau","new-button",w/2,h/2,Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
        end
        function Footer:DoClick()
            DFrame:Remove()
            models = {}
            Interface_NEW()
        end
    Article = vgui.Create("DScrollPanel",Interface)
    Article:Dock(FILL)
    Article:DockMargin(0,15,0,30)
    local vbar = Article:GetVBar() ; vbar:SetWide(5) ; vbar:SetHideButtons(true)
    function vbar:Paint(w, h) draw.RoundedBox(0, 0, 0, w, h, Color(29, 47, 73)) end
    if ( not data ) then return end
    for i = 1, nbConfig do
        local map = data[i].MAP
        MapBox = map
        local vg = data[i].VIEWMODEL_GUN
        local vk = data[i].VIEWMODEL_KNIF
        local wg = data[i].WORLDMODEL_GUN
        local wk = data[i].WORLDMODEL_KNIF
        local p = data[i].PLAYERMODEL
        Interface_BOX(map,vg,vk,wg,wk,p)
    end
end