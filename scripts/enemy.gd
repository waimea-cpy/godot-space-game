extends Area2D
class_name Enemy

@onready var explosion_prefab = preload("res://prefabs/explosion.tscn")
@onready var bomb_prefab = preload("res://prefabs/bomb.tscn")

@export var min_speed = 150
@export var max_speed = 250

var speed_y
var speed_x
var x
var angle


func _ready() -> void:
	speed_y = randi_range(min_speed, max_speed)
	speed_x = randi_range(min_speed, max_speed)
	angle = randf_range(0, 2 * PI)

	x = position.x
	position.x = x + speed_x * sin(angle)

	get_node("bomb_timer").start(randf_range(0.5, 1.5))


func _process(delta: float) -> void:
	angle += delta
	position.x = x + speed_x * sin(angle)
	
	position.y += speed_y * delta
	if position.y > get_window().size.y + 50:
		queue_free()
	

func _on_area_entered(area: Area2D) -> void: 
	if area is Laser:
		area.queue_free()

		var explosion = explosion_prefab.instantiate()
		explosion.position = position
		get_tree().current_scene.add_child(explosion)

		queue_free()


func _on_bomb_timer_timeout() -> void:
	var bomb = bomb_prefab.instantiate()
	bomb.position = position
	bomb.position.y += 20
	get_tree().current_scene.add_child(bomb)

	get_node("bomb_timer").start(randf_range(0.5, 1.5))
	
