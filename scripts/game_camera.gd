extends Camera2D

var player: PlayerCharacter = null
@onready var max_height_reached = get_viewport_rect().size.y
@onready var viewport_width = get_viewport_rect().size.x
@onready var viewport_height = get_viewport_rect().size.y
var viewport_center_x
var viewport_center_y

func _ready() -> void:
	viewport_center_x = viewport_width / 2
	viewport_center_y = viewport_height / 2
	global_position.x = viewport_center_x
	global_position.y = viewport_center_y
	limit_bottom = viewport_height
	limit_left = 0
	limit_right = viewport_width
	
func _process(delta: float) -> void:
	if has_player_reached_new_heights():
		adjust_camera_floor()
	
func _physics_process(delta: float) -> void:
	pass
	
func setup_camera(_player: PlayerCharacter):
	if _player:
		player = _player
		
func has_player_reached_new_heights() -> bool:
	if player and player.global_position.y + viewport_center_y < limit_bottom:
		return true
	else:
		return false
		
func adjust_camera_floor() -> void:
	limit_bottom = player.global_position.y + viewport_center_y
