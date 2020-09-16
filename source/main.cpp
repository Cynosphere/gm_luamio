#include <GarrysMod/Lua/Interface.h>
#include <GarrysMod/Lua/LuaInterface.h>
#include <GarrysMod/Lua/LuaShared.h>
#include <GarrysMod/Interfaces.hpp>

static SourceSDK::FactoryLoader lua_shared_loader(
	"lua_shared", false, IS_SERVERSIDE, "garrysmod/bin/");
static GarrysMod::Lua::ILuaShared* lua_shared = nullptr;

extern "C" {
	#include "luastuffs/lua.h" 

	LUALIB_API int luaopen_io(lua_State* L);
}

GMOD_MODULE_OPEN() {
	lua_shared =
		lua_shared_loader.GetInterface<GarrysMod::Lua::ILuaShared>(GMOD_LUASHARED_INTERFACE);
	if (lua_shared == nullptr)
		LUA->ThrowError("unable to get ILuaShared!");

	lua_State* state = LUA->GetState();

	luaopen_io(state);

	return 0;
}

GMOD_MODULE_CLOSE() {
	return 0;
}