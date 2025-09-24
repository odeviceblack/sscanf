cmake_minimum_required(VERSION 3.19)
project(sscanf LANGUAGES C CXX VERSION 2.15.1)

set(CMAKE_CXX_STANDARD 17)

if(CMAKE_SYSTEM_PROCESSOR MATCHES "^(arm|armv7l|armv6l)$")
    set(IS_ARM32 TRUE)
elseif(CMAKE_SYSTEM_PROCESSOR MATCHES "^(aarch64|arm64)$")
    set(IS_ARM64 TRUE)
endif()

include_directories(
	robin-hood-hashing/src/include
	string-view-lite/include
	open.mp/include
	span-lite/include
	glm
	amx
	.
)

add_definitions(
	-DPROJECT_NAME="sscanf"
	-DHAVE_STDINT_H=1
	-DGLM_FORCE_QUAT_DATA_WXYZ=1
	-DNOMINMAX=1
	-Dnssv_CONFIG_SELECT_STRING_VIEW=nssv_STRING_VIEW_NONSTD
	-Dspan_CONFIG_SELECT_SPAN=span_SPAN_NONSTD
	-DPAWN_CELL_SIZE=32
)

if(IS_ARM32 OR IS_ARM64)
    add_definitions(
    	-DGLM_FORCE_DEFAULT_ALIGNED_GENTYPES=1
    )
else()
    add_definitions(
    	-DGLM_FORCE_SSE2=1
    )
endif()

if(MSVC)
	add_definitions(
		-DWIN32
		-D_CRT_SECURE_NO_DEPRECATE=1
		-DWIN32_LEAN_AND_MEAN=1
	)

	add_library(${PROJECT_NAME} SHARED
		amx/amx.c
		amx/amxplugin.c
		sscanf.def
		array.cpp
		data.cpp
		enum.cpp
		kustom.cpp
		specifiers.cpp
		sscanf.cpp
		utils.cpp
		error.cpp
	)
elseif(UNIX)
	add_definitions(
		-DLINUX=1
	)

	if(IS_ARM32 OR IS_ARM64)
		set(CMAKE_C_FLAGS "-fPIC -O2 -w")
		set(CMAKE_CXX_FLAGS "-fPIC -O2 -w")
	else()
		set(CMAKE_C_FLAGS "-m32 -fPIC -O2 -w")
		set(CMAKE_CXX_FLAGS "-m32 -fPIC -O2 -w")
	endif()

	add_library(${PROJECT_NAME} SHARED
		amx/amx.c
		amx/amxplugin.c
		amx/getch.c
		array.cpp
		data.cpp
		enum.cpp
		kustom.cpp
		specifiers.cpp
		sscanf.cpp
		utils.cpp
		error.cpp
	)
endif()

set_property(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR} PROPERTY VS_STARTUP_PROJECT sscanf)

