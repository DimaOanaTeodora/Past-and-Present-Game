extends Node2D

#cate secunde asteapta pana incepe miscarea
const starting_time= 0.0 

#distanta pe care se misca
export var distance = Vector2.RIGHT * 500 
#UP, DOWN, LEFT in functie de ce am nevoie 
 
#viteza cu care se misca
export var speed = 400 #viteza cu care se misca

onready var tween =$MoveTween


func _ready():
	#initializare 
	var duration =  distance.length() / float( speed) 
	# deplasare catre dreapta
	tween.interpolate_property($Platform, "position", Vector2.ZERO,  distance, duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, starting_time)
	
	#deplasare catre stanga
	tween.interpolate_property($Platform, "position",  distance, Vector2.ZERO, duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, duration + starting_time*2)
	

func _physics_process(delta):
	#pornire tween face un tur complet stanga dreapta
	tween.start()
	
	
