#extends KinematicBody2D
extends "res://src/Actors/Actor.gd"
# abilitatea de a arunca cu bombe
onready var BULLET_SCENE = preload ("res://src/Actors/Bullet.tscn")

var player = null
var move = Vector2.ZERO


func _ready() -> void:
	set_physics_process(false)
	# daca ar fi pzoitiva ar lua-o spre stanga => merge spre jucator
	# directia normala de mers este spre dreapta de-a lungul axei ox
	_velocity.x = -speed.x * 1.5 # maresc viteza inamicului	
	
func _physics_process(delta):
	_velocity.y += gravity * delta
	if is_on_wall():
		_velocity.x *= -1.0
	_velocity.y =  move_and_slide(_velocity, FLOOR_NORMAL).y

	
func _on_Area2D_body_entered(body): # semnal pt Area2D
		player = body 

func _on_Area2D_body_exited(body): # semnal pt Area2D
	player = null # nu vrem sa mai fie urmarit

func fire(): #pentru aruncarea cu bombe
	var bullet = BULLET_SCENE.instance() #intanstiere scena
	bullet.position = get_global_position() # va incepe de la pozitia aruncatorului
	bullet.player = player # se duce catre player
	get_parent().add_child(bullet)
	$Timer.set_wait_time(0.7) #intervalul la care se arunca bombele

func _on_Timer_timeout(): # semnal pt Area2D
	# rol: pentru a controla cat de rapid inamicul aruna cu bombe
	if player != null: 
		fire()


func _on_StompDetector_body_entered(body):
	if body.global_position.y > get_node("StompDetector").global_position.y:
		return 
	get_node("CollisionShape2D").disabled=true
	queue_free()
