#!/usr/bin/env bash
#Authors: covers1624, DarioDaf, Solxanich
# Provided for use in tModLoader deployment. 

#chdir to path of the script and save it
cd "$(dirname "$0")"
. ./BashUtils.sh

echo "Verifying .NET platform specific libraries are correctly deployed"
if [[ "$_uname" == *"_NT"* ]]; then
	if [[ "$(uname -m)" == "i686" ]]; then
		# Ensure Win32 builds have the right version of Steamworks.NET
		winbitSteamworks="../PlatformVariantLibs/Win32.Steamworks.NET.dll"

		echo "Deploying Steamworks.NET for this platform..."
		steamworksVersion=$(find ../Libraries/Steamworks.NET -maxdepth 1 -type d -name '*.*.*' -printf %f -quit)
		defaultSteamworks="../Libraries/Steamworks.NET/$steamworksVersion/Steamworks.NET.dll"

		mv "$winbitSteamworks" "$defaultSteamworks"
	fi
	if [[ "$(uname -m)" == "x86_64" ]]; then
		echo "I'm on Windows x64, no need to do anything"
	fi
else
	# Ensure Unix builds have the right version of Steamworks.NET
	unixSteamworks="../PlatformVariantLibs/UNIX.Steamworks.NET.dll"
	if [ -f "$unixSteamworks" ]; then
		echo "Deploying Steamworks.NET for this platform..."
		steamworksVersion=$(find ../Libraries/Steamworks.NET -maxdepth 1 -type d -name '*.*.*' -printf %f -quit)
		defaultSteamworks="../Libraries/Steamworks.NET/$steamworksVersion/Steamworks.NET.dll"

		mv "$unixSteamworks" "$defaultSteamworks"
	fi
fi
echo "Success!"
