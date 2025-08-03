extends Area2D
class_name Bomb

@onready var explosion_prefab = preload("res://prefabs/explosion.tscn")

@export var speed = 500


func _process(delta: float) -> void:
	position.y += speed * delta
	

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_area_entered(area: Area2D) -> void: 
	if area is Laser:
		area.queue_free()

		var explosion = explosion_prefab.instantiate()
		explosion.position = position
		get_tree().current_scene.add_child(explosion)

		queue_free()
