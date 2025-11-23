extends Node

var camera_scene = preload("res://scenes/game_camera.tscn")
var camera
var platform_scene = preload("res://scenes/platform.tscn")

func _ready() -> void:
	camera = camera_scene.instantiate()
	camera.setup_camera($Player)
	add_child(camera)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	if Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()
	
func create_platform(location: Vector2) -> Platform:
	var new_platform = platform_scene.instantiate()
	new_platform.global_position = location
	$PlatformParent.add_child(new_platform)
	return new_platform
	
	
