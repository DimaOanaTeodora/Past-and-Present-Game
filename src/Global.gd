extends Node

func _input(_event):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().change_scene("res://Scenes/HUD.tscn")
