extends Area2D
class_name Laser

@export var speed_y = 1200

var speed_x = 0

func _process(delta: float) -> void:
	position.y -= speed_y * delta
	position.x += speed_x * delta
	

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
