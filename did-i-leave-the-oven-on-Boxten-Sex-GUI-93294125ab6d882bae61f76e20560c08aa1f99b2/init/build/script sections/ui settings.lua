










local section={}
section.version=22 local _=




task.wait, task.spawn
local cloneref=cloneref or function(...)return...end

local ts=cloneref(game:GetService"TweenService")

local getgenv=getgenv()or _G


local env=getgenv.BSGUI local _=

env.scriptinfo.script local _=
env.essentials.data.cl.older




local function insert(...)
for _,tbl in ipairs{...}do
table.insert(section,tbl)
end
end



insert{type="separator",title="UI"}



insert(
{type="slider",title="Mainframe UI scale",desc="Adjusts the UI sscale of the mainframe.",
min=0.5,max=2,
default=1,
step=0.1,

callback=function(value)
env.gear.general.mainframescale=value
ts:Create(env.stuf.mainframescale,TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Scale=env.gear.general.mainframescale}):Play()
end
},

{type="slider",title="Button UI scale",desc="Adjusts the UI scale of the buttons.",
min=0.5,max=2,
default=1,
step=0.1,

callback=function(value)
env.gear.general.buttonscale=value
if env.stuf.setbuttonscale then
env.stuf.setbuttonscale(value)
end
end
},

{type="toggle",title="Clear search bar on category switch",desc="Clears the search bar when switching to another category.",
callback=function(state)
env.gear.general.clearsearchbaroncatswitch=state
end
}
)



insert{type="separator",title="Toons"}



insert(
{type="toggle",title="Alternate Boxten personality",desc="Changes Boxten's way of speaking and makes him talk like how he actually talks.",
callback=function(state)
env.gear.toons.nicerboxten=state
end
},

{type="toggle",title="Closed captions for Boxten",desc="Enables subtitles for Boxten.",
callback=function(state)
env.gear.toons.closedcaptions.boxten=state
end
},

{type="toggle",title="Live Poppy reaction",desc="Allows Poppy to react to your gameplay.",
callback=function(state)
env.gear.toons.livepoppyreaction=state
end
},

{type="toggle",title="Closed captions for Poppy",desc="Enables subtitles for Poppy.",
callback=function(state)
env.gear.toons.closedcaptions.poppy=state
end
},

{type="toggle",title="Live Shrimpo reaction",desc="Allows Shrimpo to react to your gameplay.",
callback=function(state)
env.gear.toons.liveshrimporeaction=state
end
},

{type="toggle",title="Closed captions for Shrimpo",desc="Enables subtitles for Shrimpo.",
callback=function(state)
env.gear.toons.closedcaptions.shrimpo=state
end
}
)



return section
