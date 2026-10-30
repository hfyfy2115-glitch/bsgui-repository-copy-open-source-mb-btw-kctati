










local section={}
section.version=22




local getgenv=getgenv()or _G
local request=(syn and syn.request)or(http and http.request)or request

local env=getgenv.BSGUI




local function insert(...)
for _,tbl in ipairs{...}do
table.insert(section,tbl)
end
end

local token="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"

local function get(url)
local response=request{
Url=url,
Method="GET",
Headers={Authorization=
"Bearer "..token,Accept=
"application/vnd.github.v3.raw"
}
}

if response and response.Success then
return response.Body
end

return nil
end



local changelogssource,changelogs=(get"https://raw.githubusercontent.com/did-i-leave-the-oven-on/Boxten-Sex-GUI/refs/heads/main/data/internal/changelogs.lua")
if changelogssource then
changelogs=loadstring(changelogssource)()
end



insert{type="separator",title="Current version"}



insert
{type="label",title="Version "..env.scriptinfo.script.version,desc="Sub-version: "..env.scriptinfo.script.subversion..". Last updated: "..env.scriptinfo.script.lastupdated,
content=changelogs.current
}




insert{type="separator",title="Older versions"}



insert
{type="label",title="Version 1.2.9",desc="Sub-versions: 115. Final release: Saturday, December 30, 2025",
content=changelogs["1.2.9"]
}




insert
{type="label",title="Version 1.2.8",desc="Sub-versions: 29. Final release: Wednesday, December 10, 2025",
content=changelogs["1.2.8"]
}




return section
