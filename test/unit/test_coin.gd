extends "res://addons/gut/test.gd"

var coin = load("res://src/Objects/Coin.gd").new()

func test_pick_coin():	
	coin.picked()
	assert_eq(PlayerData.score, 100,"Initial 0, acum 100")
	
	
