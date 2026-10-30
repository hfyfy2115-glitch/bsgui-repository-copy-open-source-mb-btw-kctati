










local dh={}
dh.version=22










local t,spwn=task.wait,task.spawn
local cloneref=cloneref or function(...)return...end

local ws=cloneref(game:GetService"Workspace")
local contp=cloneref(game:GetService"ContentProvider")
local plrs=cloneref(game:GetService"Players")

cloneref(game:GetService"TextService")
local txtcs=cloneref(game:GetService"TextChatService")
local rs=cloneref(game:GetService"RunService")
local uis=cloneref(game:GetService"UserInputService")
local ts=cloneref(game:GetService"TweenService")

local getgenv=(syn and syn.getgenv)or getgenv()or _G


local env=getgenv.BSGUI
local mobile=uis.TouchEnabled and(ws.CurrentCamera.ViewportSize.X<1024)local _=
env.essentials.sgui




local function yield(this)
repeat t()until this()
end

local function resolvepath(tbl,path)
local current=tbl

for key in path:gmatch"[^%.]+"do
if type(current)~="table"then return nil end
current=current[key]
end

return current
end

local padding,textsize=2,mobile and 12 or 16
local notifications={}
local notificationtargets={}

local function tweeny(frame,targety)
notificationtargets[frame]=targety
ts:Create(frame,TweenInfo.new(0.2,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{
Position=UDim2.new(0.5,0,1,targety)
}):Play()
end

local function recalcy()
local currentoffset=0
for _,label in ipairs(notifications)do
local height=label.AbsoluteSize.Y
tweeny(label,-currentoffset)
currentoffset+=height+padding
end
end

local tagcolors={
box=Color3.fromRGB(175,52,209),
altbox=Color3.fromRGB(175,52,209),
pop=Color3.fromRGB(112,234,255),
shr=Color3.fromRGB(247,109,40),
}

local function dialoguenoise()
env.funcs.playsound"rbxassetid://4841731967"
end

local function extractexpression(text)
local tag,stripped=text:match"^%[(.-)%]%s*(.*)"
if tag then
local toon,expression=tag:match"^(.-)_(.+)$"
if toon and expression then
return stripped,expression
end
end
return stripped,"neutral"
end

local function formatlist(items)
if#items==0 then return nil end
if#items==1 then
return"{a/an} "..items[1]
end
if#items==2 then
return items[1].." and {a/an} "..items[2]
end
return table.concat(items,", ",1,#items-1)..", and {a/an} "..items[#items]
end

local function formatplainlist(items)
if#items==0 then return nil end
if#items==1 then
return items[1]
end
if#items==2 then
return items[1].." and "..items[2]
end
return table.concat(items,", ",1,#items-1)..", and "..items[#items]
end

local internalToDisplay={AirHorn=
"Air Horn",Bandage=
"Bandage",BonBon=
"Bonbon",PopBottle=
"Bottle o' Pop",ChocolateBox=
"Box o' Chocolates",Chocolate=
"Chocolate",ChristmasCookie=
"Christmas Cookie",DandyEasterEggs=
"Easter Egg",EjectButton=
"Eject Button",ExtractionSpeedCandy=
"Extraction Speed Candy",HolidayCollectibleItem=
"Event Currency",FakeCapsule=
"Fake Capsule",Gumball=
"Gumballs",HealthKit=
"Health Kit",Instructions=
"Instructions",Jawbreaker=
"Jawbreaker",JumperCable=
"Jumper Cable",Pop=
"Pop",ProteinBar=
"Protein Bar",ResearchCapsule=
"Research Capsule",SkillCheckCandy=
"Skill Check Candy",SmokeBomb=
"Smoke Bomb",SpeedCandy=
"Speed Candy",StaminaCandy=
"Stamina Candy",StealthCandy=
"Stealth Candy",Stopwatch=
"Stopwatch",Tape=
"Tape",Valve=
"Valve"
}

local function mapSingleValue(val)
if type(val)=="string"then
return internalToDisplay[val]or(env.funcs.mapname and env.funcs.mapname(val))or val
elseif type(val)=="table"then
local mappedTable={}
for k,v in pairs(val)do
mappedTable[k]=mapSingleValue(v)
end
if#mappedTable>0 then
return formatlist(mappedTable)
end
return mappedTable
end
return val
end

local function applymapsubs(subs)
if not subs then return nil end
local mapped={}
for k,v in pairs(subs)do
mapped[k]=mapSingleValue(v)
end
return mapped
end

local function applygrammar(text,upper,vars)local
_, upperCount=text:gsub("%u","")

if upperCount>10 then
upper=true
end

text=text:gsub("{e/es}",function()
local count=vars and vars.machinesleft
if count~=nil then
local suffix=(count==1)and"e"or"es"
return upper and suffix:upper()or suffix
end
local stats=env.funcs.getgamestats()
local suffix=(stats and(stats.machsrequired-stats.machscompleted)==1)and"e"or"es"
return upper and suffix:upper()or suffix
end)

text=text:gsub("%f[%a][aA][nN]?%s+{a/an}","{a/an}")

while text:find"{a/an}%s*{a/an}"do
text=text:gsub("{a/an}%s*{a/an}","{a/an}")
end

text=text:gsub("{a/an}%s*(['’]?[%a%d][%a%d'’]*)",function(nextword)
local firstchar=nextword:gsub("^['’]",""):sub(1,1):lower()
local isvowel=(firstchar=="a"or firstchar=="e"or firstchar=="i"or firstchar=="o"or firstchar=="u")

local article=isvowel and"an"or"a"
if upper then
return string.upper(article.." "..nextword)
end
return article.." "..nextword
end)

text=text:gsub("{a/an}",upper and"A"or"a")

text=text:gsub("(%S+)%s*{'/'s}",function(prevword)
local lastchar=prevword:sub(-1):lower()

if upper then
return string.upper(prevword..(lastchar=="s"and"'"or"'s"))
end
return prevword..(lastchar=="s"and"'"or"'s")
end)

return text
end



local expressions={
boxten={
neutral="rbxassetid://113804521009438",
ticked="rbxassetid://119801731483181",
annoyed="rbxassetid://93742008908100",
disgusted="rbxassetid://132747953747736",
proud="rbxassetid://109156136417443",
nervous="rbxassetid://70812761644079",
sad="rbxassetid://99872032789435",
happy="rbxassetid://112622516334581",
shoutingmad="rbxassetid://82686036573692",
shoutinghappy="rbxassetid://106346079533067",
question="rbxassetid://123695188655249",
},

altboxten={
neutral="rbxassetid://81852205818084",
ticked="rbxassetid://121696124690097",
annoyed="rbxassetid://93742008908100",
disgusted="rbxassetid://78211498795248",
proud="rbxassetid://77620990365469",
nervous="rbxassetid://110408381350597",
sad="rbxassetid://95798485739088",
happy="rbxassetid://70780977669750",
shoutingmad="rbxassetid://109169476070861",
shoutinghappy="rbxassetid://133407014164578",
question="rbxassetid://131908179160882",
},

poppy={
neutral="rbxassetid://79560006693017",
ticked="rbxassetid://92351135307579",
annoyed="rbxassetid://84709047862986",
disgusted="rbxassetid://139791715313428",
proud="rbxassetid://90881922055860",
nervous="rbxassetid://106539201145922",
sad="rbxassetid://98027191388873",
happy="rbxassetid://112682587086573",
shoutingmad="rbxassetid://99443800414131",
shoutinghappy="rbxassetid://74832944208279",
question="rbxassetid://91984588663973",
},

shrimpo={
neutral="rbxassetid://72715972991632",
ticked="rbxassetid://93186546981210",
annoyed="rbxassetid://132565367392897",
disgusted="rbxassetid://139227778812510",
proud="rbxassetid://112868802316762",
nervous="rbxassetid://81374316391733",
scoff="rbxassetid://129083079665947",
happy="rbxassetid://118580358458433",
shoutingmad="rbxassetid://132531442752618",
shoutinghappy="rbxassetid://131856289841808",
question="rbxassetid://92758227655046",
}
}

local function preloadExpressions(expressionTable)
local assetsToPreload={}

local function collectAssetIds(tbl)
for _,value in pairs(tbl)do
if type(value)=="table"then
collectAssetIds(value)
elseif type(value)=="string"then
local img=Instance.new"ImageLabel"
img.Image=value
table.insert(assetsToPreload,img)
end
end
end

collectAssetIds(expressionTable)

tick()
contp:PreloadAsync(assetsToPreload)

for _,instance in ipairs(assetsToPreload)do
instance:Destroy()
end
end

task.spawn(function()
preloadExpressions(expressions)
end)



local typingseshids={}

function taip(label,new)
typingseshids=typingseshids or{}

typingseshids[label]=(typingseshids[label]or 0)+1
local sesh=typingseshids[label]

label.Text=""

local skipterms={
"\".\"",
"1.0.4",
"friends, cosmo",
"me, random, random",
"!!",
"speedrun.com",
"[X, Y, Z]",
"1.3.0",
}

local puncdelays={
["."]=0.5,
[","]=0.5,
["!"]=0.5,
["?"]=0.5,
}

local i=1
while i<=#new do
if sesh~=typingseshids[label]then return end

local matchedterm
for _,term in ipairs(skipterms)do
if string.sub(new,i,i+#term-1)==term then
matchedterm=term
break
end
end

if matchedterm then
for j=1,#matchedterm do
if sesh~=typingseshids[label]then return end
label.Text=label.Text..string.sub(matchedterm,j,j)
t()
end
i+=#matchedterm
else
local currentchar=string.sub(new,i,i)
label.Text=label.Text..currentchar
if puncdelays[currentchar]then
t(puncdelays[currentchar])
else
t()
end
i+=1
end
end
end



local container=Instance.new"Frame"
container.AnchorPoint=Vector2.new(0.5,1)
container.Position=UDim2.new(0.5,0,1,-60)
container.Size=UDim2.new(0,400,0,300)
container.BackgroundTransparency=1
container.ZIndex=2147483630
container.Parent=env.essentials.sgui

local layout=Instance.new"UIListLayout"
layout.Parent=container
layout.SortOrder=Enum.SortOrder.LayoutOrder
layout.VerticalAlignment=Enum.VerticalAlignment.Bottom
layout.HorizontalAlignment=Enum.HorizontalAlignment.Center

local dialoguecount=0

local function newdialogue(text,whosaidit,expression)
if type(expression)=="table"then
expression=expression[1]
end
if type(expression)~="string"then
expression="neutral"
end

local nametext=""
text=text or""
expression=expression or"neutral"
local namecolor=Color3.new(1,1,1)

local name=
(whosaidit=="box")and"boxten"or
(whosaidit=="altbox")and"altboxten"or
(whosaidit=="pop")and"poppy"or
(whosaidit=="shr")and"shrimpo"

if whosaidit and tagcolors[whosaidit]then
nametext="["..(
(whosaidit=="box"or whosaidit=="altbox")and"Boxten"or
whosaidit=="pop"and"Poppy"or
whosaidit=="shr"and"Shrimpo"
).."]: "
namecolor=tagcolors[whosaidit]
dialoguenoise()
end

local holder=Instance.new"Frame"
holder.ZIndex=2147483631
holder.BackgroundTransparency=1
holder.Size=UDim2.new(1,0,0,16)
holder.AutomaticSize=Enum.AutomaticSize.Y
holder.AnchorPoint=Vector2.new(0.5,1)
holder.ClipsDescendants=false
holder.LayoutOrder=dialoguecount
holder.Parent=container

local tofade={}
local cursorx=0

if name and expression then
local expressionset=expressions[name]
local image=expressionset and expressionset[expression]

if image and image~="placeholder"then
local iconsize=mobile and 17 or 25
local icon=Instance.new"ImageLabel"
icon.BackgroundTransparency=1
icon.Size=UDim2.new(0,iconsize,0,iconsize)
icon.Position=UDim2.new(0,cursorx+2,0.5,-iconsize/2)
icon.ZIndex=2147483632
icon.Image=image
icon.ImageTransparency=1
icon.Parent=holder
cursorx+=iconsize+4

spwn(function()
ts:Create(icon,TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{ImageTransparency=0}):Play()
ts:Create(icon,TweenInfo.new(1,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Rotation=10}):Play()
t(1)
ts:Create(icon,TweenInfo.new(1,Enum.EasingStyle.Quad,Enum.EasingDirection.InOut),{Rotation=5}):Play()
end)

table.insert(tofade,{label=icon,stroke=nil,baseX=icon.Position.X.Offset,iconpresent=true})
end
end

if nametext~=""then
local nametagw=env.essentials.library.gettextbounds(nametext,Enum.Font.FredokaOne,textsize)

local nametag=Instance.new"TextLabel"
nametag.BackgroundTransparency=1
nametag.Text=nametext
nametag.TextColor3=namecolor
nametag.Font=Enum.Font.FredokaOne
nametag.TextSize=textsize
nametag.ZIndex=2147483633
nametag.Size=UDim2.new(0,nametagw,1,0)
nametag.Position=UDim2.new(0,cursorx,0,0)
nametag.TextTransparency=1
nametag.TextXAlignment=Enum.TextXAlignment.Left
nametag.Parent=holder

local border=Instance.new"UIStroke"
border.Parent=nametag
border.Thickness=1
border.Color=Color3.fromRGB(0,0,0)
border.Transparency=1

table.insert(tofade,{label=nametag,stroke=border,baseX=cursorx})
cursorx+=nametagw
end

local textstartx=cursorx

local messageLabel=Instance.new"TextLabel"
messageLabel.BackgroundTransparency=1
messageLabel.Text=text
messageLabel.ZIndex=2147483634
messageLabel.TextColor3=Color3.new(1,1,1)
messageLabel.Font=Enum.Font.FredokaOne
messageLabel.TextSize=textsize
messageLabel.Size=UDim2.new(0,env.essentials.library.gettextbounds(text,Enum.Font.FredokaOne,textsize)+textsize,1,0)
messageLabel.Position=UDim2.new(0,textstartx,0,0)
messageLabel.TextTransparency=1
messageLabel.TextXAlignment=Enum.TextXAlignment.Left
messageLabel.Parent=holder

local messagestroke=Instance.new"UIStroke"
messagestroke.Parent=messageLabel
messagestroke.Thickness=1
messagestroke.Color=Color3.fromRGB(0,0,0)
messagestroke.Transparency=1

table.insert(tofade,{label=messageLabel,stroke=messagestroke,baseX=textstartx})

cursorx=textstartx+env.essentials.library.gettextbounds(text,Enum.Font.FredokaOne,textsize)
holder.Size=UDim2.new(0,cursorx,0,16)

holder.Position=UDim2.new(0.5,0,1,60)
ts:Create(holder,TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{
Position=UDim2.new(0.5,0,1,0)
}):Play()

spwn(function()
t()
local newheight=holder.AbsoluteSize.Y+padding
for _,existing in ipairs(notifications)do
if existing~=holder then
local currenty=notificationtargets[existing]or 0
local nexty=currenty-newheight
tweeny(existing,nexty)
end
end
end)

notificationtargets[holder]=0
table.insert(notifications,1,holder)
ts:Create(holder,TweenInfo.new(0.5),{Position=UDim2.new(0.5,0,1,0)}):Play()

messageLabel.Text=""

for _,entry in ipairs(tofade)do
if entry.iconpresent then
ts:Create(entry.label,TweenInfo.new(0.5),{ImageTransparency=0}):Play()
else
ts:Create(entry.label,TweenInfo.new(0.5),{TextTransparency=0}):Play()
if entry.stroke then
ts:Create(entry.stroke,TweenInfo.new(0.5),{Transparency=0}):Play()
end
end
end

taip(messageLabel,text)

task.delay(5,function()
local fadeout=TweenInfo.new(1)

for _,entry in ipairs(tofade)do
if entry.iconpresent then
ts:Create(entry.label,fadeout,{ImageTransparency=1}):Play()
else
ts:Create(entry.label,fadeout,{TextTransparency=1}):Play()
if entry.stroke then
ts:Create(entry.stroke,fadeout,{Transparency=1}):Play()
end
end
end

t(1)

for i,v in ipairs(notifications)do
if v==holder then
table.remove(notifications,i)
break
end
end

notificationtargets[holder]=nil
holder:Destroy()
recalcy()
end)
end




function env.funcs.boxtensaid(text,subs)
local text=text
local firstkey=text:match"^([^%.]+)"
local decide=env.gear.toons.nicerboxten and env.stuf.dialogue.altboxten or env.stuf.dialogue.boxten
if firstkey and decide[firstkey]then
local resolved=resolvepath(decide,text)
if resolved then
text=type(resolved)=="table"and resolved[math.random(#resolved)]or resolved
end
end

local expression
text,expression=extractexpression(text)local

_, upperCount=text:gsub("%u","")
local forceUpper=upperCount>10

if subs then
subs=applymapsubs(subs)
for k,v in pairs(subs)do
local stringValue=tostring(v)
if forceUpper then
stringValue=stringValue:upper()
end
text=text:gsub("{"..k.."}",stringValue)
end
end

text=applygrammar(text,forceUpper,subs)
spwn(function()taip(env.stuf.boxtenschatbox,text)end)

if env.gear.toons.sendmsgsinchat then
txtcs.TextChannels.RBXGeneral:DisplaySystemMessage("<font color=\"rgb(175, 52, 209)\">Boxten:</font> "..text)
end

if env.gear.toons.closedcaptions.boxten then
newdialogue(text,"box",expression)
end
end

function env.funcs.poppysaid(text,subs)
local text=text
local firstkey=text:match"^([^%.]+)"
if firstkey and env.stuf.dialogue.boxten[firstkey]then
local resolved=resolvepath(env.stuf.dialogue.poppy,text)
if resolved then
text=type(resolved)=="table"and resolved[math.random(#resolved)]or resolved
end
end

local expression
text,expression=extractexpression(text)local

_, upperCount=text:gsub("%u","")
local forceUpper=upperCount>10

if subs then
subs=applymapsubs(subs)
for k,v in pairs(subs)do
local stringValue=tostring(v)
if forceUpper then
stringValue=stringValue:upper()
end
text=text:gsub("{"..k.."}",stringValue)
end
end

text=applygrammar(text,forceUpper,subs)
spwn(function()taip(env.stuf.poppyschatbox,text)end)

if env.gear.toons.sendmsgsinchat then
txtcs.TextChannels.RBXGeneral:DisplaySystemMessage("<font color=\"rgb(112, 234, 255)\">Poppy:</font> "..text)
end

if env.gear.toons.closedcaptions.poppy then
newdialogue(text,"pop",expression)
end
end

function env.funcs.shrimposaid(text,subs)
local text=text
local firstkey=text:match"^([^%.]+)"
if firstkey and env.stuf.dialogue.shrimpo[firstkey]then
local resolved=resolvepath(env.stuf.dialogue.shrimpo,text)
if resolved then
text=type(resolved)=="table"and resolved[math.random(#resolved)]or resolved
end
end

local expression
text,expression=extractexpression(text)

if subs then
subs=applymapsubs(subs)
for k,v in pairs(subs)do
text=text:gsub("{"..k.."}",string.upper(tostring(v)))
end
end

text=applygrammar(text,true,subs)
spwn(function()taip(env.stuf.shrimposchatbox,text)end)

if env.gear.toons.sendmsgsinchat then
txtcs.TextChannels.RBXGeneral:DisplaySystemMessage("<font color=\"rgb(247, 109, 40)\">Shrimpo:</font> "..text)
end

if env.gear.toons.closedcaptions.shrimpo then
newdialogue(text,"shr",expression)
end
end

local lastmessagetime=tick()

function env.funcs.everybodysaid(text,subs)
lastmessagetime=tick()

env.funcs.boxtensaid(text,subs)

if env.gear.toons.livepoppyreaction then
env.funcs.poppysaid(text,subs)
end

if env.gear.toons.liveshrimporeaction then
env.funcs.shrimposaid(text,subs)
end
end




local Tisha=loadstring(game:HttpGet"https://raw.githubusercontent.com/did-i-leave-the-oven-on/Tisha/refs/heads/main/Tisha.lua")()

local runmaid=Tisha.new()
local floormaid=Tisha.new()

local function israreitem(name)
local rarenames={"Bandage","HealthKit","JumperCable","EjectButton","Valve","BonBon","PopBottle"}
for _,r in ipairs(rarenames)do
if name:find(r)then return true end
end
return false
end

local function ismaintintwisted(name)
local mains={"Astro","Shelly","Gourdy","Sprout","Vee","Pebble","Bassie","Bobette"}
for _,m in ipairs(mains)do
if name:find(m)then return true end
end
return false
end

local function isdandy(name)
return name:find"Dandy"
end

local function islethal(name)
return name:find"Dandy"or name:find"Dyle"
end

local function getplayerheal()
local stats=env.funcs.getstats("player",env.stuf.char)
for _,slot in ipairs{"slot1","slot2","slot3","slot4"}do
local item=slot and stats[slot]
if item=="HealthKit"then return'Health Kit'end
if item=="Bandage"then return'Bandage'end
end
return nil
end

local function gethealonfloor()
if not env.stuf.items then return nil end
for _,item in ipairs(env.stuf.items:GetChildren())do
if item.Name=="HealthKit"then return'Health Kit'end
end
for _,item in ipairs(env.stuf.items:GetChildren())do
if item.Name=="Bandage"then return internalToDisplay.Bandage or item.Name end
end
return nil
end

local function getbassieheal()
for _,player in ipairs(plrs:GetPlayers())do
if player~=env.stuf.plr and player.Character then
local stats=env.funcs.getstats("player",player.Character)
if stats and stats.currenttoon and stats.currenttoon:find"Bassie"then
for _,slot in ipairs{"slot1","slot2","slot3","slot4"}do
local item=stats[slot]
if item=="HealthKit"or item=="Bandage"then
return internalToDisplay[item]or item
end
end
end
end
end
return nil
end

local function getdirection(targetpos)
local camera=env.stuf.cam
local toTarget=(targetpos-env.stuf.root.Position)
local flatRight=Vector3.new(camera.CFrame.RightVector.X,0,camera.CFrame.RightVector.Z).Unit
local flat=Vector3.new(toTarget.X,0,toTarget.Z).Unit
local right=flat:Dot(flatRight)

return right>0 and"to the right"or"to the left"
end

local function pluralize(word)
if word:sub(-1):lower()=="y"then
return word:sub(1,-2).."ies"
else
return word.."s"
end
end

local function hasclearpath(twistedroot)
local rayparams=RaycastParams.new()
rayparams.FilterDescendantsInstances={env.stuf.char,twistedroot.Parent}
rayparams.FilterType=Enum.RaycastFilterType.Exclude
local origin=twistedroot.Position
local direction=(env.stuf.root.Position-origin)
local result=ws:Raycast(origin,direction,rayparams)
return result==nil
end

local lasttwistedattacker

local function setupattacktracking()
if not env.stuf.twisteds then return end

local function tracktwisted(twisted)
local chasingval=twisted:FindFirstChild"ChasingValue"
if not chasingval then return end

runmaid:give(chasingval.Changed:Connect(function(target)
if target==env.stuf.char then
lasttwistedattacker=twisted
end
end),"attacktrack_"..twisted.Name)
end

for _,twisted in ipairs(env.stuf.twisteds:GetChildren())do
tracktwisted(twisted)
end

runmaid:give(env.stuf.twisteds.ChildAdded:Connect(tracktwisted),"attacktrack_newtwisted")

runmaid:give(env.stuf.twisteds.ChildRemoved:Connect(function(twisted)
if lasttwistedattacker==twisted then
lasttwistedattacker=nil
end
end),"attacktrack_removedtwisted")
end

local function cleanuprunlisteners()
floormaid:destroy()
floormaid=Tisha.new()
end

local flooractivetime
local floorloadhandled=false

if env.stuf.inlobby or env.stuf.inrp then

while t(10)do
spwn(function()
env.funcs.everybodysaid("mainsection.randomlobbymessages",nil)
end)

spwn(function()
if not env.gear.toons.livepoppyreaction then
env.funcs.poppysaid("commandssection.randomcommandmessages",nil)
end
end)

spwn(function()
if not env.gear.toons.liveshrimporeaction then
env.funcs.shrimposaid("configssection.randomconfigmessages",{totalconfigs=env.filemanager.getconfigcount()})
end
end)
end
elseif env.stuf.inrun then

runmaid:spawn(function()
while t(1)do
if tick()-lastmessagetime>=30 then
env.funcs.everybodysaid("mainsection.randomrunmessages",nil)
lastmessagetime=tick()
end
end
end)

runmaid:spawn(function()
while t(10)do
spwn(function()
if not env.gear.toons.livepoppyreaction then
env.funcs.poppysaid("commandssection.randomcommandmessages",nil)
end
end)

if not env.gear.toons.liveshrimporeaction then
env.funcs.shrimposaid("configssection.randomconfigmessages",{totalconfigs=env.filemanager.getconfigcount()})
end
end
end)

if not env.funcs.getgamestats().gamestarted then
local blockdefmsg=false


local strikingtrinketplayer
for _,player in ipairs(plrs:GetPlayers())do
if player.Character then
local stats=env.funcs.getstats("player",player.Character)
if stats then
local t1,t2=player:GetAttribute"EquippedTrinket1",player:GetAttribute"EquippedTrinket2"
if(t1 and(t1:find"Brick"or t1:find"CoinPurse"or t1:find"Coal"))
or(t2 and(t2:find"Brick"or t2:find"CoinPurse"or t1:find"Coal"))then
strikingtrinketplayer=stats.currenttoon
break
end
end
end
end
if strikingtrinketplayer then
blockdefmsg=true
env.funcs.everybodysaid("mainsection.runjoinedmessages.whenvoting.strikingtrinkets",{player=strikingtrinketplayer})
end


local tooncounts={}
for _,player in ipairs(plrs:GetPlayers())do
if player.Character then
tooncounts[player:GetAttribute"SelectedCharacter"]=(tooncounts[player:GetAttribute"SelectedCharacter"]or 0)+1
end
end
for toon,count in pairs(tooncounts)do
if count>3 and not blockdefmsg then
blockdefmsg=true
env.funcs.everybodysaid("mainsection.runjoinedmessages.whenvoting.strikingtoonselection",{toonp=pluralize(toon)})
break
end
end

if not blockdefmsg then
env.funcs.everybodysaid("mainsection.runjoinedmessages.whenvoting.default",nil)
end

yield(function()return env.funcs.getgamestats().gamestarted end)
env.funcs.everybodysaid("mainsection.runjoinedmessages.started",nil)
else
env.funcs.everybodysaid("mainsection.randomlobbymessages",nil)
end

yield(function()return env.funcs.floorloaded()end)t(1)

local function setupfloorlisteners(floorjointime)
floorloadhandled=false


local function handlefloorloaded()
if floorloadhandled then return end
floorloadhandled=true

local playerstats=env.funcs.getstats("player",env.stuf.char)
local playerhp=playerstats and playerstats.health or 3


if playerhp<=1 then
local heal=gethealonfloor()
if heal then
env.funcs.everybodysaid("mainsection.floorloadedmessages.healsonthefloorandlow",{item=heal,health=playerhp})
return
end
end


if env.stuf.twisteds then
local dandies={}
for _,twisted in ipairs(env.stuf.twisteds:GetChildren())do
if isdandy(twisted.Name)then
table.insert(dandies,twisted.Name)
end
end
if#dandies>0 then
env.funcs.everybodysaid("mainsection.floorloadedmessages.dandyinthefloor",{twisted=formatplainlist(dandies)})
return
end
end


if env.stuf.twisteds then
local mains={}
for _,twisted in ipairs(env.stuf.twisteds:GetChildren())do
if ismaintintwisted(twisted.Name)then
table.insert(mains,twisted.Name)
end
end
if#mains>0 then
env.funcs.everybodysaid("mainsection.floorloadedmessages.maininthefloor",{twisted=formatplainlist(mains)})
return
end
end


if env.stuf.items then
local rares={}
for _,item in ipairs(env.stuf.items:GetChildren())do
if israreitem(item.Name)then
table.insert(rares,item.Name)
end
end
if#rares>0 then
env.funcs.everybodysaid("mainsection.floorloadedmessages.rareitemonthefloor",{item=rares})
return
end
end

if env.stuf.currentroom:FindFirstChild"Puddles"and#env.stuf.currentroom:FindFirstChild"Puddles":GetChildren()>2 then
env.funcs.everybodysaid("mainsection.floorloadedmessages.ichorleak",nil)
return
end

local floornumber=env.funcs.getgamestats().currentfloor
env.funcs.everybodysaid("mainsection.floorloadedmessages.regular",{floor=floornumber})
end

setupattacktracking()
handlefloorloaded()


local function setupmachinemonitors()
if not env.stuf.machines then return end

for _,machine in ipairs(env.stuf.machines:GetChildren())do
if floormaid.tasks["machine_"..machine.Name]then continue end

floormaid:give(machine.Stats.Completed.Changed:Connect(function()
if not machine.Stats.Completed.Value then return end

local activeplayer1=machine.Stats:FindFirstChild"ActivePlayer"
local activeplayer2=machine.Stats:FindFirstChild"ActivePlayer2"
local snapshot1=activeplayer1 and activeplayer1.Value
local snapshot2=activeplayer2 and activeplayer2.Value

t()

local machinesleft=0
for _,m in ipairs(env.stuf.machines:GetChildren())do
if not m.Stats.Completed.Value then
machinesleft=machinesleft+1
end
end
if machinesleft==0 then return end

local localinvolved=(snapshot1 and snapshot1==env.stuf.char)
or(snapshot2 and snapshot2==env.stuf.char)

if localinvolved then
env.funcs.everybodysaid("mainsection.machinecompletedmessages.byuser",{machinesleft=machinesleft})
else
env.funcs.everybodysaid("mainsection.machinecompletedmessages.bysomeoneelse",{machinesleft=machinesleft})
end
end),"machine_"..machine.Name)

local prompt=machine:FindFirstChild"Prompt"
if prompt then
local failsound=prompt:FindFirstChild"Fail"
if failsound then
floormaid:give(failsound:GetPropertyChangedSignal"Playing":Connect(function()
if not failsound.Playing then return end

local activeplayer1=machine.Stats:FindFirstChild"ActivePlayer"
local activeplayer2=machine.Stats:FindFirstChild"ActivePlayer2"
local localinvolved=(activeplayer1 and activeplayer1.Value==env.stuf.char)
or(activeplayer2 and activeplayer2.Value==env.stuf.char)
if not localinvolved then return end

local alertedtwisted
if env.stuf.twisteds then
for _,twisted in ipairs(env.stuf.twisteds:GetChildren())do
if twisted:GetAttribute"Alerted"then
alertedtwisted=twisted
break
end
end
end

local isdylefloor=false
if env.stuf.twisteds then
for _,twisted in ipairs(env.stuf.twisteds:GetChildren())do
if twisted.Name:find"Dyle"then
isdylefloor=true
break
end
end
end


if isdylefloor then
env.funcs.everybodysaid("mainsection.failedskillcheckmessages.indylesfloor",{twisted=alertedtwisted and alertedtwisted.Name or nil})
elseif alertedtwisted then
env.funcs.everybodysaid("mainsection.failedskillcheckmessages.alertedtwisted",{twisted=alertedtwisted.Name})
end
end),machine.Name.."_fail")
end
end
end
end

if env.stuf.machines then
setupmachinemonitors()
else
floormaid:give(env.stuf.roomfolder.ChildAdded:Connect(function(child)
if child.Name=="Machines"or child.Name==env.stuf.machinesfoldername then
env.stuf.machines=child
setupmachinemonitors()
end
end),"machinefolderwait")
end


local lasttwistedwarning={}
local lasttwistedspotted={}
local twiswarncd=30
local twisspotcd=0

local function setuptwisted(twisted)
if floormaid.tasks["twisted_"..twisted.Name]then return end
local tname=twisted.Name

floormaid:give(rs.Heartbeat:Connect(function()
if not env.stuf.root or not twisted.PrimaryPart then return end

local now=tick()
local dist=(twisted.PrimaryPart.Position-env.stuf.root.Position).Magnitude
local chaser=twisted:FindFirstChild"Chaser"
local visionradius=chaser and chaser:FindFirstChild"VisionRadius"and chaser.VisionRadius.Value or 30

if dist<=100 and env.funcs.getstats("player",env.stuf.char).extracting and not env.stuf.twistedespenabled then
local warnkey=tname.."_wander"
if(not lasttwistedwarning[warnkey]or now-lasttwistedwarning[warnkey]>twiswarncd)then
local humanoid=twisted:FindFirstChildWhichIsA"Humanoid"
local ismoving=humanoid and humanoid.MoveDirection.Magnitude>0
if ismoving and hasclearpath(twisted.PrimaryPart)then
local toPlayer=(env.stuf.root.Position-twisted.PrimaryPart.Position).Unit
local flatMoveDir=Vector3.new(humanoid.MoveDirection.X,0,humanoid.MoveDirection.Z).Unit
if flatMoveDir:Dot(toPlayer)>0.4 then
lasttwistedwarning[warnkey]=now
env.funcs.everybodysaid("mainsection.randomrunmessages.twistednear.walkinginyourdirection",{
twisted=tname,
direction=getdirection(twisted.PrimaryPart.Position)
})
end
end
end
end

if dist<=visionradius*1.5 then
if env.funcs.getstats("player",env.stuf.char).extracting then
local humanoid=twisted:FindFirstChildWhichIsA"Humanoid"
local iswalking=humanoid and humanoid.MoveDirection.Magnitude>0
local towplayer=iswalking and(env.stuf.root.Position-twisted.PrimaryPart.Position).Unit
local istoward=towplayer and twisted.PrimaryPart.CFrame.LookVector:Dot(towplayer)>0.7
local nearkey=tname.."_near"
if istoward and hasclearpath(twisted.PrimaryPart)then
if(not lasttwistedwarning[nearkey]or now-lasttwistedwarning[nearkey]>twiswarncd)then
lasttwistedwarning[nearkey]=now
env.funcs.everybodysaid("mainsection.randomrunmessages.twistednear.isnear",{twisted=tname})
end
end
end
end
end),"twisted_"..tname)

local chaser=twisted:FindFirstChild"ChasingValue"
if chaser then
floormaid:give(chaser.Changed:Connect(function(target)
local localchar=env.stuf.plr.Character
if target~=localchar then return end

local now=tick()
local spotkey=tname.."_spotted"
if lasttwistedspotted[spotkey]and now-lasttwistedspotted[spotkey]<twisspotcd then return end
lasttwistedspotted[spotkey]=now

if islethal(tname)then
env.funcs.everybodysaid("mainsection.spottedmessages.bylethal",{twisted=tname})
else
env.funcs.everybodysaid("mainsection.spottedmessages.byregular",{twisted=tname})
end
end),tname.."_spot")
end
end

if env.stuf.twisteds then
for _,twisted in ipairs(env.stuf.twisteds:GetChildren())do
setuptwisted(twisted)
end
floormaid:give(env.stuf.twisteds.ChildAdded:Connect(setuptwisted),"newtwisted")
else
floormaid:give(env.stuf.roomfolder.ChildAdded:Connect(function(child)
if child==env.stuf.twisteds or child.Name==env.stuf.twistedfoldername then
env.stuf.twisteds=child
for _,twisted in ipairs(child:GetChildren())do
setuptwisted(twisted)
end
floormaid:give(child.ChildAdded:Connect(setuptwisted),"newtwisted")
end
end),"twistedfolderwait")
end


local lastitemwarning={}
local itemwarncd=30

local function setupitem(item)
if not israreitem(item.Name)then return end
local itemkey="item_"..tostring(item)
if floormaid.tasks[itemkey]then return end

floormaid:give(rs.Heartbeat:Connect(function()
if not env.stuf.root or not item.PrimaryPart then return end

local dist=(item.PrimaryPart.Position-env.stuf.root.Position).Magnitude
if dist<=30 then
local now=tick()
local key=item.Name..tostring(item)
if not lastitemwarning[key]or now-lastitemwarning[key]>itemwarncd then
lastitemwarning[key]=now


if not env.stuf.itemespenabled then
env.funcs.everybodysaid("mainsection.randomrunmessages.itemnear",{
item=item.Name,
direction=getdirection(item.PrimaryPart.Position,nil)
})
end
end
end
end),itemkey)
end

if env.stuf.items then
for _,item in ipairs(env.stuf.items:GetChildren())do
setupitem(item)
end
floormaid:give(env.stuf.items.ChildAdded:Connect(setupitem),"newitem")
else
floormaid:give(env.stuf.roomfolder.ChildAdded:Connect(function(child)
if child==env.stuf.items or child.Name==env.stuf.itemsfoldername then
env.stuf.items=child
for _,item in ipairs(child:GetChildren())do
setupitem(item)
end
floormaid:give(child.ChildAdded:Connect(setupitem),"newitem")
end
end),"itemfolderwait")
end


local playeridlethresh=5
local playerwarncd=30

local function setupplayer(player)
if player==env.stuf.plr then return end
if floormaid.tasks[player.Name.."_charadded"]then return end

local playercache={lastpos=nil,lastmove=tick(),warned=0}

local function oncharadded(char)
local phum=char:WaitForChild"Humanoid"
local phroot=char:WaitForChild"HumanoidRootPart"
local lasthp=phum.Health

local function getplayerattacker(character)
local root=character:FindFirstChild"HumanoidRootPart"
if not root then return nil end
local origin=root.Position

if env.stuf.freearea then
for _,obj in ipairs(env.stuf.freearea:GetChildren())do
if obj.Name:find"Tendril"then
local tendrilroot=obj:FindFirstChild"HumanoidRootPart"
if tendrilroot then
local dist=(tendrilroot.Position-origin).Magnitude
local trackedChar=obj:FindFirstChild"TrackedCharacter"
local istracking=obj:GetAttribute"IsTracking"
if dist<=18 and istracking and trackedChar and trackedChar.Value==character then
return"Sprout"
end
end
end
end
end

if env.stuf.currentroom then
for _,obj in ipairs(env.stuf.currentroom:GetChildren())do
if obj.Name:find"BlotHand"then
local model=obj:FindFirstChildWhichIsA"Model"
local handroot=model and model:FindFirstChild"RootPart"
if handroot then
local dist=(handroot.Position-origin).Magnitude
local trackedChar=obj:FindFirstChild"TrackedCharacter"
local istracking=obj:GetAttribute"IsTracking"
if dist<=18 and istracking and trackedChar and trackedChar.Value==character then
return"Blot"
end
end
end
end
end

if env.stuf.twisteds then
for _,twisted in ipairs(env.stuf.twisteds:GetChildren())do
local chaser=twisted:FindFirstChild"ChasingValue"
if chaser and chaser.Value==character then
return twisted.Name
end
end
end

return nil
end

floormaid:give(phum.HealthChanged:Connect(function(hp)
local oldhp=lasthp
lasthp=hp
if hp>=oldhp then return end

local toonname=env.funcs.getstats("player",char)and env.funcs.getstats("player",char).currenttoon or player.Name
local elapsed=tick()-floorjointime
local attackername=getplayerattacker(char)

if hp<=0 then
local panictimerran=env.stuf.gameinfo.Panic.Value and env.stuf.gameinfo.PanicTimer.Value<=0
local floornumber=env.funcs.getgamestats().currentfloor
if panictimerran then
env.funcs.everybodysaid("mainsection.someonediedmessages.diedbecausepanictimerranout",{player=toonname,twisted=attackername})
elseif attackername and attackername:find"Blot"then
env.funcs.everybodysaid("mainsection.someonediedmessages.byblotshand",{player=toonname,twisted=attackername})
elseif attackername and attackername:find"Sprout"then
env.funcs.everybodysaid("mainsection.someonediedmessages.bysproutstendril",{player=toonname,twisted=attackername})
elseif attackername and attackername:find"Connie"then
env.funcs.everybodysaid("mainsection.someonediedmessages.byconnie",{player=toonname,twisted=attackername})
elseif attackername and attackername:find"Razzle"then
env.funcs.everybodysaid("mainsection.someonediedmessages.byrazzleanddazzle",{player=toonname,twisted=attackername})
elseif floornumber<3 then
env.funcs.everybodysaid("mainsection.someonediedmessages.infloorlessthan3",{player=toonname,twisted=attackername})
else
env.funcs.everybodysaid("mainsection.someonediedmessages.regular",{player=toonname,twisted=attackername})
end
else
if attackername and attackername:find"Blot"then
env.funcs.everybodysaid("mainsection.someonedamagedmessages.byblotshand",{player=toonname,twisted=attackername})
elseif attackername and attackername:find"Sprout"then
env.funcs.everybodysaid("mainsection.someonedamagedmessages.bysproutstendril",{player=toonname,twisted=attackername})
elseif attackername and attackername:find"Connie"then
env.funcs.everybodysaid("mainsection.someonedamagedmessages.byconnie",{player=toonname,twisted=attackername})
elseif attackername and(attackername:find"Razzle"or attackername:find"Dazzle")then
env.funcs.everybodysaid("mainsection.someonedamagedmessages.byrazzleanddazzle",{player=toonname,twisted=attackername})
elseif elapsed<20 then
env.funcs.everybodysaid("mainsection.someonedamagedmessages.inlessthan20seconds",{player=toonname,twisted=attackername})
elseif hp<=1 then
env.funcs.everybodysaid("mainsection.someonedamagedmessages.ononeheart",{player=toonname,twisted=attackername})
else
env.funcs.everybodysaid("mainsection.someonedamagedmessages.regular",{player=toonname,twisted=attackername})
end
end
end),player.Name.."_hp")

floormaid:give(rs.Heartbeat:Connect(function()
if not env.stuf.root or not phroot.Parent then return end
local dist=(phroot.Position-env.stuf.root.Position).Magnitude
local now=tick()
if dist>20 then
playercache.lastpos=nil
return
end

local toonname=env.funcs.getstats("player",char)and env.funcs.getstats("player",char).currenttoon or player.Name

local hum=char:FindFirstChildWhichIsA"Humanoid"
if hum and hum.MoveDirection.Magnitude>0.1 then
if not playercache.lastwalked or now-playercache.lastwalked>playerwarncd then
playercache.lastwalked=now
playercache.lastpos=phroot.Position

if env.funcs.getstats("player",env.stuf.char).extracting then
env.funcs.everybodysaid("mainsection.randomrunmessages.playernear.walkedpast",{player=toonname})
end
end
playercache.laststandstill=nil
else
if not playercache.laststandstill then
playercache.laststandstill=now
elseif now-playercache.laststandstill>playeridlethresh then
if not playercache.lastidled or now-playercache.lastidled>playerwarncd then
local twistedsonplayer=0
if env.stuf.twisteds then
for _,twisted in ipairs(env.stuf.twisteds:GetChildren())do
local chaser=twisted:FindFirstChild"Chaser"
if chaser and chaser:GetAttribute"Target"==char.Name then
if twisted.PrimaryPart and hasclearpath(twisted.PrimaryPart)then
twistedsonplayer=twistedsonplayer+1
end
end
end
end
playercache.lastidled=now
if env.funcs.getstats("player",env.stuf.char).extracting and not env.funcs.getstats("player",char).extracting then
if twistedsonplayer>=2 then
env.funcs.everybodysaid("mainsection.randomrunmessages.playernear.hastwistedsgathered",{player=toonname})
else
env.funcs.everybodysaid("mainsection.randomrunmessages.playernear.idlingnearyou",{player=toonname})
end
end
end
end
end
end),player.Name.."_prox")
end

if player.Character then oncharadded(player.Character)end
floormaid:give(player.CharacterAdded:Connect(oncharadded),player.Name.."_charadded")
end

for _,player in ipairs(plrs:GetPlayers())do
setupplayer(player)
end
floormaid:give(plrs.PlayerAdded:Connect(setupplayer),"playeradded")
end


local humanoid=env.stuf.hum
local lasthealth=humanoid.Health
local flooractiveatjoin=env.stuf.gameinfo.FloorActive
local jointime=tick()

local function getlasthitsource()
local isblot,btype=env.funcs.nearobstacle(true)
if isblot then return btype end

if lasttwistedattacker and lasttwistedattacker.Parent then
return lasttwistedattacker.Name
end

if env.stuf.twisteds then
for _,twisted in ipairs(env.stuf.twisteds:GetChildren())do
local chaser=twisted:FindFirstChild"ChasingValue"
if chaser and chaser.Value==env.stuf.char then
return twisted.Name
end
end
end

return nil
end

runmaid:give(humanoid.HealthChanged:Connect(function(newhp)
local oldhp=lasthealth
lasthealth=newhp

if newhp>=oldhp then return end

local source=getlasthitsource()
lasttwistedattacker=nil
local elapsed=tick()-jointime

if newhp<=0 then
local ignoredhealing=getplayerheal()
local panictimerran=env.stuf.gameinfo.Panic.Value and env.stuf.gameinfo.PanicTimer.Value<=0

if ignoredhealing then
env.funcs.everybodysaid("mainsection.diedmessages.diedandignoredhealmessages",{heal=ignoredhealing,twisted=source})
elseif panictimerran then
env.funcs.everybodysaid("mainsection.diedmessages.diedbecausepanictimerranout",{twisted=source})
elseif env.stuf.nondeathoptiontoggled then
env.funcs.everybodysaid("mainsection.diedmessages.diedandhasanondeathoptiontoggled",{twisted=source})
elseif source=="Blot"then
env.funcs.everybodysaid("mainsection.diedmessages.byblotshand",{twisted=source})
elseif source=="Sprout"then
env.funcs.everybodysaid("mainsection.diedmessages.bysproutstendril",{twisted=source})
elseif source and source:find"Connie"then
env.funcs.everybodysaid("mainsection.diedmessages.byconnie",{twisted=source})
elseif source and(source:find"Razzle"or source:find"Dazzle")then
env.funcs.everybodysaid("mainsection.diedmessages.byrazzleanddazzle",{twisted=source})
else
local floornumber=env.funcs.getgamestats().currentfloor
if floornumber<3 then
env.funcs.everybodysaid("mainsection.diedmessages.infloorlessthan3",{twisted=source})
else
env.funcs.everybodysaid("mainsection.diedmessages.regular",{twisted=source})
end
end

return
end

if source=="Blot"then
env.funcs.everybodysaid("mainsection.damagedmessages.byblotshand",{twisted=source})
elseif source=="Sprout"then
env.funcs.everybodysaid("mainsection.damagedmessages.bysproutstendril",{twisted=source})
elseif source and source:find"Connie"then
env.funcs.everybodysaid("mainsection.damagedmessages.byconnie",{twisted=source})
elseif source and(source:find"Razzle"or source:find"Dazzle")then
env.funcs.everybodysaid("mainsection.damagedmessages.byrazzleanddazzle",{twisted=source})
elseif elapsed<20 and flooractiveatjoin then
env.funcs.everybodysaid("mainsection.damagedmessages.inlessthan20seconds",{twisted=source})
elseif newhp<=1 then
local heal=getplayerheal()
local healonfloor=gethealonfloor()
local bassieheal=getbassieheal()
if heal then
env.funcs.everybodysaid("mainsection.damagedmessages.hitbutignoringhealininventory",{heal=heal,twisted=source})
elseif healonfloor then
env.funcs.everybodysaid("mainsection.damagedmessages.hitbutignoringhealonfloor",{heal=healonfloor,twisted=source})
elseif bassieheal then
env.funcs.everybodysaid("mainsection.damagedmessages.hitandbassiepresentwithheal",{heal=bassieheal,twisted=source})
else
env.funcs.everybodysaid("mainsection.damagedmessages.ononeheart",{twisted=source})
end
else
local heal=getplayerheal()
local healonfloor=gethealonfloor()
local bassieheal=getbassieheal()
if heal then
env.funcs.everybodysaid("mainsection.damagedmessages.hitbutignoringhealininventory",{heal=heal,twisted=source})
elseif healonfloor then
env.funcs.everybodysaid("mainsection.damagedmessages.hitbutignoringhealonfloor",{heal=healonfloor,twisted=source})
elseif bassieheal then
env.funcs.everybodysaid("mainsection.damagedmessages.hitandbassiepresentwithheal",{heal=bassieheal,twisted=source})
else
env.funcs.everybodysaid("mainsection.damagedmessages.regular",{twisted=source})
end
end
end),"playerhp")


runmaid:give(env.stuf.gameinfo.FloorActive.Changed:Connect(function(newvalue)
if newvalue then
flooractivetime=tick()
jointime=tick()

if env.stuf.gameinfo and env.stuf.gameinfo.BlackOut.Value then
env.funcs.everybodysaid("mainsection.elevatorrelatedmessages.opened.blackout",nil)
return
end

local isdylefloor=false
if env.stuf.twisteds then
for _,twisted in ipairs(env.stuf.twisteds:GetChildren())do
if twisted.Name:find"Dyle"then
isdylefloor=true
break
end
end
end
if isdylefloor then
env.funcs.everybodysaid("mainsection.elevatorrelatedmessages.opened.dylesfloor",nil)
else
env.funcs.everybodysaid("mainsection.elevatorrelatedmessages.opened.regular",nil)
end
else
local elapsed=flooractivetime and(tick()-flooractivetime)or 999

local deadcount=0
for _,player in ipairs(plrs:GetPlayers())do
if player.Character then
local stats=env.funcs.getstats("player",player.Character)
if stats and stats.dead then
deadcount=deadcount+1
end
end
end

local function formattime(secs)
return string.format("%02dm%02ds",math.floor(secs/60),secs%60)
end
local timestr=formattime(math.floor(elapsed))

if deadcount>1 then
env.funcs.everybodysaid("mainsection.elevatorrelatedmessages.closed.multiplepeopledied",{time=timestr})
elseif elapsed<120 then
env.funcs.everybodysaid("mainsection.elevatorrelatedmessages.closed.endedquickly",{time=timestr})
elseif elapsed<360 then
env.funcs.everybodysaid("mainsection.elevatorrelatedmessages.closed.reasonabletime",{time=timestr})
elseif elapsed<600 then
env.funcs.everybodysaid("mainsection.elevatorrelatedmessages.closed.toolong",{time=timestr})
else
env.funcs.everybodysaid("mainsection.elevatorrelatedmessages.closed.waytoolong",{time=timestr})
end

flooractivetime=nil
floorloadhandled=false
end
end),"flooractive")

runmaid:give(env.stuf.gameinfo.BlackOut.Changed:Connect(function(val)
if val and env.stuf.gameinfo.FloorActive.Value then
env.funcs.everybodysaid("mainsection.elevatorrelatedmessages.opened.blackout",nil)
end
end),"blackout")

local function getplayersinelevator()
local blocker=env.stuf.elevator and env.stuf.elevator:FindFirstChild"MonsterBlocker"
if not blocker then return{}end

local cf=blocker.CFrame
local halfsize=blocker.Size/2
local inside={}

for _,player in ipairs(plrs:GetPlayers())do
local char=player.Character
local root=char and char:FindFirstChild"HumanoidRootPart"
if root then
local local_pos=cf:PointToObjectSpace(root.Position)
if math.abs(local_pos.X)<=halfsize.X
and math.abs(local_pos.Y)<=halfsize.Y
and math.abs(local_pos.Z)<=halfsize.Z then
table.insert(inside,player)
end
end
end

return inside
end

runmaid:give(env.stuf.gameinfo.Panic.Changed:Connect(function(val)
if val then
env.funcs.everybodysaid("mainsection.panicmodemessages.started",nil)

runmaid:give(env.stuf.gameinfo.PanicTimer.Changed:Connect(function(timerval)
local inelevator=getplayersinelevator()
local inelevatorset={}
for _,p in ipairs(inelevator)do
inelevatorset[p]=true
end

local isLocalPlayerIn=inelevatorset[env.stuf.plr]

local outside={}
for _,player in ipairs(plrs:GetPlayers())do
if not inelevatorset[player]and player.Character then
local stats=env.funcs.getstats("player",player.Character)
if stats and not stats.dead then
local toonname=stats.currenttoon or player.Name
table.insert(outside,toonname)
end
end
end

if timerval==15 then
if not isLocalPlayerIn then
env.funcs.everybodysaid("mainsection.panicmodemessages.hurryup",nil)
end
elseif timerval==5 then
if not isLocalPlayerIn then
env.funcs.everybodysaid("mainsection.panicmodemessages.hurrythehellup.stillout",nil)
else
if#outside>0 then
env.funcs.everybodysaid("mainsection.panicmodemessages.hurrythehellup.inelevatorbutsomeonestillout",{
player=outside[math.random(#outside)]
})
end
end
end
end),"panictimer")
end
end),"panicmode")

runmaid:give(env.stuf.gameinfo.DandyStoreOpen.Changed:Connect(function(val)
if val then
local items={}
for i=1,3 do
local slot=env.stuf.elevator.DandyStore:FindFirstChild("Slot"..i)
if slot then
local model=slot:FindFirstChildWhichIsA("Model",true)
items[i]=model and model.Name or nil
end
end

local item1,item2,item3=items[1],items[2],items[3]
if item1=="None"or item2=="None"or item3=="None"then return end
if item1==""or item2==""or item3==""then return end

local allsame=(item1==item2 and item2==item3)
local rare1,rare2,rare3=item1 and israreitem(item1),item2 and israreitem(item2),item3 and israreitem(item3)
local hasrare=rare1 or rare2 or rare3
local allboring=not rare1 and not rare2 and not rare3

local ctx={item1=item1,item2=item2,item3=item3,randitem=item1}
local justsaysomethingnormalforonce=math.random(3)==1

if justsaysomethingnormalforonce then
env.funcs.everybodysaid("mainsection.elevatorrelatedmessages.dandysstock.regular",ctx)
else
if allsame then
env.funcs.everybodysaid("mainsection.elevatorrelatedmessages.dandysstock.sameitemsforallslots",ctx)
elseif hasrare and not allboring then
env.funcs.everybodysaid("mainsection.elevatorrelatedmessages.dandysstock.usefulitems",ctx)
elseif allboring then
env.funcs.everybodysaid("mainsection.elevatorrelatedmessages.dandysstock.alluselessitems",ctx)
else
env.funcs.everybodysaid("mainsection.elevatorrelatedmessages.dandysstock.regular",ctx)
end
end
else
env.funcs.everybodysaid"mainsection.elevatorrelatedmessages.dandysstock.closing"
end
end),"dandyshop")


local floorlistenerssetup=false
runmaid:give(env.stuf.gameinfo.Floor.Changed:Connect(function()
if not floorlistenerssetup then return end
cleanuprunlisteners()t(0.5)
yield(function()return env.funcs.floorloaded()end)
t(0.1)
setupfloorlisteners(tick())
end),"floornumber")

setupfloorlisteners(jointime)
floorlistenerssetup=true
end



return dh
