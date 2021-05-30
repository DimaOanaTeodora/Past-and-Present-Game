extends KinematicBody2D
onready var BULLET_SCENE = preload("res://src/Actors/EnemyRain.tscn")
var player = null
var move = Vector2.ZERO
var speed =0.3
func _physics_process(delta):
	move = Vector2.ZERO
	if player != null:
		move = position.direction_to(player.position) * speed
	else:
		move = Vector2.ZERO
		
	move = move.normalized()
	move = move_and_collide(move)
func _on_Area2D_body_entered(body):
	if body != self:
		player = body


func _on_Area2D_body_exited(body):
	player = null

func fire():
	var rain = BULLET_SCENE.instance()
	rain.position = get_global_position()
	rain.player = player
	get_parent().add_child(rain)
	$Timer.set_wait_time(1)
func _on_Timer_timeout():
	if player != null:
		fire()
