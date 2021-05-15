extends KinematicBody2D
class_name Actor


const FLOOR_NORMAL: = Vector2.UP

export var speed: = Vector2(300.0, 900.0)
export var gravity: = 4000.0
var _velocity: = Vector2.ZERO  #Vector2(300,0)   #vrem sa mutam caracterul 300 px / s pe axam lui x si 0 pe axa lui y
#!! daca punem _ in fata numelor variabilelor ele sunt private
#func _physics_process(delta: float) -> void: 
	#_velocity.y += gravity * delta 
	#_velocity.y = max(_velocity.y, speed.y)
	
