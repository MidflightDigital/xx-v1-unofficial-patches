local t = Def.ActorFrame{
};

setenv("FixStage",0)

t[#t+1] = Def.ActorFrame{
  LoadActor(THEME:GetPathB("","ScreenLogo underlay/XX.png")) .. {
    InitCommand=cmd(Center);
    OnCommand=cmd(x,SCREEN_CENTER_X+360);
  };
  LoadActor(THEME:GetPathB("","ScreenLogo underlay/starlight.png")) .. {
    InitCommand=cmd(xy,_screen.cx-20,_screen.cy+10);
  };
  LoadActor(THEME:GetPathB("","ScreenLogo underlay/thefinal.png")) .. {
      InitCommand=function(s) s:xy(_screen.cx-104,_screen.cy+80) end,
    };
  LoadActor(THEME:GetPathB("","ScreenLogo underlay/main.png")) .. {
    InitCommand=cmd(xy,_screen.cx-100,_screen.cy-90);
  };
};

t[#t+1] = LoadActor(THEME:GetPathB("","ScreenTitleJoin underlay/_press start"))..{
  InitCommand=function(s) s:xy(_screen.cx,_screen.cy+340):diffuseshift():effectcolor1(Color.White):effectcolor2(color("#B4FF01")) end,
  OffCommand=cmd(linear,0.1;diffusealpha,0);
};

return t;
