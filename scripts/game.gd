extends Node

var camera_scene = preload("res://scenes/game_camera.tscn")
var camera
var platform_scene = preload("res://scenes/platform.tscn")
var platform_width
var platform_height
var initial_bottom_of_screen
var player_scene = preload("res://scenes/player.tscn")
var player
var platform_bottom
var interval_check_time = 0.5
var time_elapsed = 0

func _ready() -> void:
	instantiate_camera()
	get_platform_dimensions()
	generate_floor()
	load_player()
	platform_bottom = initial_bottom_of_screen
	create_random_platforms()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	if Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()
	time_elapsed += delta
	if time_elapsed > interval_check_time:
		if is_player_near_top():
			create_random_platforms()
		platform_cleanup()
		time_elapsed = 0

func instantiate_camera() -> void:
	camera = camera_scene.instantiate()
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
	initial_bottom_of_screen = camera.viewport_height - platform_height
	var platforms_to_generate = floor(camera.viewport_width / platform_width) + 1
	var x = platform_width
	for i in range(0, platforms_to_generate):
		create_platform(Vector2(x * i, initial_bottom_of_screen))

func load_player() -> void:
	player = player_scene.instantiate()
	player.global_position.x = camera.viewport_center_x
	player.global_position.y = camera.viewport_center_y
	add_child(player)
	camera.setup_camera(player)
	
func create_random_platforms() -> void:
	for i in range(0, 30):
		var random_horizontal_position = randi_range(0, camera.viewport_width-platform_width)
		var random_y_distance_between_platforms = platform_height * randi_range(1, 5)
		var platform_position_y = platform_bottom - random_y_distance_between_platforms
		create_platform(Vector2(random_horizontal_position, platform_position_y))
		platform_bottom = platform_position_y
	
func is_player_near_top() -> bool:
	return player.global_position.y < platform_bottom + (platform_height * 30)

func platform_cleanup() -> void:
	var platforms = $PlatformParent.get_children()
	for platform in platforms:
		if platform.global_position.y > camera.limit_bottom:
			platform.queue_free()
