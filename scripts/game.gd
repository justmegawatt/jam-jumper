extends Node

var camera_scene = preload("res://scenes/game_camera.tscn")
var camera
var player_scene = preload("res://scenes/player.tscn")
var player
var level_generator_scene = preload("res://scenes/level_generator.tscn")
var level_generator
var ground_scene = preload("res://scenes/ground.tscn")
var ground
var parallax_scene = preload("res://scenes/parallax.tscn")
var parallax

func _ready() -> void:
	instantiate_camera()
	load_player()
	start_level_generator()
	create_ground()
	start_parallax()

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	if Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()

func instantiate_camera() -> void:
	camera = camera_scene.instantiate()
	add_child(camera)

func load_player() -> void:
	player = player_scene.instantiate()
	var center_location = Vector2(camera.viewport_center_x, camera.viewport_center_y)
	player.global_position = center_location
	add_child(player)
	camera.setup_camera(player)
	
func start_level_generator() -> void:
	level_generator = level_generator_scene.instantiate()
	level_generator.initialize(camera, player)
	add_child(level_generator)

func create_ground() -> void:
	ground = ground_scene.instantiate()
	ground.initialize(camera)
	add_child(ground)

func start_parallax() -> void:
	parallax = parallax_scene.instantiate()
	parallax.initialize(camera)
	add_child(parallax)
