extends Area2D

@onready var laser_prefab = preload("res://prefabs/laser.tscn")
@onready var explosion_prefab = preload("res://prefabs/explosion.tscn")

@export var speed = 500

var laser_level

func _ready() -> void:
	position.x = get_window().size.x / 2.0
	position.y = get_window().size.y - 100
	laser_level = 5


func _process(delta: float) -> void:
	if Input.is_action_pressed("player_left"):
		position.x -= speed * delta
	if Input.is_action_pressed("player_right"):
		position.x += speed * delta
			
	if Input.is_action_pressed("player_up"):
		position.y -= speed * delta
	if Input.is_action_pressed("player_down"):
		position.y += speed * delta

	position.x = clamp(position.x, 50, get_window().size.x - 50)
	position.y = clamp(position.y, get_window().size.y / 2.0, get_window().size.y - 50)
	
	if Input.is_action_just_pressed("player_fire"):
		var lasers = []
		for i in laser_level:
			var laser = laser_prefab.instantiate()
			laser.position = position
			lasers.append(laser)
			
		match laser_level:
			1:
				lasers[0].position.y -= 25
				
			2:
				lasers[0].position.x -= 25
				lasers[1].position.x += 25
				
			3:
				lasers[0].position.y -= 25
				lasers[1].position.x -= 25
				lasers[2].position.x += 25
				
			4:
				lasers[0].position.y -= 25
				lasers[0].position.x -= 10
				
				lasers[1].position.y -= 25
				lasers[1].position.x += 10
				
				lasers[2].position.x -= 25
				lasers[3].position.x += 25
				
			5:
				lasers[0].position.y -= 25
				
				lasers[1].position.y -= 20
				lasers[1].position.x -= 10
				lasers[1].speed_x = -50
				
				lasers[2].position.y -= 20
				lasers[2].position.x += 10
				lasers[2].speed_x = 50
				
				lasers[3].position.x -= 25
				lasers[3].speed_x = -90

				lasers[4].position.x += 25
				lasers[4].speed_x = 90
				
		for i in laser_level:
			get_tree().current_scene.add_child(lasers[i])
	
		
func _on_area_entered(area: Area2D) -> void: 
	if area is Bomb or area is Enemy:
		area.queue_free()

		var explosion = explosion_prefab.instantiate()
		get_tree().current_scene.add_child(explosion)
		explosion.position = position

		queue_free()
