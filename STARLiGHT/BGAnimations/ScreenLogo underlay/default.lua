return Def.ActorFrame{
  StorageDevicesChangedMessageCommand=function(self, params)
		MemCardInsert()
	end;
  Def.Quad{
    InitCommand=function(s) s:diffuse(color("0,0,0,1")):FullScreen() end,
  };
  LoadActor("../ScreenWithMenuElements background");
  Def.ActorFrame{
    LoadActor("flourish") .. {
      -- Swoosh under the dancer
      InitCommand = function(s) s:xy(_screen.cx,_screen.cy+92):diffusealpha(0.5) end,
      OnCommand=function(s) s:cropright(1):linear(0.3):cropright(0) end,
    };
    LoadActor("streak") .. {
      -- Swoosh behind the logo text
      InitCommand = function(s) s:xy(_screen.cx+25,_screen.cy+8) end,
      OnCommand=function(s) s:cropright(1):linear(0.3):cropright(0) end,
    };
    LoadActor("dancer") .. {
      InitCommand = function(s) s:clearzbuffer(true):xy(_screen.cx-432,_screen.cy+11) end,
        OnCommand=function(s) s:diffusealpha(0):linear(0.3):diffusealpha(1) end,
    };
    LoadActor("spotlight") .. {
      InitCommand = function(s) s:zoomtoheight(_screen.h):xy(_screen.cx-414,_screen.cy) end,
      OnCommand=function(s) s:diffusealpha(0):linear(0.3):diffusealpha(1) end,
    };
  };
  Def.ActorFrame{
    LoadActor("XX.png")..{
      InitCommand=function(s) s:xy(_screen.cx+360,_screen.cy) end,
    };
    LoadActor("starlight.png")..{
      InitCommand=function(s) s:xy(_screen.cx-20,_screen.cy+10) end,
    };
    LoadActor("thefinal.png")..{
      InitCommand=function(s) s:xy(_screen.cx-104,_screen.cy+80) end,
    };
    LoadActor("main.png")..{
      InitCommand=function(s) s:xy(_screen.cx-100,_screen.cy-90) end,
    };
  };
  Def.ActorFrame{
    Def.Quad{
      InitCommand = function(s) s:zoomto(80,504):xy(_screen.cx-562,_screen.cy+4):skewx(3):MaskSource(true) end,
      OnCommand = function(s) s:queuecommand("Animate") end,
      AnimateCommand = function(s) s:x(_screen.cx-562):linear(0.8):addx(1500):sleep(7):queuecommand("Animate") end,
    };
    LoadActor("shine.png") .. {
    -- Using WriteOnFail here allows us to display only what is UNDER the
    -- mask instead of only what is NOT UNDER it.
    InitCommand = function(s) s:xy(_screen.cx+106,_screen.cy+4):MaskDest():ztestmode("ZTestMode_WriteOnFail") end,
    };
  };
  Def.Quad{
    InitCommand=function(s) s:FullScreen():diffuse(color("0,0,0,1")) end,
    OnCommand=function(s) s:diffusealpha(0):sleep(20):linear(0.297):diffusealpha(1) end,
  };
  Def.Sprite{
    InitCommand=function(s) s:xy(_screen.cx,_screen.cy+340):diffuseshift():effectcolor1(Color.White):effectcolor2(color("#B4FF01")) end,
    BeginCommand=function(s) s:queuecommand("Set") end,
    OnCommand=function(s) s:diffusealpha(0):linear(0.2):diffusealpha(1) end,
    CoinInsertedMessageCommand=function(s) s:queuecommand("Set") end,
    SetCommand=function(s)
      local coinmode = GAMESTATE:GetCoinMode()
      if coinmode == 'CoinMode_Free' then
      s:Load(THEME:GetPathB("","ScreenTitleJoin underlay/_press start"))
      else
      if GAMESTATE:EnoughCreditsToJoin() == true then
        s:Load(THEME:GetPathB("","ScreenTitleJoin underlay/_press start"))
      else
        s:Load(THEME:GetPathB("","ScreenTitleJoin underlay/_insert coin"))
      end
      end
    end
    };
    Def.ActorFrame{
      OnCommand=function(self)
        SCREENMAN:GetTopScreen():AddInputCallback(DDRInput(self))
        GAMESTATE:Reset()
      end,
      StartReleaseCommand=function(self)
        if GAMESTATE:EnoughCreditsToJoin() then
          GAMESTATE:JoinInput(self.pn)
          if GAMESTATE:GetCoinMode() ~= "CoinMode_Home" then
            SCREENMAN:GetTopScreen():SetNextScreenName(Branch.StartGame()):StartTransitioningScreen("SM_GoToNextScreen")
          else
            SCREENMAN:GetTopScreen():SetNextScreenName("ScreenTitleMenu"):StartTransitioningScreen("SM_GoToNextScreen")
          end
          SOUND:PlayOnce(THEME:GetPathS("","Common start"))
          self:queuecommand("Anim")
        end
      end;
      MenuRightCommand=function(s)
        SCREENMAN:GetTopScreen():SetNextScreenName("ScreenDemonstration"):StartTransitioningScreen("SM_GoToNextScreen")
        SCREENMAN:GetTopScreen():RemoveInputCallback(DDRInput(self))
      end,
      Def.Quad{
        InitCommand=function(s) s:FullScreen():diffuse(Color.Black):diffusealpha(0) end,
        AnimCommand=function(s) 
            s:linear(0.2):diffusealpha(1):sleep(1)
        end,
      },
    };
    Def.Actor{
      BeginCommand=function(s)
        s:queuecommand("Delay")
      end,
      DelayCommand=function(s) s:sleep(20):queuecommand("SetScreen") end,
      SetScreenCommand=function(s)
        SCREENMAN:GetTopScreen():SetNextScreenName("ScreenDemonstration"):StartTransitioningScreen("SM_GoToNextScreen")
        SCREENMAN:GetTopScreen():RemoveInputCallback(DDRInput(self))
      end,
    };
};
