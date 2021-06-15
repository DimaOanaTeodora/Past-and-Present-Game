extends Control

export (PackedScene) var base_button
export (int) var total_levels = 0
export (NodePath) var grid


func _ready():
	grid = get_node(grid)
	
	if !total_levels <= 4:
		column_size()
	
	for i in range(0, total_levels):
		generate_buttons(i + 1)


func generate_buttons(name : int):
	var bb = base_button.instance()
	bb.set_name(str(name))
	bb.set_text(str(name))
	bb.level_path = ("res://Scenes/Levels/" + str(name) + ".tscn")
	grid.add_child(bb)


func column_size():
	if total_levels % 2 == 0:
		grid.columns = total_levels/2
	else:
		grid.columns = total_levels/2 + 1



" This is for the loading text which appears in the bottom of the screen"
" You can skip this part "
func print_loading_level():
	$Label.text = "Loading..."
	$Label.visible_characters = 7
	for _i in range(0, 3):
		$Label.visible_characters += 1
		yield(get_tree().create_timer(0.3), "timeout")
