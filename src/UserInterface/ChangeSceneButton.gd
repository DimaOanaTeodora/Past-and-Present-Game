tool
extends Button

export(String, FILE) var next_scene_path: = ""

func _on_button_up():
	PlayerData.reset()
	get_tree().paused = false
	get_tree().change_scene(next_scene_path) #path to a new scene

func _get_configuration_warning () -> String:
	return "next_scene_path must be set for the button to work" if next_scene_path == "" else ""
