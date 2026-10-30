










local section={}
section.version=22




local cloneref=cloneref or function(...)return...end

local https=cloneref(game:GetService"HttpService")
local mps=cloneref(game:GetService"MarketplaceService")
local lcs=cloneref(game:GetService"LocalizationService")
local tps=cloneref(game:GetService"TeleportService")

local getgenv=(syn and syn.getgenv)or getgenv()or _G
local request=getgenv.unsaferequest or(syn and syn.request)or request
local req=(syn and syn.request)or(http and http.request)or request
local identifyexecutor=(syn and syn.identifyexecutor)or identifyexecutor
local writefile=(syn and syn.writefile)or writefile
local isfile=(syn and syn.isfile)or isfile
local readfile=(syn and syn.readfile)or readfile

local env=getgenv.BSGUI
local folder=env.folder




local function insert(...)
for _,tbl in ipairs{...}do
table.insert(section,tbl)
end
end

function getmembercount(inv)
if not req then return"???"end

local success,res=pcall(function()
return req{
Url=("https://discord.com/api/v10/invites/%s?with_counts=true"):format(inv),
Method="GET"
}
end)

if success and res and res.Body then
local data=https:JSONDecode(res.Body)
if data and data.approximate_member_count then
return tostring(data.approximate_member_count)
end
end

return"???"
end



insert{type="separator",title="Community"}



insert(
{type="button",title="Join Noxious Discord",desc=("Copies our server's Discord invite link. (Members: %s)"):format(getmembercount"m2K7UXcyZj"),
commandcat="Main",

command="noxiousdiscord",
aliases={"discord"},
commanddesc="Copies our server's Discord invite link",

callback=function()
env.funcs.copytoclipboard"https://discord.gg/m2K7UXcyZj"
end
},

{type="button",title="Join Bookclub Discord",desc=("Copies Bookclub / Riddance's Discord invite link. (Members: %s)"):format(getmembercount"hbHEv8QvE9"),
commandcat="Main",

command="bookclubdiscord",
aliases={"riddancediscord"},
commanddesc="Copies Bookclub / Riddance's Discord invite link",

callback=function()
env.funcs.copytoclipboard"https://discord.gg/hbHEv8QvE9"
end
}
)



insert{type="separator",title="Interface"}



insert(
{type="button",title="Reposition interface",desc="Repositions the interface back into the center of the screen.",
commandcat="Main",

command="repositionui",
aliases={"reposui"},
commanddesc="Repositions the interface back into the center of the screen",

callback=function()
env.essentials.library.centerui(env.stuf.mainframe)
end
},

{type="toggle",title="Lock interface",desc="Toggles the ability to drag the interface.",
commandcat="Main",

encommands={"lockui"},
enaliases={"lui"},
encommanddesc="Prevents the interface from being dragged",

discommands={"unlockui"},
disaliases={"unlui"},
discommanddesc="Makes the interface draggable again",

callback=function(state)
env.stuf.mainframedrag.draggable=not state
end
},

{type="toggle",title="Lock toggle button",desc="Toggles the ability to drag the toggle button.",
commandcat="Main",

encommands={"locktogglebutton"},
enaliases={"ltb"},
encommanddesc="Prevents the toggle button from being dragged",

discommands={"unlocktogglebutton"},
disaliases={"unltb"},
discommanddesc="Makes the toggle button draggable again",

callback=function(state)
env.stuf.togglebuttondrag.draggable=not state
if state then
env.stuf.togglebuttondrag.dragged=false
end
end
},

{type="toggle",title="Hide toggle button",desc="Hides the toggle button.",
commandcat="Main",

encommands={"hidetogglebutton"},
enaliases={"htb"},
encommanddesc="Hides the toggle button",

discommands={"showtogglebutton"},
disaliases={"stb"},
discommanddesc="Shows the toggle button",

callback=function(state)
env.stuf.togglebutton.Visible=not state
end
},

{type="button",title="Destroy interface",desc="Destroys the interface.",
commandcat="Main",

command="destroyui",
aliases={"noui"},
commanddesc="Destroys the interface",

callback=function()
env.funcs.popup("Are you sure you want to destroy the interface? This is irreversable.","Yes",function()if env.stuf.mainframe then env.stuf.mainframe:Destroy()end if env.stuf.togglebutton then env.stuf.togglebutton:Destroy()end end,"Nevermind",nil)
end
},

{type="button",title="Disconnect all connections",desc="Disconnects all running connections, essentially resetting everything back to normal.",
commandcat="Main",

command="disconnectallconnections",
aliases={"disconnectall","noconns"},
commanddesc="Disconnects all connections",

callback=function()
env.funcs.popup("Are you sure you want to disconnect all connections? This will reset everything to default.","Yes",function()end,"Nevermind",nil)
end
}
)



insert{type="separator",title="Developer"}



insert(
{type="button",title="Notify version",desc="Notifies you the current version of the script.",
commandcat="Main",

command="notifyversion",
aliases={"version"},
commanddesc="Notifies you the current version of the script",

callback=function()
end
},

{type="button",title="Show console",desc="Shows the Roblox Developer Console.",
commandcat="Main",

command="console",
aliases={"c"},
commanddesc="Opens the Roblox Developer Console",

callback=function()
env.funcs.setcore("console",true)
end
}
)



insert{type="separator",title="Server"}



insert(
{type="button",title="Server hop",desc="Joins a different server.",
commandcat="Main",

command="serverhop",
aliases={"shop"},
commanddesc="Joins a different server",

callback=function()
loadstring(game:HttpGet"https://raw.githubusercontent.com/bookworming/bookshelf/refs/heads/main/shelf%204/server%20stuff.lua")():serverhop()
end
},

{type="button",title="Rejoin",desc="Rejoins your current server.",
commandcat="Main",

command="rejoin",
aliases={"rj"},
commanddesc="Rejoins your current server",

callback=function()
loadstring(game:HttpGet"https://raw.githubusercontent.com/bookworming/bookshelf/refs/heads/main/shelf%204/server%20stuff.lua")():rejoin()
end
},

{type="button",title="Rejoin teleport",desc="Rejoins your current server and then teleports you to the same spot you left in.",
commandcat="Main",

command="rejointeleport",
aliases={"rejointp","rjtp"},
commanddesc="Rejoins your current server and then teleports you to the same spot you left in",

callback=function()
loadstring(game:HttpGet"https://raw.githubusercontent.com/bookworming/bookshelf/refs/heads/main/shelf%204/server%20stuff.lua")():rejointeleport()
end
}
)



insert{type="separator",title="Game"}



insert(
{type="button",title="Join lobby",desc="Joins the lobby.",
commandcat="Main",

command="joinlobby",
aliases={"tolobby","jl"},
commanddesc="Joins the lobby",

callback=function()
tps:Teleport(env.stuf.lobby,env.stuf.plr)
end
},

{type="button",title="Join roleplay server",desc="Joins a roleplay server.",
commandcat="Main",

command="joinroleplayserver",
aliases={"toroleplayserver","jrps"},
commanddesc="Joins a roleplay server",

callback=function()
tps:Teleport(env.stuf.roleplay,env.stuf.plr)
end
},

{type="button",title="Join run",desc="Attempts to join a run.",
commandcat="Main",

command="joinrun",
aliases={"torun","jr"},
commanddesc="Attempts to join a run",

callback=function()
tps:Teleport(env.stuf.run,env.stuf.plr)
end
}
)



insert{type="separator",title="Support"}



local PROXY_URL="https://script.google.com/macros/s/AKfycbyki95LBvCthT5iWXz66mZAtxrpbXvI-NoG8iGdVU3OD9whjFsP1l9HGuF6x4HiQGFa/exec"
local PROXY_SECRET="no dick no balls and proabably no butt hole"

local function sendwh(target,content,embed)
embed.color=0x9c309c
local payload={
secret=PROXY_SECRET,
target=target,
content=content,
username="Boxten",
embeds={embed},
avatar_url=env.stuf.profilepictures.boxten,
}
pcall(function()
request{
Url=PROXY_URL,
Method="POST",
Headers={["Content-Type"]="application/json"},
Body=https:JSONEncode(payload)
}
end)

env.funcs.box"attempted to send feedback"
end

local feedbacktype="Note / Comment"
local feedback=""
local feedbackcd=false

insert(
{type="dropdown",title="Feedback type",desc="Indicates the type of feeback to send to us.",
options={"Bug report","Review","Suggestion","Note / Comment"},
default=feedbacktype,
canbeempty=false,

callback=function(selected)
feedbacktype=selected
end
},
{type="input",title="Feedback input",desc="Input your feedback on the script here.",
placeholder="Enter feedback here...",

callback=function(text)
feedback=text
end
},
{type="button",title="Send feedback",desc="Sends the feedback to us.",
callback=function()
if feedbackcd then return end
feedbackcd=true
task.delay(10,function()feedbackcd=false end)

if not feedback or feedback==""then return end
if feedback:find"@"then
string.gsub(feedback,"@"," @")
end

local placeid=game.PlaceId
local jobid=game.JobId

local function detectexecutor()
return identifyexecutor and identifyexecutor()or"Unknown"
end

local success,info=pcall(function()
return mps:GetProductInfo(placeid)
end)

local region=lcs.RobloxLocaleId
local gamename=success and info.Name or"Unknown"
local recognized=placeid==env.stuf.lobby or placeid==env.stuf.run or placeid==env.stuf.rp
local timestamp=os.date"%m/%d/%Y %I:%M %p"

local countfile=folder.."/count.txt"
local execcount=0

if isfile(countfile)then
local content=readfile(countfile)
local num=tonumber(content)
execcount=num or 0
else
execcount=0
end

execcount=execcount+1
writefile(countfile,tostring(execcount))

sendwh("feedback",
env.stuf.displayname.." (@"..env.stuf.user.."): sent feedback from Boxten Sex GUI.",
{
title="Log",
description="This person sent script feedback ("..feedbacktype..") from **Boxten Sex GUI (Version "..env.scriptinfo.script.version..")**.\nTimestamp: `"..timestamp.."`\n[Profile](https://roblox.com/users/"..env.stuf.plr.UserId..") | [Join game](https://www.roblox.com/games/start?placeId="..placeid.."&launchData="..jobid..")",
fields={
{name="Job ID",value="`roblox://placeId="..placeid.."&gameInstanceId="..jobid.."`",inline=false},
{name="Hardware ID",value="`"..game:GetService"RbxAnalyticsService":GetClientId().."`",inline=false},
{name="User info",value="`Account age: "..env.stuf.plr.AccountAge.." days\nExecutor: "..detectexecutor().."\nRegion: "..region.."\nExecution count: "..(tonumber(readfile(countfile))or 0).."`",inline=true},
{name="Game info",value="`Game name: "..gamename.."\nRecognized?: "..tostring(recognized).."`",inline=true},
{name="Feedback",value="```"..feedback.."```",inline=false},
}
}
)
end
}
)



insert(
{type="button",title="Donation (500)",desc="Copies a link to our 500 Robux gamepass. This gamepass will grant you Donor perks in Fun/Donor.",
callback=function()
env.funcs.copytoclipboard"https://www.roblox.com/game-pass/1831859724/Donor"
end
},

{type="button",title="Donation (450)",desc="Copies a link to our 450 Robux gamepass. This gamepass will grant you Donor perks in Fun/Donor.",
callback=function()
env.funcs.copytoclipboard"https://www.roblox.com/game-pass/1837256525/Donor"
end
},

{type="button",title="Donation (400)",desc="Copies a link to our 400 Robux gamepass. This gamepass will grant you Donor perks in Fun/Donor.",
callback=function()
env.funcs.copytoclipboard"https://www.roblox.com/game-pass/1835732858/Donor"
end
},

{type="button",title="Donation (350)",desc="Copies a link to our 350 Robux gamepass. This gamepass will grant you Donor perks in Fun/Donor.",
callback=function()
env.funcs.copytoclipboard"https://www.roblox.com/game-pass/1836212632/Donor"
end
},

{type="button",title="Donation (300)",desc="Copies a link to our 300 Robux gamepass. This gamepass will grant you Donor perks in Fun/Donor.",
callback=function()
env.funcs.copytoclipboard"https://www.roblox.com/game-pass/1832641660/Donor"
end
},

{type="button",title="Donation (250)",desc="Copies a link to our 250 Robux gamepass.",
callback=function()
env.funcs.copytoclipboard"https://www.roblox.com/game-pass/1836458624/Donor"
end
},

{type="button",title="Donation (200)",desc="Copies a link to our 200 Robux gamepass.",
callback=function()
env.funcs.copytoclipboard"https://www.roblox.com/game-pass/1831991654/Donor"
end
},

{type="button",title="Donation (150)",desc="Copies a link to our 150 Robux gamepass.",
callback=function()
env.funcs.copytoclipboard"https://www.roblox.com/game-pass/1836062636/Donor"
end
},

{type="button",title="Donation (100)",desc="Copies a link to our 100 Robux gamepass.",
callback=function()
env.funcs.copytoclipboard"https://www.roblox.com/game-pass/1837142511/Donor"
end
},

{type="button",title="Donation (50)",desc="Copies a link to our 50 Robux gamepass.",
callback=function()
env.funcs.copytoclipboard"https://www.roblox.com/game-pass/1837394479/Donor"
end
}
)



return section
