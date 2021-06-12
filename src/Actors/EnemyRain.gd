extends Area2D

var move=Vector2.ZERO
var look_vec = Vector2.ZERO
var player = null
var speed_rain = 22
# Called when the node enters the scene tree for the first time.
func _ready():
	look_vec = player.position - global_position
	
	
func _on_StompDetector_body_entered(body):
	if body.global_position.y > get_node("StompDetector").global_position.y:
		return
	get_node("CollisionShape2D").disabled = true
	queue_free()
	
func _physics_process(delta):
	move = Vector2.ZERO
	move = move.move_toward(look_vec, delta)
	move = move.normalized()* speed_rain
	position += move

