require "cmake"

include "library.lua"

-- name can be changed
workspace("just_workspace") 
	architecture "x64"
	configurations { "Debug", "Release", "Dist" }
	startproject("just_project")

local outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"

-- name can be changed, but make sure to update the run.sh script
-- don't forget to change the startproject
project("just_project")
	kind "ConsoleApp"
	language "C++"
	cppdialect "C++17"

	targetdir ("../bin/" .. outputdir .. "/%{prj.name}")
	objdir ("../bin-int/" .. outputdir .. "/%{prj.name}")

	files {
		"../src/**.cpp", "../src/**.hpp", "../src/**.h", "../src/**.inl", "../src/**.cc", "../src/**.hh", "../src/**.ipp", "../src/**.tpp", "../src/**.cxx", "../src/**.hxx", "../src/**.ixx", "../src/**.txx", "../src/**.ino"
	}

	defines {
		
	}

	buildoptions {
		
	}

	linkoptions {
		
	}

	libdirs(get_lib_dirs())
	links(get_links())
	includedirs(get_include_dirs())

	filter "configurations:Debug"
		runtime "Debug"
		symbols "On"
		defines { "DEBUG" }

	filter "configurations:Release"
		runtime "Release"
		optimize "On"
		symbols "On"
		defines { "NDEBUG" }

	filter "configurations:Dist"
		runtime "Release"
		optimize "On"
		symbols "Off"
		defines { "NDEBUG" }

	filter "action:cmake"
		defines { "CMAKE_EXPORT_COMPILE_COMMANDS=ON" }
