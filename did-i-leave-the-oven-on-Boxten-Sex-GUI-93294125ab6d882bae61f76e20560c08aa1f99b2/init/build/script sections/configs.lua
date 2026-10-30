










local section={}
section.version=22 local _=









task.wait, task.spawn
local cloneref=cloneref or function(...)return...end

local https=cloneref(game:GetService"HttpService")

local getgenv=getgenv()or _G
local readfile=(syn and syn.readfile)or readfile
local isfile=(syn and syn.isfile)or isfile
local delfile=(syn and syn.delfile)or delfile
local listfiles=(syn and syn.listfiles)or listfiles

local env=getgenv.BSGUI
local folder=env.folder




local function insert(...)
for _,tbl in ipairs{...}do
table.insert(section,tbl)
end
end

local function updatelabel()
if env.stuf.fileinfolabel then
env.stuf.fileinfolabel.Text=[[
Total configs: ]]..env.filemanager.getconfigcount()..[[

<font color='rgb(130,130,130)' size='11'>All files fetched successfully.</font>

Current executor: ]]..env.funcs.identifyexec()..[[

<font color='rgb(130,130,130)' size='11'>Your executor is supported.</font>
        ]]
end

env.essentials.library.update("Saved configs",{options=env.filemanager.getconfigs()})
end



insert{type="separator",title="File"}



local configname=""

local function checkconfig(config)
config=config or configname

if isfile(env.filemanager.configfolder.."/"..config..".json")then
return true
end
end

insert(
{type="dropdown",title="Saved configs",desc="Your saved configs list.",
options=env.filemanager.getconfigs(),

callback=function(selected)
configname=selected
end
},

{type="input",title="Config name",desc="Input the name of the config to save or load.",
placeholder="Config name",

callback=function(text)
configname=text
end
},

{type="button",title="Save config",desc="Saves the current state of the script to file.",
callback=function()
if not configname or configname==""then
env.funcs.pop"Invalid config name!"

env.funcs.shrimposaid"configssection.configsaved.empty"
return
end

if checkconfig()then
env.funcs.popup("A config with the name \""..configname.."\" already exists. Do you want to override it?","Yes",
function()
local succ,err=pcall(function()env.filemanager.saveconfig(configname)end)

if not succ then
env.funcs.shrimposaid("configssection.configsaved.failed.override",{configname=configname})

env.funcs.shr("CONFIG ERROR!!!: "..err)
else
env.funcs.box("config \""..configname.."\" saved successfully")

env.funcs.shrimposaid("configssection.configsaved.success.override",{configname=configname})
end

updatelabel()
end,"No",nil
)
else
local succ,err=pcall(function()env.filemanager.saveconfig(configname)end)

if not succ then
env.funcs.shrimposaid("configssection.configsaved.failed",{configname=configname})

env.funcs.shr("CONFIG ERROR!!!: "..err)
else
env.funcs.box("config \""..configname.."\" saved successfully")

env.funcs.shrimposaid("configssection.configsaved.success",{configname=configname})
end

updatelabel()
end
end
},

{type="button",title="Load config",desc="Loads the target config.",
callback=function()
if not configname or configname==""then
env.funcs.pop"Invalid config name!"

env.funcs.shrimposaid"configssection.configloaded.empty"
return
end

if not checkconfig()then
env.funcs.pop("Config \""..configname.."\" doesn't exist!")

env.funcs.shrimposaid("configssection.configloaded.notfound",{configname=configname})
return
end

local succ,err=pcall(function()env.filemanager.loadconfig(configname)end)

if not succ then
env.funcs.shrimposaid("configssection.configloaded.failed",{configname=configname})

env.funcs.shr("CONFIG ERROR!!!: "..err)
else
env.funcs.box("config \""..configname.."\" loaded successfully")

env.funcs.shrimposaid("configssection.configloaded.success",{configname=configname})
end
end
},

{type="button",title="Delete config",desc="Deletes the current config.",
callback=function()
if not configname or configname==""then
env.funcs.pop"Invalid config name!"

env.funcs.shrimposaid"configssection.configdeleted.empty"
return
end

if checkconfig()then
env.funcs.popup("Are you sure you want to delete the config \""..configname.."\"? This is irreversable.","Yes",
function()
if not checkconfig()then
env.funcs.pop("Config \""..configname.."\" doesn't exist!")

env.funcs.shrimposaid("configssection.configdeleted.notfound",{configname=configname})
return
end

local succ,err=pcall(function()env.filemanager.deleteconfig(configname)end)

if not succ then
env.funcs.shrimposaid("configssection.configdeleted.failed",{configname=configname})

env.funcs.shr("CONFIG ERROR!!!: "..err)
else
env.funcs.box("config \""..configname.."\" deleted successfully")

env.funcs.shrimposaid("configssection.configdeleted.success",{configname=configname})
end

updatelabel()
end,"No",nil
)
end
end
},

{type="button",title="Delete all configs",desc="Permanently deletes every saved config file.",
callback=function()
env.funcs.popup("Are you sure you want to delete ALL your configs? This is irreversable.","Yes",
function()
local configs=listfiles(folder.."/Configs/")
for _,file in ipairs(configs)do
if file:sub(-5)==".json"then
delfile(file)
end
end

env.funcs.box"all configs wiped successfully"
updatelabel()

env.funcs.shrimposaid"ALL CONFIG FILES HAVE BEEN WIPED."
end,"No",nil
)
end
}
)



insert{type="separator",title="Auto-loading"}



local autoloadData={}
if isfile(env.filemanager.autoloadfile)then
local success,decoded=pcall(https.JSONDecode,https,readfile(env.filemanager.autoloadfile))
if success then autoloadData=decoded end
end

local lobbyautoload=autoloadData[tostring(env.stuf.lobby)]or""
local runautoload=autoloadData[tostring(env.stuf.run)]or""
local roleplayautoload=autoloadData[tostring(env.stuf.roleplay)]or""

insert(
{type="input",title="Auto-load lobby config",desc="Automatically loads the inputted config in lobby.",placeholder="Config name",
default=lobbyautoload,

callback=function(text)
if not checkconfig(text)then
env.funcs.pop("Config \""..text.."\" doesn't exist!")

env.funcs.shrimposaid("configssection.autoconfigset.notfound",{configname=text})
return
end

env.filemanager.autoloadset(env.stuf.lobby,text)

env.funcs.shrimposaid("configssection.autoconfigset.set.lobby",{configname=text})
end
},
{type="input",title="Auto-load run config",desc="Automatically loads the inputted config in a run.",placeholder="Config name",
default=runautoload,

callback=function(text)
if not checkconfig(text)then
env.funcs.pop("Config \""..text.."\" doesn't exist!")

env.funcs.shrimposaid("configssection.autoconfigset.notfound",{configname=text})
return
end

env.filemanager.autoloadset(env.stuf.run,text)

env.funcs.shrimposaid("configssection.autoconfigset.set.run",{configname=text})
end
},
{type="input",title="Auto-load roleplay config",desc="Automatically loads the inputted config in a roleplay server.",placeholder="Config name",
default=roleplayautoload,

callback=function(text)
if not checkconfig(text)then
env.funcs.pop("Config \""..text.."\" doesn't exist!")

env.funcs.shrimposaid("configssection.autoconfigset.notfound",{configname=text})
return
end

env.filemanager.autoloadset(env.stuf.roleplay,text)

env.funcs.shrimposaid("configssection.autoconfigset.set.roleplay",{configname=text})
end
}
)



return section
