extends Node

var camera_scene = preload("res://scenes/game_camera.tscn")
var camera
var platform_scene = preload("res://scenes/platform.tscn")
var platform_width
var platform_height

func _ready() -> void:
	instantiate_camera()
	get_platform_dimensions()
	generate_floor()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	if Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()

func instantiate_camera() -> void:
	camera = camera_scene.instantiate()
	camera.setup_camera($Player)
	add_child(camera)
	
func get_platform_dimensions() -> void:
	var platform = platform_scene.instantiate()
	platform_width = platform.get_node("CollisionShape2D").shape.size.x
	platform_height = platform.get_node("Sprite2D").texture.get_height()

func create_platform(location: Vector2) -> Platform:
	var new_platform = platform_scene.instantiate()
	new_platform.global_position = location
	$PlatformParent.add_child(new_platform)
	return new_platform

func generate_floor() -> void:
	var bottom_of_screen = camera.viewport_height - platform_height
	var platforms_to_generate = floor(camera.viewport_width / platform_width) + 1
	var x = platform_width
	for i in range(0, platforms_to_generate):
		create_platform(Vector2(x * i, bottom_of_screen))

func load_player() -> void:
	pass
	
	
	
	
	
