extends Node2D

func _ready() -> void:
	get_node("particles").restart()
