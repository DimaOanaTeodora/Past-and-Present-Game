tool # platforma se misca in editor
extends KinematicBody2D

onready var wait_timer: Timer = $Timer
#extrage nodul de la calea data
onready var waypoints: = get_node(waypoints_path) 

# valoare booleana exportata in editor
# pentru a opri manual miscarea platformei
export var editor_process: = true setget set_editor_process
export var speed: = 400.0 # viteza de miscare a platformei

export var waypoints_path: = NodePath() #conectare intre noduri

var target_position: = Vector2()

func _ready() -> void:
	if not waypoints:
		# sa nu incerce sa acceseze ceva null
		set_physics_process(false)
		return
	#plasare platforma la pozitia de inceput
	position = waypoints.get_start_position() 
	# ca tina imi aleg urmatorul nod catre care trebuie sa ajunga
	target_position = waypoints.get_next_point_position()


func _physics_process(delta: float) -> void:
	# codul de miscare 
	# multe frame-uri pe secunda
	
	# directia pe care platforma se va misca 
	# diferenta dintre nodul actual si cel catre care merge
	var direction: = (target_position - position).normalized()
	
	# viteza cu care se misca
	var motion: = direction * speed * delta
	
	# calculez distanta care a mai ramas pentru a ma opri
	# cu precizie la urmatorul nod
	var distance_to_target: = position.distance_to(target_position)
	
	# distanta totala pe care platforma se va misca in acest frame 
	if motion.length() > distance_to_target:
		# il plasez la urmatorul nod
		position = target_position
		# updatez nodul cu cel de target
		target_position = waypoints.get_next_point_position()
		set_physics_process(false)
		# timpul de asteprae la fiecare nod pana trece la urmatorul
		wait_timer.start() 
	else:
		position += motion


func _draw() -> void:
	var shape: = $CollisionShape2D
	var extents: Vector2 = shape.shape.extents * 2.0
	var rect: = Rect2(shape.position - extents / 2.0, extents)
	#draw_rect(rect, Color('fff'))


func set_editor_process(value:bool) -> void:
	# daca este false opreste miscarea
	# setez variabila globala
	editor_process = value
	if not Engine.editor_hint:
		#daca nu ma aflu in editor nu vreau sa modific jocul
		return
	# daca sunt in editor
	set_physics_process(value)
	# un delay mic-> bug
	wait_timer.stop()


func _on_Timer_timeout() -> void:
	set_physics_process(true)
