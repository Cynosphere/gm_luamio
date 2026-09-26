# gm_luamio
Updated copy of luamio, io library for menu state, to work on 64bit.

## Building

### 32bit
Requires [garrysmod-common](https://github.com/danielga/garrysmod_common)

### 64bit (x86-64 branch)
Requires [garrysmod-common `x86-64-support-sourcesdk` branch](https://github.com/danielga/garrysmod_common/tree/x86-64-support-sourcesdk).

### 64bit (main branch)
Requires the [holylib fork of garrysmod-common](https://github.com/RaphaelIT7/garrysmod_common/tree/holylib) with `sourcesdk-minimal` updated to latest commit.

## Cross-compiling (Linux -> Windows)
```
CXXFLAGS="-D__single_inheritance= -D__multiple_inheritance= -D__virtual_inheritance= -D_In_= -D_Out_= -D_Inout_= -DTSLIST_NODE_ALIGN= -DTSLIST_NODE_ALIGN_POST=__attribute__\(\(aligned\(8\)\)\) -DTSLIST_HEAD_ALIGN= -DTSLIST_HEAD_ALIGN_POST=__attribute__\(\(aligned\(16\)\)\) -DPLAT_BIG_ENDIAN=0 -include x86intrin.h -include math.h -fpermissive"
```

You will also need to modify some of the files in garrysmod-common/sourcesdk-minimal to fix `GNUC` to `__GNUC__` and lowercase `Windows.h` to `windows.h`
