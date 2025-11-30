extends Area2D

var sprite
var collision

var camera: Camera2D

func initialize(_camera: Camera2D) -> void:
	camera = _camera
	sprite = $Sprite2D
	collision = $CollisionShape2D
	
	set_ground_position()
	resize_sprite()
	resize_collision_shape()
	
func set_ground_position() -> void:
	global_position.y = camera.viewport_height
	global_position.x = camera.viewport_center_x
	
func resize_sprite() -> void:
	sprite.offset.y = -(sprite.texture.get_height()/2)
	sprite.scale.x = camera.viewport_width / sprite.texture.get_width()
	
func resize_collision_shape() -> void:
	collision.shape.size.x = camera.viewport_width
	collision.shape.size.y = sprite.texture.get_height()
	
