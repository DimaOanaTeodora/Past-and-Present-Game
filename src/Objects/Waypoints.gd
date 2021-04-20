tool
extends Node2D

#activare / dezactivare noduri in acelasi timp
export var editor_process: = true setget set_editor_process

# linia cu care marchez directia de deplasare
export var line_color: = Color('ffffff')
# grosimea liniei
export var line_width: = 6.0
#triunghiurile pentru directie
export var triangle_color: = Color('ffffff')

# pozitia fiecarui nod
var _active_point_index: = 0

func _ready() -> void:
	if not Engine.editor_hint:
		# daca nu sunt in editor
		# ce va desena calea
		set_process(false)

func _process(delta: float) -> void:
	# updatare instanta cand fac editari pe zona de lucru
	update()

func _draw() -> void:
	if not Engine.editor_hint:
		#daca nu sunt in editor
		return
		
	# daca rulez codul din joc nu din editor
	if not get_child_count() > 1:
		#daca am doar un nod n-am ce sa desenez
		return
		
	#calculez toate punctele pe care vreau sa le desenez
	var points: = PoolVector2Array()
	# reti n triunghiurile
	var triangles: = [] 
	# retin ultimele puncte in for loop
	var last_point: = Vector2.ZERO
	
	# iterez prin toti copii nodului 
	for child in get_children():
		points.append(child.position) #adaug pozitia la vectorul de puncte 
		
		#daca am ajuns la al doilea punct
		if points.size() > 1:
			# calculez centrul dintre 2 puncte pt triunghiuri
			var center: Vector2 = (child.position + last_point) / 2
			# calculez unghiul tot pt triunghi (unghiul dintre axa orizontala si un punct) 
			var angle: = last_point.angle_to_point(child.position)
			
			#adaug triunghiul stocat sub forma de centru si unghi
			triangles.append({center=center, angle=angle})
			
		last_point = child.position #actualizare punct
		
	#se intoarce la primul nod 	
	points.append(get_child(0).position)
	
	#codul pentru desenare
	draw_polyline(points, line_color, line_width, true)
	for triangle in triangles:
		# metoda deifnita mai jos pentru desenarea triunghiului
		draw_triangle(triangle['center'], triangle['angle'], line_width * 2.0)


func get_start_position() -> Vector2:
	return get_child(0).global_position


func get_current_point_position() -> Vector2:
	return get_child(_active_point_index).global_position


func get_next_point_position():
	# daca ajunge la ultimul nod al listei se intoarce la primul copil
	_active_point_index = (_active_point_index + 1) % get_child_count()
	return get_current_point_position()


func draw_triangle(center:Vector2, angle:float, radius:float) -> void:
	var points: = PoolVector2Array()
	#converiti la array conform parametrilor
	var colors: = PoolColorArray([triangle_color])
	
	# 3 varfuri 0,1,2 care vor determina triunghiul 
	for i in range(3):
		var angle_point: = angle + i * 2.0 * PI / 3.0 + PI
		var offset: = Vector2(radius * cos(angle_point), radius * sin(angle_point))
		var point: = center + offset
		#adaugare la vectorul de puncte
		points.append(point)
		
	# metoda a CanvasItem care deseneaza un poligon
	draw_polygon(points, colors)


func set_editor_process(value:bool) -> void:
	editor_process = value
	if not Engine.editor_hint:
		return
	set_process(value)

