#include <GarrysMod/Lua/Interface.h>

extern "C" {
	#include <lua.h>

	LUALIB_API int luaopen_io(lua_State* L);
}

GMOD_MODULE_OPEN() {
	lua_State* state = LUA->GetState();

	luaopen_io(state);

	return 0;
}

GMOD_MODULE_CLOSE() {
	return 0;
}
