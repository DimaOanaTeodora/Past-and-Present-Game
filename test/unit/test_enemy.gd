extends "res://addons/gut/test.gd"

var enemy = load("res://src/Actors/Enemy.gd").new()


func test_die_enemy():	
	
	enemy.die()	
	assert_eq(PlayerData.score, 200,"Initial 0, acum 100")
