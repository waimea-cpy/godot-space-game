extends Node2D

@onready var enemy_prefab = preload("res://prefabs/enemy.tscn")


func _ready() -> void:
	pass # Replace with function body.


func _process(_delta: float) -> void:
	pass


func _on_enemy_timer_timeout() -> void:
	var enemy = enemy_prefab.instantiate()
	enemy.position.x = randi_range(150, get_window().size.x - 150)
	enemy.position.y = -50
	get_tree().current_scene.add_child(enemy)
