










local section={}
section.version=22














local t,spwn=task.wait,task.spawn
local cloneref=cloneref or function(...)return...end

local uis=cloneref(game:GetService"UserInputService")
cloneref(game:GetService"RunService")
cloneref(game:GetService"Players")

local getgenv=getgenv()or _G

local env=getgenv.BSGUI local _=
uis.TouchEnabled




local function insert(...)
for _,tbl in ipairs{...}do
table.insert(section,tbl)
end
end

local usingtwisted=false
local selectedtoon=""
local currentanimpack=""

local nameMap={extracting=
"Decode",idle=
"Idle",walk=
"Walk",run=
"Run",ability=
"Ability",quirk1=
"Quirk",quirk2=
"Quirk2",lostinterest=
"LostInterest",attacking=
"Attack"
}

local function getAnimationObject(key)
local animationsFolder=env.stuf.char:FindFirstChild"Animations"
if not animationsFolder then return nil end

local folderName=nameMap[key:lower()]or key

for _,anim in ipairs(animationsFolder:GetChildren())do
if anim.Name:lower()==folderName:lower()then
return anim
end
end
return nil
end

local function switchanimation(key,toon)
local pack=env.essentials.data.animations[toon]
if not pack then return end

local lookupKey=usingtwisted and("twisted_"..key:lower())or key:lower()
local newId=pack[lookupKey]

if not newId or newId=="unavailable"then return end

local animObject=getAnimationObject(key)
if animObject and animObject:IsA"Animation"then
animObject.AnimationId=newId
end
end

local function stopoldanims(toon)
local humanoid=env.stuf.char:FindFirstChildOfClass"Humanoid"
if not humanoid then return end

local animator=humanoid:FindFirstChildOfClass"Animator"
if not animator then return end

local pack=env.essentials.data.animations[toon]
if not pack then return end

local newids={}
for _,id in pairs(pack)do
if id and id~="unavailable"then
newids[id]=true
end
end

local oldids={}
local animationsFolder=env.stuf.char:FindFirstChild"Animations"
if animationsFolder then
for _,anim in ipairs(animationsFolder:GetChildren())do
if anim:IsA"Animation"then
oldids[anim.AnimationId]=anim.Name
end
end
end

for _,track in ipairs(animator:GetPlayingAnimationTracks())do
local trackId=track.Animation and track.Animation.AnimationId
if trackId and oldids[trackId]and not newids[trackId]then
track:Stop(0.1)
end
end
end

local function refreshanimate()
local humanoid=env.stuf.char:FindFirstChildOfClass"Humanoid"
if humanoid then
local animator=humanoid:FindFirstChildOfClass"Animator"
if animator then
for _,track in ipairs(animator:GetPlayingAnimationTracks())do
track:Stop(0)
end
end
end

local animscript=env.stuf.char:FindFirstChild"Animate"
if animscript then
animscript.Disabled=true
t()
animscript.Disabled=false
end
end

local function applyanimpack(toon)
currentanimpack=toon
local pack=env.essentials.data.animations[toon]
if not pack then return end

stopoldanims(toon)

for key,id in pairs(pack)do
local baseKey=key:gsub("twisted_","")
switchanimation(baseKey,toon)
end

refreshanimate()
end











local activeTracks={}
local animSpeed=1

function env.funcs.playTrack(key,toon,state,loop)
local animObject=getAnimationObject(key)
if not animObject then return end

if activeTracks[key]then
activeTracks[key]:Stop()
activeTracks[key]=nil
end

if state then
switchanimation(key,toon)

local humanoid=env.stuf.char:FindFirstChildOfClass"Humanoid"
if humanoid then
local track=humanoid:LoadAnimation(animObject)
track.Looped=loop or false
track:Play()
track:AdjustSpeed(animSpeed)
activeTracks[key]=track
end
end
end

local oldanims={}

local function saveOriginalAnims()
if not env.stuf.char:FindFirstChild"Animations"then return end
oldanims={}
for _,anim in ipairs(env.stuf.char.Animations:GetChildren())do
if anim:IsA"Animation"then
oldanims[anim.Name]=anim.AnimationId
end
end
end

local function resetanimpack()
for key,track in pairs(activeTracks)do
track:Stop(0)
activeTracks[key]=nil
end

local humanoid=env.stuf.char:FindFirstChildOfClass"Humanoid"
if humanoid then
local animator=humanoid:FindFirstChildOfClass"Animator"
if animator then
for _,track in ipairs(animator:GetPlayingAnimationTracks())do
track:Stop(0)
end
end
end

local animFolder=env.stuf.char:FindFirstChild"Animations"
if animFolder then
for animName,originalId in pairs(oldanims)do
local animObject=animFolder:FindFirstChild(animName)
if animObject and animObject:IsA"Animation"then
animObject.AnimationId=originalId
end
end
end

refreshanimate()
currentanimpack=""
end

if env.funcs.exists()then
saveOriginalAnims()
else
env.stuf.plr.CharacterAdded:Connect(function()
t(0.1)
saveOriginalAnims()
end)
end



insert{type="separator",title="Animation target"}



if env.stuf.inrp then
insert
{type="label",title="Warning",desc="Friendly warning before using animations in roleplay servers.",
content=[[
Playing certain animations on Toons that do not own the animation can result in a kick. ]]
}

end



local toongroups={
[1]={"Astro","Bassie","Blot","Bobette","Boxten","Brightney","Coal","Cocoa","Connie","Eggson","Flyte","Ginger","Gourdy","Looey","Pebble","Razzle","Dazzle","Ribecca","Rudie","Shelly","Soulvester","Sprout","Toodles","Vee","Yatta","Waxwell"},
[2]={"Astro","Brusha","Cosmo","Dyle","Eclipse","Finn","Gigi","Glisten","Goob","Rodger","Shrimpo","Teagan"},
[3]={"Flutter","Scraps","Squirm","Tisha"},
}

local toontogroup={}
for group,toons in ipairs(toongroups)do
for _,toon in ipairs(toons)do
toontogroup[toon]=group
end
end

local function getgroupfortoon(toonname)
if toonname=="RazzleDazzle"or toonname=="Razzle"or toonname=="Dazzle"then
return 1
end
return toontogroup[toonname]or 1
end

local function refreshanimationtargetoptions(toonname)
local group=getgroupfortoon(toonname)
local options=toongroups[group]
env.essentials.elements["Animaton target"].updateOptions(options)
end

insert(
{type="dropdown",title="Animaton target",desc="Sets the Toon you want to play animations from.",
options={"Astro","Bassie","Blot","Bobette","Boxten","Brightney","Brusha","Coal","Cocoa","Connie","Cosmo","Dandy","Dazzle","Dyle","Eggson","Eclipse","Finn","Flutter","Flyte","Gigi","Ginger","Glisten","Goob","Gourdy","Looey","Pebble","Poppy","Razzle","Ribecca","Rodger","Rudie","Scraps","Shelly","Shrimpo","Soulvester","Sprout","Squirm","Teagan","Tisha","Toodles","Vee","Yatta","Waxwell"},

callback=function(selected)
selectedtoon=selected
end
},
{type="toggle",title="Use Twisted",desc="Uses the animations of the Twisted version of the Toon.",
callback=function(state)
usingtwisted=state
if currentanimpack~=""then
applyanimpack(currentanimpack)
end
end
}
)

env.stuf.plr:GetAttributeChangedSignal"ToonName":Connect(function()
local toonname=env.stuf.plr:GetAttribute"ToonName"
if toonname then
refreshanimationtargetoptions(toonname)
end
end)

local initialtoon=env.stuf.plr:GetAttribute"ToonName"
if initialtoon then
refreshanimationtargetoptions(initialtoon)
end



insert{type="separator",title="Animations (Toon)"}



insert(
{type="toggle",title="Apply animation pack",desc="Applies the target Toon's animations onto you.",
callback=function(state)
if state and selectedtoon~=""then
applyanimpack(selectedtoon)
else
resetanimpack()
end
end
},
{type="toggle",title="Play idle animation",desc="Plays the idle animation of the target Toon or Twisted.",
callback=function(state)
env.funcs.playTrack("idle",selectedtoon,state,true)
if not state then
env.funcs.resetanims()
end
end
},
{type="toggle",title="Play walk animation",desc="Plays the walking animation of the target Toon or Twisted.",
callback=function(state)
env.funcs.playTrack("walk",selectedtoon,state,true)
if not state then
env.funcs.resetanims()
end
end
},
{type="toggle",title="Play run animation",desc="Plays the running animation of the target Toon or Twisted.",
callback=function(state)
env.funcs.playTrack("run",selectedtoon,state,true)
if not state then
env.funcs.resetanims()
end
end
},
{type="toggle",title="Play extract animation",desc="Plays the extracting animation of the target Toon.",
callback=function(state)
env.funcs.playTrack("extracting",selectedtoon,state,true)
if not state then
env.funcs.resetanims()
end
end
},
{type="button",title="Play quirk animation",desc="Plays the quirk animation of the target Toon.",
callback=function()
env.funcs.playTrack("quirk1",selectedtoon,true,false)
end
},
{type="toggle",title="Loop quirk animation",desc="Plays the quirk animation of the target Toon in a loop.",
callback=function(state)
env.funcs.playTrack("quirk1",selectedtoon,state,true)
if not state then
env.funcs.resetanims()
end
end
},
{type="button",title="Play ability animation",desc="Plays the ability animation of the target Toon or Twisted.",
callback=function()
env.funcs.playTrack("ability",selectedtoon,true,false)
end
},
{type="toggle",title="Loop ability animation",desc="Plays the ability animation of the target Toon or Twisted in a loop.",
callback=function(state)
env.funcs.playTrack("ability",selectedtoon,state,true)
if not state then
env.funcs.resetanims()
end
end
},
{type="button",title="Play attack animation",desc="Plays the attacking animation of the target Twisted.",
callback=function()
env.funcs.playTrack("attacking",selectedtoon,true,false)
end
},
{type="toggle",title="Loop attack animation",desc="Plays the attacking animation of the target Twisted in a loop.",
callback=function(state)
env.funcs.playTrack("attacking",selectedtoon,state,true)
if not state then
env.funcs.resetanims()
end
end
},
{type="button",title="Play lost interest animation",desc="Plays the lost interest animation of the target Twisted.",
callback=function()
env.funcs.playTrack("lostinterest",selectedtoon,true,false)
end
},
{type="toggle",title="Loop lost interest animation",desc="Plays the lost interest animation of the target Twisted in a loop.",
callback=function(state)
env.funcs.playTrack("lostinterest",selectedtoon,state,true)
if not state then
env.funcs.resetanims()
end
end
}
)



insert{type="separator",title="Animation replacing"}



local replaceTargets={idle="",walk="",run="",extracting="",quirk="",ability=""}
local replaceTwisted={idle=false,walk=false,run=false,ability=false}

local function handleReplacement(category,state,targetToon,isTwisted)
local animObject=getAnimationObject(category)
if not animObject then return end

local folderName=nameMap[category:lower()]or category

if state and targetToon~=""then
local oldTwist=usingtwisted
usingtwisted=isTwisted
switchanimation(category,targetToon)
usingtwisted=oldTwist
else
local originalId=oldanims[folderName]
if originalId then
animObject.AnimationId=originalId
end
end

local humanoid=env.stuf.char:FindFirstChildOfClass"Humanoid"
if humanoid then
for _,track in ipairs(humanoid:GetPlayingAnimationTracks())do
if track.Animation.Name:lower()==folderName:lower()then
track:Stop(0)
end
end
end
end

insert(
{type="dropdown",title="Idle animaton target",desc="Sets the Toon you want to replace your idle animation with.",
options={"Astro","Bassie","Blot","Bobette","Boxten","Brightney","Brusha","Coal","Cocoa","Connie","Cosmo","Dandy","Dazzle","Dyle","Eggson","Eclipse","Finn","Flutter","Flyte","Gigi","Ginger","Glisten","Goob","Gourdy","Looey","Pebble","Poppy","Razzle","Ribecca","Rodger","Rudie","Scraps","Shelly","Shrimpo","Soulvester","Sprout","Squirm","Teagan","Tisha","Toodles","Vee","Yatta","Waxwell"},
callback=function(selected)replaceTargets.idle=selected end
},
{type="toggle",title="Replace current idle animation",desc="Replaces your current idle animation to the target idle animation.",
callback=function(state)
handleReplacement("idle",state,replaceTargets.idle,replaceTwisted.idle)
if not state then
env.funcs.resetanims()
end
end
},
{type="dropdown",title="Walk animaton target",desc="Sets the Toon you want to replace your walking animation with.",
options={"Astro","Bassie","Blot","Bobette","Boxten","Brightney","Brusha","Coal","Cocoa","Connie","Cosmo","Dandy","Dazzle","Dyle","Eggson","Eclipse","Finn","Flutter","Flyte","Gigi","Ginger","Glisten","Goob","Gourdy","Looey","Pebble","Poppy","Razzle","Ribecca","Rodger","Rudie","Scraps","Shelly","Shrimpo","Soulvester","Sprout","Squirm","Teagan","Tisha","Toodles","Vee","Yatta","Waxwell"},
callback=function(selected)replaceTargets.walk=selected end
},
{type="toggle",title="Replace current walk animation",desc="Replaces your current walking animation to the target idle animation.",
callback=function(state)
handleReplacement("walk",state,replaceTargets.walk,replaceTwisted.walk)
if not state then
env.funcs.resetanims()
end
end
},
{type="dropdown",title="Run animaton target",desc="Sets the Toon you want to replace your running animation with.",
options={"Astro","Bassie","Blot","Bobette","Boxten","Brightney","Brusha","Coal","Cocoa","Connie","Cosmo","Dandy","Dazzle","Dyle","Eggson","Eclipse","Finn","Flutter","Flyte","Gigi","Ginger","Glisten","Goob","Gourdy","Looey","Pebble","Poppy","Razzle","Ribecca","Rodger","Rudie","Scraps","Shelly","Shrimpo","Soulvester","Sprout","Squirm","Teagan","Tisha","Toodles","Vee","Yatta","Waxwell"},
callback=function(selected)replaceTargets.run=selected end
},
{type="toggle",title="Replace current run animation",desc="Replaces your current running animation to the target idle animation.",
callback=function(state)
handleReplacement("run",state,replaceTargets.run,replaceTwisted.run)
if not state then
env.funcs.resetanims()
end
end
},
{type="dropdown",title="Extract animaton target",desc="Sets the Toon you want to replace your extracting animation with.",
options={"Astro","Bassie","Blot","Bobette","Boxten","Brightney","Brusha","Coal","Cocoa","Connie","Cosmo","Dandy","Dazzle","Dyle","Eggson","Eclipse","Finn","Flutter","Flyte","Gigi","Ginger","Glisten","Goob","Gourdy","Looey","Pebble","Poppy","Razzle","Ribecca","Rodger","Rudie","Scraps","Shelly","Shrimpo","Soulvester","Sprout","Squirm","Teagan","Tisha","Toodles","Vee","Yatta","Waxwell"},
callback=function(selected)replaceTargets.extracting=selected end
},
{type="toggle",title="Replace current extract animation",desc="Replaces your current extracting animation to the target idle animation.",
callback=function(state)
handleReplacement("extracting",state,replaceTargets.extracting,false)
if not state then
env.funcs.resetanims()
end
end
},
{type="dropdown",title="Quirk animaton target",desc="Sets the Toon you want to replace your quirk animation with.",
options={"Astro","Bassie","Blot","Bobette","Boxten","Brightney","Brusha","Coal","Cocoa","Connie","Cosmo","Dandy","Dazzle","Dyle","Eggson","Eclipse","Finn","Flutter","Flyte","Gigi","Ginger","Glisten","Goob","Gourdy","Looey","Pebble","Poppy","Razzle","Ribecca","Rodger","Rudie","Scraps","Shelly","Shrimpo","Soulvester","Sprout","Squirm","Teagan","Tisha","Toodles","Vee","Yatta","Waxwell"},
callback=function(selected)replaceTargets.quirk=selected end
},
{type="toggle",title="Replace current quirk animation",desc="Replaces your current quirk animation to the target idle animation.",
callback=function(state)
handleReplacement("quirk1",state,replaceTargets.quirk,false)
if not state then
env.funcs.resetanims()
end
end
}
)



insert{type="separator",title="Animation settings"}



local stopmotionhandler={
enabled=false,
stepRate=0.1,
stepAmount=0.1,
activeTracks={},
connections={}
}

local function applyToTrack(track)
if stopmotionhandler.activeTracks[track]then return end
stopmotionhandler.activeTracks[track]=true

spwn(function()
while stopmotionhandler.enabled and track.IsPlaying do
pcall(function()
track:AdjustSpeed(0)
track.TimePosition+=stopmotionhandler.stepAmount
end)
t(stopmotionhandler.stepRate)
end

stopmotionhandler.activeTracks[track]=nil
end)
end

local function stopmotion(state)
stopmotionhandler.enabled=state

if not state then
for track in pairs(stopmotionhandler.activeTracks)do
pcall(function()
track:AdjustSpeed(1)
end)
end
stopmotionhandler.activeTracks={}

for _,con in pairs(stopmotionhandler.connections)do
con:Disconnect()
end
stopmotionhandler.connections={}
return
end

stopmotionhandler.connections.AnimationPlayed=env.stuf.hum.AnimationPlayed:Connect(function(track)
applyToTrack(track)
end)

for _,track in ipairs(env.stuf.hum:GetPlayingAnimationTracks())do
applyToTrack(track)
end
end

local animSpeedConnection

insert(
{type="button",title="Reset animations",desc="Resets your animations back to normal.",
callback=function()
for key,track in pairs(activeTracks)do
track:Stop()
activeTracks[key]=nil
end

local animFolder=env.stuf.char:FindFirstChild"Animations"
if animFolder then
for animName,originalId in pairs(oldanims)do
local animObject=animFolder:FindFirstChild(animName)
if animObject and animObject:IsA"Animation"then
animObject.AnimationId=originalId
end
end
end

animSpeed=1
currentanimpack=""
refreshanimate()
env.funcs.resetanims()
end
},
{type="slider",title="Animation speed",desc="Adjusts your animation speed to the set value.",min=0,max=200,default=1,step=1,
callback=function(value)
animSpeed=value

local animator=env.stuf.hum:FindFirstChildOfClass"Animator"
if animator then
for _,track in pairs(animator:GetPlayingAnimationTracks())do
track:AdjustSpeed(animSpeed)
end
end

if animSpeedConnection then
animSpeedConnection:Disconnect()
animSpeedConnection=nil
end

if animSpeed~=1 then
local animator=env.stuf.hum:FindFirstChildOfClass"Animator"
if animator then
animSpeedConnection=animator.AnimationPlayed:Connect(function(track)
track:AdjustSpeed(animSpeed)
end)
end
end
end
},
{type="toggle",title="Stop motion animations",desc="Makes your animations more jittery.",
callback=function(state)
stopmotion(state)
end
},
{type="slider",title="Stop motion animation step rate",desc="Determines the step rate of the jittery animations.",min=0.02,max=0.5,default=0.06,step=0.02,
callback=function(value)
stopmotionhandler.stepRate=value
end
}
)



return section
