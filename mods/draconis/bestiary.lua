
minetest.register_craftitem("draconis:bestiary", {
	description = "Bestiary",
	inventory_image = "draconis_bestiary.png",
	groups = {book=1},
	on_use = function(itemstack, user, pointed_thing)
		local formspec = "size[13,9]"..
		"background[-1.7,-0.65;16.5,10.4;draconis_bestiary_gui.png]"..
-- Fire Wyvern
		"image[-0.3,0.0;7.6,4.1;draconis_fire_wyvern_book.png]"..
                "label[2,4;Fire Wyvern]"..
                "label[1.8,4.2;Draconis verignis]"..
                "label[0,5;Temperment: Aggressive]"..
                "label[0,5.2;Health: 417]"..
                "label[0,5.4;Speed: 8]"..
                "label[0,5.6;Bite Damage: 28]"..
                "label[0,5.8;Fire Damage: 10-30]"..
                "label[0,6;Habitat: High Mountains]"..
                "label[0,6.2;Taming: Imprint]"..
		"image[1.5,6.5;2.5,2.5;draconis_fire_egg.png]"..
-- Ice Wyvern
		"image[6.92,0;7.6,4.1;draconis_ice_wyvern_book.png]"..
                "label[9.3,4;Ice Wyvern]"..
                "label[8.9,4.2;Draconis pruibestia]"..
                "label[7.2,5;Temperment: Aggressive]"..
                "label[7.2,5.2;Health: 394]"..
                "label[7.2,5.4;Speed: 9]"..
                "label[7.2,5.6;Bite Damage: 24]"..
                "label[7.2,5.8;Ice Damage: ???]"..
                "label[7.2,6;Habitat: High Snowy Mountains]"..
                "label[7.2,6.2;Taming: Imprint]"..
		"image[9,6.5;2.5,2.5;draconis_ice_egg.png]"..
		"image_button[12,0;1,1;draconis_bestiary_button_next.png;btn;;false;false;draconis_bestiary_button_next.png]";
		minetest.show_formspec(user:get_player_name(), "draconis:bestiary_p2", formspec);
	end,
})

minetest.register_on_player_receive_fields(function(player, form, field)
	if form == "draconis:bestiary_p1" then
		local formspec = "size[13,9]"..
		"background[-1.7,-0.65;16.5,10.4;draconis_bestiary_gui.png]"..
-- Fire Wyvern
		"image[-0.3,0.0;7.6,4.1;draconis_fire_wyvern_book.png]"..
                "label[2,4;Fire Wyvern]"..
                "label[1.8,4.2;Draconis verignis]"..
                "label[0,5;Temperment: Aggressive]"..
                "label[0,5.2;Health: 417]"..
                "label[0,5.4;Speed: 8]"..
                "label[0,5.6;Bite Damage: 28]"..
                "label[0,5.8;Fire Damage: 10-30]"..
                "label[0,6;Habitat: High Mountains]"..
                "label[0,6.2;Taming: Imprint]"..
		"image[1.5,6.5;2.5,2.5;draconis_fire_egg.png]"..
-- Ice Wyvern
		"image[6.92,0;7.6,4.1;draconis_ice_wyvern_book.png]"..
                "label[9.3,4;Ice Wyvern]"..
                "label[8.9,4.2;Draconis pruibestia]"..
                "label[7.2,5;Temperment: Aggressive]"..
                "label[7.2,5.2;Health: 394]"..
                "label[7.2,5.4;Speed: 9]"..
                "label[7.2,5.6;Bite Damage: 24]"..
                "label[7.2,5.8;Ice Damage: ???]"..
                "label[7.2,6;Habitat: High Snowy Mountains]"..
                "label[7.2,6.2;Taming: Imprint]"..
		"image[9,6.5;2.5,2.5;draconis_ice_egg.png]"..
		"image_button[12,0;1,1;draconis_bestiary_button_next.png;btn;;false;false;draconis_bestiary_button_next.png]";
		minetest.show_formspec(player:get_player_name(), "draconis:bestiary_p2", formspec);
	end
end)

minetest.register_on_player_receive_fields(function(player, form, field)
	if form == "draconis:bestiary_p2" then
		local formspec = "size[13,9]"..
		"background[-1.7,-0.65;16.5,10.4;draconis_bestiary_gui.png]"..
-- Jungle Wyvern
		"image[-0.3,0.0;7.6,4.1;draconis_jungle_wyvern_book.png]"..
                "label[2,4;Jungle Wyvern]"..
                "label[1.8,4.2;Draconis lacordyla]"..
                "label[0,5;Temperment: Aggressive toward humans]"..
                "label[0,5.2;Health: 41]"..
                "label[0,5.4;Speed: 8]"..
                "label[0,5.6;Bite Damage: 7]"..
                "label[0,5.8;Habitat: Jungle]"..
                "label[0,6;Taming: Imprint]"..
                "label[0,6.2;Prefered Food: Cocoa Beans]"..
		"image[1.5,6.5;2.5,2.5;draconis_jungle_egg.png]"..
-- Fire Dragon
		"image[6.92,0;7.6,4.1;draconis_fire_dragon_book.png]"..
                "label[9.3,4;Fire Dragon]"..
                "label[8.9,4.2;Draconis verignus rex]"..
                "label[7.2,5;Temperment: Aggressive]"..
                "label[7.2,5.2;Health: 582]"..
                "label[7.2,5.4;Speed: 5]"..
                "label[7.2,5.6;Bite Damage: 34]"..
                "label[7.2,5.8;Ice Damage: 8-40]"..
                "label[7.2,6;Habitat: High Mountains]"..
                "label[7.2,6.2;Taming: Imprint]"..
		"image[9,6.5;2.5,2.5;draconis_fire_egg2.png]"..
		"image_button[12,0;1,1;draconis_bestiary_button_next.png;btn;;false;false;draconis_bestiary_button_next.png]";
		minetest.show_formspec(player:get_player_name(), "draconis:bestiary_p1", formspec);
	end
end)




