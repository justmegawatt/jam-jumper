extends Area2D

@onready var destroyer_shape = $CollisionShape2D
var camera

func initialize(_camera: Camera2D) -> void:
	camera = _camera
	setup_position()
	setup_shape()
	setup_collision()
	
func setup_position() -> void:
	position.y = camera.viewport_height
	
func setup_shape() -> void:
	var rect_shape = RectangleShape2D.new()
	var rect_shape_size = Vector2(camera.viewport_width, 200)
	rect_shape.set_size(rect_shape_size)
	destroyer_shape.shape = rect_shape
	destroyer_shape.debug_color = "#f800746b"
	
func setup_collision() -> void:
	collision_layer = 1
	collision_mask = 2
	monitoring = true
	
func _on_area_entered(area: Area2D) -> void:
	if area is Platform:
		area.queue_free()
