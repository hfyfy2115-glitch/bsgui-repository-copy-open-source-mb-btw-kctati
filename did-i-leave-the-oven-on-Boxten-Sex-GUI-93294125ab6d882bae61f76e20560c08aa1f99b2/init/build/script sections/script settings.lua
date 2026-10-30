










local section={}
section.version=22 local _=




task.wait, task.spawn
local cloneref=cloneref or function(...)return...end

cloneref(game:GetService"TweenService")
local uis=cloneref(game:GetService"UserInputService")

local getgenv=getgenv()or _G
local queueotp=(syn and syn.queue_on_teleport)or queue_on_teleport or(fluxus and fluxus.queue_on_teleport)


local env=getgenv.BSGUI
local mobile=uis.TouchEnabled




local function insert(...)
for _,tbl in ipairs{...}do
table.insert(section,tbl)
end
end



insert{type="separator",title="Script settings"}



local queueconn
function queuescript(state)
if not queueotp then return end
if state then
queueconn=env.stuf.plr.OnTeleport:Connect(function()
queueotp""
end)
else
if queueconn then queueconn:Disconnect()queueconn=nil end
end
end

if not mobile then
insert
{type="binder",title="Toggle interface keybind",desc="Sets the keybind that will toggle the visibility of the interface.",
default="N",

callback=function(key)
env.gear.general.defaultkeybind=key

local key=tostring(env.gear.general.defaultkeybind.Name or env.gear.general.defaultkeybind)
env.stuf.togglebuttonlabel.Text=env.stuf.keynamemapping[key]or key
end
}

end

insert(
{type="toggle",title="Debug mode",desc="Toggles debug mode. Output visible in the Roblox Developer Console.",
default=false,

callback=function(state)
env.gear.general.debugmode=state
end
},

{type="toggle",title="Keep on server switch",desc="Re-executes the script upon switching experiences.",
callback=function(state)
env.gear.general.queueteleport=state
queuescript(state)
end
},

{type="toggle",title="Ignore full Research Twisteds",desc="Ignores every single Twisted in which you already have full Research on when encountering all Twisteds.",
callback=function(state)
env.gear.general.ignoreresearchcompleted=state
end
},

{type="slider",title="Item teleport Y offset",desc="Sets the Y offset of the target item teleport position (In studs).",
min=-5,max=5,
default=-2.5,
step=0.5,

callback=function(value)
env.gear.general.itemtpposyoffset=value
end
},

{type="toggle",title="Force stop extraction when teleporting to machine",desc="Forcefully quits machine extraction when teleporting to a random generator.",
callback=function(state)
env.gear.general.forcequitwhenteleportingtomach=state
end
},

{type="toggle",title="Log execution",desc="Toggles whether you want your script executions to be logged. When this is off, script users with Donor will not be able to join you.",
default=true,

callback=function(state)
env.gear.general.logexecutions=state
end
}
)



insert{type="separator",title="Blacklists"}



insert(
{type="dropdown",title="Item pick up blacklist",desc="Blacklists the selected items from being picked up when using \"Pick up all...\" functions.",
options={"Air Horn","Bandage","Bonbon","Bottle o' Pop","Box o' Chocolates","Chocolate","Eject Button","Extraction Speed Candy","Event Currency","Gumballs","Health Kit","Jawbreaker","Jumper Cable","Pop","Protein Bar","Research Capsule","Skill Check Candy","Smoke Bomb","Speed Candy","Stealth Candy","Tape"},
multiselect=true,

callback=function(selected)
env.gear.general.itempickupblacklist=selected
end
},

{type="dropdown",title="Twisted encounter blacklist",desc="Blacklists the selected Twisteds from being encountered.",
options={"Twisted Astro","Twisted Bassie","Twisted Blot","Twisted Bobette","Twisted Boxten","Twisted Brightney","Twisted Brusha","Twisted Coal","Twisted Cocoa","Twisted Connie","Twisted Cosmo","Twisted Dandy","Twisted Dyle","Twisted Eggson","Twisted Eclipse","Twisted Finn","Twisted Flutter","Twisted Flyte","Twisted Gigi","Twisted Ginger","Twisted Glisten","Twisted Goob","Twisted Gourdy","Twisted Looey","Twisted Pebble","Twisted Poppy","Twisted Razzle & Dazzle","Twisted Ribecca","Twisted Rodger","Twisted Rudie","Twisted Scraps","Twisted Shelly","Twisted Shrimpo","Twisted Soulvester","Twisted Sprout","Twisted Teagan","Twisted Tisha","Twisted Toodles","Twisted Vee","Twisted Yatta"},
multiselect=true,

callback=function(selected)
env.gear.general.encountertwistedblacklist=selected
end
}
)



insert{type="separator",title="Script chat settings"}



insert
{type="toggle",title="Anonymous mode",desc="Toggles whether you want your chat profile to be anonymous in the script's built-in chat system.",
default=true,

callback=function(state)
env.gear.general.anonchat=state
end
}




return section
