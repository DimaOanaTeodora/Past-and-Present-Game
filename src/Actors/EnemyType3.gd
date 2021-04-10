extends "res://src/Actors/Actor.gd"

# abilitatea de a arunca cu bombe
onready var BULLET_SCENE = preload ("res://src/Actors/Bullet.tscn")
var player = null

func fire(): #pentru aruncarea cu bombe
	var bullet = BULLET_SCENE.instance() #intanstiere scena
	bullet.position = get_global_position() # va incepe de la pozitia aruncatorului
	bullet.player = player # se duce catre player
	get_parent().add_child(bullet)
	$Timer.set_wait_time(1) #intervalul la care se arunca bombele

func _on_Timer_timeout(): # semnal pt Area2D
	# rol: pentru a controla cat de rapid inamicul aruna cu bombe
	if player != null: 
		fire()

	
func _on_Area2D_body_entered(body): # semnal pt Area2D
	#if body != self: # nu este acelasi cu inamicul 
		player = body 

func _on_Area2D_body_exited(body): # semnal pt Area2D
	player = null # nu vrem sa mai fie urmarit
	#player = body

func _ready() -> void:
	set_physics_process(false)
	_velocity.x = -speed.x

func _on_StompDetector_body_entered(body: PhysicsBody2D) -> void:
	if body.global_position.y > get_node("StompDetector").global_position.y:
		return 
	get_node("CollisionShape2D").disabled=true
	queue_free()

func _physics_process(delta: float) -> void:
	_velocity.y += gravity * delta
	if is_on_wall():
		_velocity.x *= -1.0
	_velocity.y =  move_and_slide(_velocity, FLOOR_NORMAL).y
	

