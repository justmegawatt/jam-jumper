extends Node2D

var camera: Camera2D

func initialize(_camera: Camera2D) -> void:
	camera = _camera
	adjust_parallax($Sky, $Sky/Sprite2D)
	adjust_parallax($Trees, $Trees/Sprite2D)
	adjust_parallax($Branches, $Branches/Sprite2D)

func adjust_parallax(parallax: Parallax2D, sprite: Sprite2D) -> void:
	parallax.repeat_size.y = sprite.texture.get_size().y
	sprite.scale.x = camera.viewport_width / sprite.texture.get_size().x
	sprite.global_position.y = camera.viewport_height
	sprite.global_position.x = camera.viewport_center_x
