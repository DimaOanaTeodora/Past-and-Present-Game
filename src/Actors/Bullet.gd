extends KinematicBody2D

var move = Vector2.ZERO
var look_vec = Vector2.ZERO # aici o sa avem directia playerului
var player = null
export var speed = 3


func _ready():
	look_vec = player.position - global_position #pozitia playerului - pozitia inamicului 
	look_vec.y -= 50 # pentru a fi mai orientate catre player
func _physics_process(delta):	
	move = Vector2.ZERO
	
	move = move.move_toward(look_vec, delta) 
	move = move.normalized() * speed
	position += move


