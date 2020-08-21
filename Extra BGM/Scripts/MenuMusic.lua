do
	--if there isn't music for a specific screen it falls back to common
	local music = {
		common = {
			["Default"] = "MenuMusic/common/Default (loop).ogg";
			["saiiko"] = "MenuMusic/common/sk2_menu2 (loop).ogg";
			["inori"] = "MenuMusic/common/inori (loop).ogg";
			["fancy cake"] = "MenuMusic/common/fancycake (loop).ogg";
			["NextGen"] = "MenuMusic/common/NextGen (loop).ogg";
			["A"] = "MenuMusic/common/A (loop).ogg";
			["A20"] = "MenuMusic/common/A20 (loop).ogg";
			["A20 PLUS"] = "MenuMusic/common/A20 PLUS (loop).mp3";
		};
		profile = {
			["Default"] = "MenuMusic/profile/Default (loop).ogg";
			["saiiko"] = "MenuMusic/profile/sk2_menu1 (loop).ogg";
			["inori"] = "MenuMusic/common/inori (loop).ogg";
			["fancy cake"] = "MenuMusic/profile/fancycake (loop).ogg";
			["NextGen"] = "MenuMusic/profile/NextGen (loop).ogg";
			["A"] = "MenuMusic/profile/A (loop).ogg";
			["A20"] = "MenuMusic/profile/A20 (loop).ogg";
			["A20 PLUS"] = "MenuMusic/profile/A20 PLUS (loop).mp3";
		};
		results = {
			["Default"] = "MenuMusic/common/Default (loop).ogg";
			["saiiko"] = "MenuMusic/results/sk2_menu3 (loop).ogg";
			["inori"] = "MenuMusic/common/inori (loop).ogg";
			["fancy cake"] = "MenuMusic/results/fancycake (loop).ogg";
			["NextGen"] = "MenuMusic/results/NextGen (loop).ogg";
			["A"] = "MenuMusic/results/A (loop).ogg";
			["A20"] = "MenuMusic/results/A20 (loop).ogg";
			["A20 PLUS"] = "MenuMusic/results/A20 PLUS (loop).mp3";
		};
		music = {
			["Default"] = "MenuMusic/common/Default (loop).ogg";
			["saiiko"] = "MenuMusic/common/sk2_menu2 (loop).ogg";
			["inori"] = "MenuMusic/common/inori (loop).ogg";
			["fancy cake"] = "MenuMusic/common/fancycake (loop).ogg";
			["NextGen"] = "MenuMusic/SelMusic/NextGen (loop).ogg";
			["A"] = "MenuMusic/SelMusic/A (loop).ogg";
			["A20"] = "MenuMusic/SelMusic/A20 (loop).ogg";
			["A20 PLUS"] = "MenuMusic/SelMusic/A20 PLUS (loop).mp3";
		}
	}
	--thanks to this code
	for name,child in pairs(music) do
		if name ~= "common" then
			setmetatable(child, {__index=music.common})
		end
	end
	function GetMenuMusicPath(type, relative)
		local possibles = music[type]
			or error("GetMenuMusicPath: unknown menu music type "..type, 2)
		local selection = ThemePrefs.Get("MenuMusic")
		local file = possibles[selection]
			or error("GetMenuMusicPath: no menu music defined for selection"..selection, 2)
		return relative and file or THEME:GetPathS("", file)
	end
end
