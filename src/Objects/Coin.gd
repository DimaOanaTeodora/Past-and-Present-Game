extends Area2D

onready var anim_player : AnimationPlayer = get_node("AnimationPlayer") 
# devine o referinta pentru nodul nostru din scene tree

export var score: = 100

func _on_body_entered(body: Node) -> void:
	picked()
	anim_player.play("fade_out")
	
	
func picked() -> void:
	PlayerData.score += score
	
