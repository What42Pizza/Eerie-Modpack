/*

Removed:
haybales -> wheat
shield
diamond armor (not tools)
all wall types
all glass panes
raw copper, iron, and gold blocks
scaffolding
lanterns
coarse dirt
dripstone block

Added:
vines -> slime
lily pads -> slime
9 seeds -> 1 bone meal
blaze powder + charcoal -> gunpowder
//leather + string -> bundle
gold + bottle -> bottle o' enchanting
dopper + bow -> dispenser
dispenser -> dropper
stone tools, stone swords, and furnaces can be crafted with anything tagged stone
2 redstone + 2 copper -> 4 redstone

changed:
detector rails give 16 per craft
powered rails give 16 per craft
ladders give 4 per craft
bottles give 8 per craft
all trapdoor recipes (except iron) give oak trapdoors
add bed recipes give red beds

*/





import crafttweaker.api.recipe.MirrorAxis;





// removals

craftingTable.removeByName(["wheat"]);

craftingTable.removeByName(["shield"]);

craftingTable.removeByName(["diamond_helmet"]);
craftingTable.removeByName(["diamond_chestplate"]);
craftingTable.removeByName(["diamond_leggings"]);
craftingTable.removeByName(["diamond_boots"]);

craftingTable.removeByName([
	"black_stained_glass_pane",
	"black_stained_glass_pane_from_glass_pane",
	"blue_stained_glass_pane",
	"blue_stained_glass_pane_from_glass_pane",
	"brown_stained_glass_pane",
	"brown_stained_glass_pane_from_glass_pane",
	"cyan_stained_glass_pane",
	"cyan_stained_glass_pane_from_glass_pane",
	"glass_pane",
	"gray_stained_glass_pane",
	"gray_stained_glass_pane_from_glass_pane",
	"green_stained_glass_pane",
	"green_stained_glass_pane_from_glass_pane",
	"light_blue_stained_glass_pane",
	"light_blue_stained_glass_pane_from_glass_pane",
	"light_gray_stained_glass_pane",
	"light_gray_stained_glass_pane_from_glass_pane",
	"lime_stained_glass_pane",
	"lime_stained_glass_pane_from_glass_pane",
	"magenta_stained_glass_pane",
	"magenta_stained_glass_pane_from_glass_pane",
	"orange_stained_glass_pane",
	"orange_stained_glass_pane_from_glass_pane",
	"pink_stained_glass_pane",
	"pink_stained_glass_pane_from_glass_pane",
	"purple_stained_glass_pane",
	"purple_stained_glass_pane_from_glass_pane",
	"red_stained_glass_pane",
	"red_stained_glass_pane_from_glass_pane",
	"white_stained_glass_pane",
	"white_stained_glass_pane_from_glass_pane",
	"yellow_stained_glass_pane",
	"yellow_stained_glass_pane_from_glass_pane"
]);

craftingTable.removeByName([
	"andesite_wall",
	"blackstone_wall",
	"brick_wall",
	"cobbled_deepslate_wall",
	"cobblestone_wall",
	"deepslate_brick_wall",
	"deepslate_tile_wall",
	"diorite_wall",
	"end_stone_brick_wall",
	"granite_wall",
	"mossy_cobblestone_wall",
	"mossy_stone_brick_wall",
	"nether_brick_wall",
	"polished_blackstone_brick_wall",
	"polished_blackstone_wall",
	"polished_deepslate_wall",
	"prismarine_wall",
	"red_nether_brick_wall",
	"red_sandstone_wall",
	"sandstone_wall",
	"stone_brick_wall",
	"wildbackport:muddy_brick_wall"
]);

craftingTable.removeByName([
	"raw_copper_block",
	"raw_iron_block",
	"raw_gold_block"
]);


craftingTable.removeByName(["scaffolding"]);

craftingTable.removeByName(["lantern", "soul_lantern"]);

craftingTable.removeByName(["coarse_dirt"]);

craftingTable.removeByName(["dripstone_block"]);





// additions



craftingTable.addShaped("vines_to_slime", <item:minecraft:slime_ball>, [
	[<item:minecraft:vine>, <item:minecraft:vine>, <item:minecraft:vine>],
	[<item:minecraft:vine>, <item:minecraft:vine>, <item:minecraft:vine>],
	[<item:minecraft:vine>, <item:minecraft:vine>, <item:minecraft:vine>]
]);

craftingTable.addShaped("lily_pads_to_slime", <item:minecraft:slime_ball>, [
	[<item:minecraft:lily_pad>, <item:minecraft:lily_pad>, <item:minecraft:lily_pad>],
	[<item:minecraft:lily_pad>, <item:minecraft:lily_pad>, <item:minecraft:lily_pad>],
	[<item:minecraft:lily_pad>, <item:minecraft:lily_pad>, <item:minecraft:lily_pad>]
]);

craftingTable.addShapeless("seeds_to_bone_meal", <item:minecraft:bone_meal>, [
	<item:minecraft:wheat_seeds>,
	<item:minecraft:wheat_seeds>,
	<item:minecraft:wheat_seeds>,
	<item:minecraft:wheat_seeds>,
	<item:minecraft:wheat_seeds>,
	<item:minecraft:wheat_seeds>,
	<item:minecraft:wheat_seeds>,
	<item:minecraft:wheat_seeds>,
	<item:minecraft:wheat_seeds>,
]);


craftingTable.addShapedMirrored("gunpowder", MirrorAxis.ALL, <item:minecraft:gunpowder>, [
	[<item:minecraft:charcoal>, <item:minecraft:glowstone_dust>],
	[<item:minecraft:glowstone_dust>, <item:minecraft:charcoal>]
]);


/*
craftingTable.addShaped("bundle", <item:minecraft:bundle>, [
	[<item:minecraft:air>, <item:minecraft:string>, <item:minecraft:air>],
	[<item:minecraft:leather>, <item:minecraft:air>, <item:minecraft:leather>],
	[<item:minecraft:air>, <item:minecraft:leather>, <item:minecraft:air>]
]);
*/


craftingTable.addShapeless("gold_to_bottle_o_enchanting", <item:minecraft:experience_bottle>, [
	<item:minecraft:glass_bottle>,
	<item:minecraft:gold_ingot>
]);


craftingTable.addShapeless("dropper_to_dispenser", <item:minecraft:dispenser>, [
	<item:minecraft:dropper>,
	<item:minecraft:bow>
]);

craftingTable.addShapeless("dispenser_to_dropper", <item:minecraft:dropper>, [
	<item:minecraft:dispenser>,
]);



craftingTable.addShaped("ladder_from_oak", <item:minecraft:ladder> * 8, [
	[<item:minecraft:oak_planks>, <item:minecraft:air>, <item:minecraft:oak_planks>],
	[<item:minecraft:oak_planks>, <item:minecraft:oak_planks>, <item:minecraft:oak_planks>],
	[<item:minecraft:oak_planks>, <item:minecraft:air>, <item:minecraft:oak_planks>]
]);

craftingTable.addShaped("ladder_from_spruce", <item:minecraft:ladder> * 8, [
	[<item:minecraft:spruce_planks>, <item:minecraft:air>, <item:minecraft:spruce_planks>],
	[<item:minecraft:spruce_planks>, <item:minecraft:spruce_planks>, <item:minecraft:spruce_planks>],
	[<item:minecraft:spruce_planks>, <item:minecraft:air>, <item:minecraft:spruce_planks>]
]);

craftingTable.addShaped("ladder_from_birch", <item:minecraft:ladder> * 8, [
	[<item:minecraft:birch_planks>, <item:minecraft:air>, <item:minecraft:birch_planks>],
	[<item:minecraft:birch_planks>, <item:minecraft:birch_planks>, <item:minecraft:birch_planks>],
	[<item:minecraft:birch_planks>, <item:minecraft:air>, <item:minecraft:birch_planks>]
]);

craftingTable.addShaped("ladder_from_jungle", <item:minecraft:ladder> * 8, [
	[<item:minecraft:jungle_planks>, <item:minecraft:air>, <item:minecraft:jungle_planks>],
	[<item:minecraft:jungle_planks>, <item:minecraft:jungle_planks>, <item:minecraft:jungle_planks>],
	[<item:minecraft:jungle_planks>, <item:minecraft:air>, <item:minecraft:jungle_planks>]
]);

craftingTable.addShaped("ladder_from_acacia", <item:minecraft:ladder> * 8, [
	[<item:minecraft:acacia_planks>, <item:minecraft:air>, <item:minecraft:acacia_planks>],
	[<item:minecraft:acacia_planks>, <item:minecraft:acacia_planks>, <item:minecraft:acacia_planks>],
	[<item:minecraft:acacia_planks>, <item:minecraft:air>, <item:minecraft:acacia_planks>]
]);

craftingTable.addShaped("ladder_from_dark_oak", <item:minecraft:ladder> * 8, [
	[<item:minecraft:dark_oak_planks>, <item:minecraft:air>, <item:minecraft:dark_oak_planks>],
	[<item:minecraft:dark_oak_planks>, <item:minecraft:dark_oak_planks>, <item:minecraft:dark_oak_planks>],
	[<item:minecraft:dark_oak_planks>, <item:minecraft:air>, <item:minecraft:dark_oak_planks>]
]);

craftingTable.addShaped("ladder_from_crimson", <item:minecraft:ladder> * 8, [
	[<item:minecraft:crimson_planks>, <item:minecraft:air>, <item:minecraft:crimson_planks>],
	[<item:minecraft:crimson_planks>, <item:minecraft:crimson_planks>, <item:minecraft:crimson_planks>],
	[<item:minecraft:crimson_planks>, <item:minecraft:air>, <item:minecraft:crimson_planks>]
]);

craftingTable.addShaped("ladder_from_warped", <item:minecraft:ladder> * 8, [
	[<item:minecraft:warped_planks>, <item:minecraft:air>, <item:minecraft:warped_planks>],
	[<item:minecraft:warped_planks>, <item:minecraft:warped_planks>, <item:minecraft:warped_planks>],
	[<item:minecraft:warped_planks>, <item:minecraft:air>, <item:minecraft:warped_planks>]
]);



craftingTable.addShaped("stone_shovel", <item:minecraft:stone_shovel>, [
	[<item:minecraft:air>, <tag:items:c:stone>, <item:minecraft:air>],
	[<item:minecraft:air>, <item:minecraft:stick>, <item:minecraft:air>],
	[<item:minecraft:air>, <item:minecraft:stick>, <item:minecraft:air>],
]);

craftingTable.addShaped("stone_pickaxe", <item:minecraft:stone_pickaxe>, [
	[<tag:items:c:stone>, <tag:items:c:stone>, <tag:items:c:stone>],
	[<item:minecraft:air>, <item:minecraft:stick>, <item:minecraft:air>],
	[<item:minecraft:air>, <item:minecraft:stick>, <item:minecraft:air>],
]);

craftingTable.addShapedMirrored("stone_axe", MirrorAxis.ALL, <item:minecraft:stone_axe>, [
	[<tag:items:c:stone>, <tag:items:c:stone>, <item:minecraft:air>],
	[<tag:items:c:stone>, <item:minecraft:stick>, <item:minecraft:air>],
	[<item:minecraft:air>, <item:minecraft:stick>, <item:minecraft:air>],
]);

craftingTable.addShaped("stone_hoe", <item:minecraft:stone_hoe>, [
	[<tag:items:c:stone>, <tag:items:c:stone>, <item:minecraft:air>],
	[<item:minecraft:air>, <item:minecraft:stick>, <item:minecraft:air>],
	[<item:minecraft:air>, <item:minecraft:stick>, <item:minecraft:air>],
]);

craftingTable.addShaped("stone_sword", <item:minecraft:stone_sword>, [
	[<item:minecraft:air>, <tag:items:c:stone>, <item:minecraft:air>],
	[<item:minecraft:air>, <tag:items:c:stone>, <item:minecraft:air>],
	[<item:minecraft:air>, <item:minecraft:stick>, <item:minecraft:air>],
]);

craftingTable.addShaped("furnace", <item:minecraft:furnace>, [
	[<tag:items:c:stone>, <tag:items:c:stone>, <tag:items:c:stone>],
	[<tag:items:c:stone>, <item:minecraft:air>, <tag:items:c:stone>],
	[<tag:items:c:stone>, <tag:items:c:stone>, <tag:items:c:stone>],
]);



craftingTable.addShaped("copper_to_redstone", <item:minecraft:slime_ball>, [
	[<item:minecraft:redstone>, <item:minecraft:copper_ingot>],
	[<item:minecraft:copper_ingot>, <item:minecraft:redstone>]
]);





// changes



craftingTable.removeByName(["detector_rail"]);

craftingTable.addShaped("detector_rail", <item:minecraft:detector_rail> * 16, [
	[<item:minecraft:iron_ingot>, <item:minecraft:air>, <item:minecraft:iron_ingot>],
	[<item:minecraft:iron_ingot>, <item:minecraft:stone_pressure_plate>, <item:minecraft:iron_ingot>],
	[<item:minecraft:iron_ingot>, <item:minecraft:redstone>, <item:minecraft:iron_ingot>]
]);



craftingTable.removeByName(["powered_rail"]);

craftingTable.addShaped("powered_rail", <item:minecraft:powered_rail> * 16, [
	[<item:minecraft:gold_ingot>, <item:minecraft:air>, <item:minecraft:gold_ingot>],
	[<item:minecraft:gold_ingot>, <item:minecraft:stick>, <item:minecraft:gold_ingot>],
	[<item:minecraft:gold_ingot>, <item:minecraft:redstone>, <item:minecraft:gold_ingot>]
]);



craftingTable.removeByName(["ladder"]);

craftingTable.addShaped("ladder", <item:minecraft:ladder> * 4, [
	[<item:minecraft:stick>, <item:minecraft:air>, <item:minecraft:stick>],
	[<item:minecraft:stick>, <item:minecraft:stick>, <item:minecraft:stick>],
	[<item:minecraft:stick>, <item:minecraft:air>, <item:minecraft:stick>]
]);



craftingTable.removeByName(["glass_bottle"]);

craftingTable.addShaped("glass_bottle", <item:minecraft:glass_bottle> * 8, [
	[<tag:items:c:glass_blocks>, <item:minecraft:air>, <tag:items:c:glass_blocks>],
	[<item:minecraft:air>, <tag:items:c:glass_blocks>, <item:minecraft:air>]
]);



craftingTable.removeByName([
	"oak_trapdoor",
	"spruce_trapdoor",
	"birch_trapdoor",
	"jungle_trapdoor",
	"acacia_trapdoor",
	"dark_oak_trapdoor",
	"crimson_trapdoor",
	"warped_trapdoor",
	"cinderscapes:scorched_trapdoor",
	"cinderscapes:umbral_trapdoor",
	"wildbackport:mangrove_trapdoor",
]);

craftingTable.addShaped("trapdoor", <item:minecraft:oak_trapdoor> * 2, [
	[<tag:items:minecraft:planks>, <tag:items:minecraft:planks>, <tag:items:minecraft:planks>],
	[<tag:items:minecraft:planks>, <tag:items:minecraft:planks>, <tag:items:minecraft:planks>]
]);



craftingTable.removeByName([
	"orange_bed",
	"orange_bed_from_white_bed",
	"magenta_bed",
	"magenta_bed_from_white_bed",
	"light_blue_bed",
	"light_blue_bed_from_white_bed",
	"yellow_bed",
	"yellow_bed_from_white_bed",
	"lime_bed",
	"lime_bed_from_white_bed",
	"pink_bed",
	"pink_bed_from_white_bed",
	"gray_bed",
	"gray_bed_from_white_bed",
	"light_gray_bed",
	"light_gray_bed_from_white_bed",
	"cyan_bed",
	"cyan_bed_from_white_bed",
	"purple_bed",
	"purple_bed_from_white_bed",
	"blue_bed",
	"blue_bed_from_white_bed",
	"brown_bed",
	"brown_bed_from_white_bed",
	"green_bed",
	"green_bed_from_white_bed",
	"red_bed",
	"red_bed_from_white_bed",
	"black_bed",
	"black_bed_from_white_bed",
	"white_bed",
]);

craftingTable.addShaped("red_bed", <item:minecraft:red_bed>, [
	[<tag:items:minecraft:wool>, <tag:items:minecraft:wool>, <tag:items:minecraft:wool>],
	[<tag:items:minecraft:planks>, <tag:items:minecraft:planks>, <tag:items:minecraft:planks>]
]);
