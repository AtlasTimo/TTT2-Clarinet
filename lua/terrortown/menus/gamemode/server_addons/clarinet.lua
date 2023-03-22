CLGAMEMODESUBMENU.base = "base_gamemodesubmenu"
CLGAMEMODESUBMENU.title = "submenu_addons_clarinet_title"

function CLGAMEMODESUBMENU:Populate(parent)
	local form = vgui.CreateTTT2Form(parent, "header_addons_clarinet")

	form:MakeHelp({
		label = "help_clarinet_menu"
	})

	form:MakeSlider({
		label = "label_clarinet_fuel_drain_per_second",
		serverConvar = "ttt_clarinet_fuel_drain_per_second",
		min = 0.1,
		max = 60,
		decimal = 1
	})

	form:MakeSlider({
		label = "label_clarinet_damage_to_friendly",
		serverConvar = "ttt_clarinet_damage_to_friendly",
		min = 0,
		max = 100,
		decimal = 0
	})

	form:MakeSlider({
		label = "label_clarinet_damage_to_enemy",
		serverConvar = "ttt_clarinet_damage_to_enemy",
		min = 0,
		max = 100,
		decimal = 0
	})

	form:MakeSlider({
		label = "label_clarinet_radius",
		serverConvar = "ttt_clarinet_radius",
		min = 100,
		max = 10000,
		decimal = 0
	})

	form:MakeSlider({
		label = "label_clarinet_slownes",
		serverConvar = "ttt_clarinet_slownes",
		min = 0.1,
		max = 1.0,
		decimal = 1
	})
end
