tool
extends "res://src/Actors/Actor.gd"
# curba sinusoidala
# <0 spre stanga
# >0 spre dreapta 
export var sine_move = -400 
# lungimea unei linii intrerupte
var length= 0.0

var start_position = Vector2() # initializare

# cat de inalte vor fi curbele
export(float) var sine_amplitude = 80 setget _set_sine_amplitude
# setget se asigura de modificarea valorii din editor in cod 
# si apoi rezultatul in editor in timp real

func _ready() -> void:
	start_position = position
	
	set_physics_process(false)
	if speed.x <0 : # daca ii dau viteza mai mica
		$enemy.scale.x *= -1.0
	_velocity.x = -speed.x


func _physics_process(delta: float) -> void:
	# functie apelata la fiecare frame
	
	_velocity.y += gravity * delta
	if is_on_wall(): # se loveste de un perete
		sine_move*=-1.0 # isi schimba directia de deplasare(linia)
		_velocity.x *= -1.0
		$enemy.scale.x *= -1.0 # rotatie imagine inamic cand isi schimba directia
	_velocity.y =  move_and_slide(_velocity, FLOOR_NORMAL).y
		 
	if Engine.editor_hint: 
		# true daca scriptul inca ruleaza in editor
		# good practice
		# previne rularea accidentala a codului 
		# care ar afecta starea scenei in timp ce se afla in editor 
		return
		
	length += delta
	# amplific viteza de miscare 
	position.x +=sine_move *delta
	# calcul amplitudine curba sinusoidala
	position.y = start_position.y + sin(length*10) * sine_amplitude

func _set_sine_amplitude(value):
	sine_amplitude = value
	update()
	
# functie cu care desenez traiectoria in editor	
func _draw():
	if not Engine.editor_hint:
		return 
	
	# vector de puncte
	var points_array = PoolVector2Array()
	var number_points=100 # numarul de puncte de pe traiectorie

	for i in range(number_points):
		# 0.02 masura unui pas
		var l= i * 0.02 #lungimea liniei intrerupte
		# coordonate punct (x, y)
		var point = Vector2(sine_move * l, sin(l * 10) *sine_amplitude)
		points_array.append(point)
	# functie care va va desena linii intrerupte
	# primeste vectorul de puncte
	# culoarea liniilor
	draw_multiline(points_array, Color('#ffffff'), 2.0)
