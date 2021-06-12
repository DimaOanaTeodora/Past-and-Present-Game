extends "res://addons/gut/test.gd"

var player = load("res://src/Actors/Player.gd").new()

func test_die():	
	player.die()	
	assert_eq(PlayerData.deaths, 1,"Initial 0, acum 1")
