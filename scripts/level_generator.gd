extends Node2D

var platform_scene = preload("res://scenes/platform.tscn")
var camera: Camera2D
var platform_parent: Node2D
var player: PlayerCharacter

var topmost_platform_y
var platform_width
var platform_height

var interval_check_time = 0.5
var time_elapsed = 0.0

func initialize(_camera: Camera2D, _player: PlayerCharacter) -> void:
	camera = _camera
	player = _player
	platform_parent = $PlatformParent
	get_platform_dimensions()
	generate_floor()
	create_random_platforms()

func _process(delta: float) -> void:
	time_elapsed += delta
	if time_elapsed > interval_check_time:
		if is_player_near_top():
			create_random_platforms()
		platform_cleanup()
		time_elapsed = 0.0

func get_platform_dimensions() -> void:
	var temp_platform = platform_scene.instantiate()
	platform_width = temp_platform.get_node("CollisionShape2D").shape.size.x
	platform_height = temp_platform.get_node("Sprite2D").texture.get_height()
	temp_platform.free()

func create_platform(location: Vector2) -> Platform:
	var new_platform = platform_scene.instantiate()
	new_platform.global_position = location
	platform_parent.add_child(new_platform)
	return new_platform

func generate_floor() -> void:
	topmost_platform_y = camera.viewport_height - platform_height
	var platforms_to_generate = ceil(camera.viewport_width / platform_width)
	for i in range(0, platforms_to_generate):
		create_platform(Vector2(platform_width * i, topmost_platform_y))

func is_player_near_top() -> bool:
	return player.global_position.y < topmost_platform_y + (platform_height * 30)

func create_random_platforms() -> void:
	for i in range(0, 30):
		var random_horizontal_position = randi_range(0, camera.viewport_width-platform_width)
		var random_y_distance_between_platforms = platform_height * randi_range(1, 5)
		var platform_position_y = topmost_platform_y - random_y_distance_between_platforms
		create_platform(Vector2(random_horizontal_position, platform_position_y))
		topmost_platform_y = platform_position_y

func platform_cleanup() -> void:
	var platforms = platform_parent.get_children()
	for platform in platforms:
		if platform.global_position.y > camera.limit_bottom:
			platform.queue_free()
