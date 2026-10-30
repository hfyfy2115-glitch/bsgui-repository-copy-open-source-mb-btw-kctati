
local cloneref=cloneref or function(...)return...end

local plrs=cloneref(game:GetService"Players")
local txtcs=cloneref(game:GetService"TextChatService")
cloneref(game:GetService"LocalizationService")
cloneref(game:GetService"MarketplaceService")
cloneref(game:GetService"HttpService")

local plr=plrs.LocalPlayer local _=
plr.Name local _=
plr.DisplayName local _=
plr.UserId

local identifyexecutor=(syn and syn.identifyexecutor)or identifyexecutor or nil local _=
getgenv()or _G or nil
local request=request or http_request or nil local _=
(syn and syn.iscclosure)or iscclosure or nil local _=
(syn and syn.restorefunction)or restorefunction or nil local _=
(syn and syn.writefile)or writefile or nil local _=
(syn and syn.readfile)or readfile or nil local _=
(syn and syn.isfile)or isfile or nil local _=
(syn and syn.clonefunction)or clonefunction or nil



local function say(from,text)
if from=="b"then
txtcs.TextChannels.RBXGeneral:DisplaySystemMessage("<font color=\"rgb(175, 52, 209)\">Boxten:</font> "..text)
elseif from=="p"then
txtcs.TextChannels.RBXGeneral:DisplaySystemMessage("<font color=\"rgb(112, 234, 255)\">Poppy:</font> "..text)
elseif from=="s"then
txtcs.TextChannels.RBXGeneral:DisplaySystemMessage("<font color=\"rgb(247, 109, 40)\">Shrimpo:</font> "..text)
end
end





local function get(url)
    local response=request{
        Url=url,
        Method="GET"
    }
    if response and response.Success then
        return response.Body
    end
    say("p","Something went wrong while trying to execute Boxten Sex GUI.")
    warn("[Poppy]: Something went wrong while trying to execute Boxten Sex GUI: Status "..tostring(response and response.StatusCode))
    return nil
end




if identifyexecutor then
if string.lower(identifyexecutor()):find"xeno"or string.lower(identifyexecutor()):find"solara"then
say("s","YOUR EXECUTOR DOES NOT SUPPORT BOXTEN SEX GUI.")
return
end
else
say("s","YOUR EXECUTOR DOES NOT SUPPORT BOXTEN SEX GUI.")
return
end



local function go()
local source=get"https://raw.githubusercontent.com/did-i-leave-the-oven-on/Boxten-Sex-GUI/refs/heads/main/init/load.lua"

if source then
loadstring(source)()
else
say("p","Something went wrong while trying to execute Boxten Sex GUI.")
warn"[Poppy]: Something went wrong while trying to execute Boxten Sex GUI."
end
end



go()
