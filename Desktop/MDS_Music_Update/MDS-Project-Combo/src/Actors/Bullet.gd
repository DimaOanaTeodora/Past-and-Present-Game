extends KinematicBody2D

var move = Vector2.ZERO
# va retine directia playerului
var player_direction = Vector2.ZERO 
var player = null
# viteza de deplasare a bombelor
export var speed = 3 

func _ready():
	#pozitia playerului - pozitia inamicului 
	player_direction = player.position - global_position 
	# pentru a fi mai orientate catre player
	player_direction.y -= 50 
	
func _physics_process(delta):	
	move = Vector2.ZERO
	
	move = move.move_toward(player_direction, delta) 
	move = move.normalized() * speed
	position += move


