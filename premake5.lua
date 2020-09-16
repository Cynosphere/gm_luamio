--[[include("../garrysmod_common")

CreateWorkspace({
	name = "luamio",
    path = "projects"
})

CreateProject({
	serverside = false,
    source_path = "src"
})

IncludeLuaShared()
IncludeSDKCommon("../sourcesdk-minimal")--]]

--[[function os.winSdkVersion()
    local reg_arch = iif( os.is64bit(), "\\Wow6432Node\\", "\\" )
    local sdk_version = os.getWindowsRegistry( "HKLM:SOFTWARE" .. reg_arch .. "Microsoft\\Microsoft SDKs\\Windows\\v10.0\\ProductVersion" )
    if sdk_version ~= nil then return sdk_version end
end

workspace "gmcl_luamio"
    configurations { "Debug32", "Release32", "Debug64", "Release64" }
    location ( "projects/" .. os.target() )

project "gmcl_luamio"
    kind         "SharedLib"
    language     "C++"
    includedirs  "lib/"
    targetdir    "build"

    files
    {
        "src/**.*",
        "lib/**.*",
        "include/**.*"
    }

    if os.host() == "macosx" then targetsuffix "_osx"   end
    if os.host() == "linux"  then targetsuffix "_linux" end

    filter "configurations:Debug*"
        defines "DEBUG"
        runtime "Debug"
        optimize "Debug"
        symbols "On"

    filter "configurations:Release*"
        runtime "Release"
        optimize "Speed"

    filter "configurations:*32"
        architecture "x86"

    filter "configurations:*64"
        architecture "x86_64"

    filter "system:windows"
        systemversion (os.winSdkVersion() .. ".0")

    filter {"system:windows", "configurations:*64"}
        targetsuffix "_win64"

    filter {"system:windows", "configurations:*32"}
        targetsuffix "_win32"--]]

newoption({
	trigger = "gmcommon",
	description = "Sets the path to the garrysmod_common (https://github.com/danielga/garrysmod_common) directory",
	value = "path to garrysmod_common directory"
})

local gmcommon = _OPTIONS.gmcommon or os.getenv("GARRYSMOD_COMMON")
if gmcommon == nil then
	error("you didn't provide a path to your garrysmod_common (https://github.com/danielga/garrysmod_common) directory")
end

include(gmcommon .. "/generator.v3.lua")

CreateWorkspace({name = "luamio"})
	CreateProject({serverside = true})
		IncludeLuaShared()
		IncludeSDKCommon()
		IncludeSDKTier0()
		IncludeSDKTier1()
		IncludeScanning()
		IncludeDetouring()
		files({"source/*.cpp", "source/luastuffs/*.c", "source/luastuffs/*.h"})