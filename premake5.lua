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

		filter {"system:windows", "action:gmake"}
			buildoptions {
				"-w", "-fpermissive",

				"-Wl,-static",
				"-static-libgcc",
				"-static-libstdc++",
				"-Wl,-Bstatic,--whole-archive", "-lmcfgthread", "-Wl,-Bdynamic,--no-whole-archive"
			}
			linkoptions {
				-- FIXME: -L path doesnt work, manually fixed it with LDFLAGS
				"-L./lib/win64 -llua_shared",

				"-Wl,-static",
				"-static-libgcc",
				"-static-libstdc++",
				"-Wl,-Bstatic,--whole-archive", "-lmcfgthread", "-Wl,-Bdynamic,--no-whole-archive"
			}
