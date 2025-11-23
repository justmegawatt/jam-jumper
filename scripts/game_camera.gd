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
	limit_bottom = viewport_height
	limit_left = 0
	limit_right = viewport_width
	
func _process(delta: float) -> void:
	if player.global_position.y + viewport_center_y < limit_bottom:
		limit_bottom = player.global_position.y + viewport_center_y
	
func _physics_process(delta: float) -> void:
	if player:
		global_position.y = player.global_position.y
	
	#if player and player.global_position.y < max_height_reached:
		#global_position.y = player.global_position.y
		#max_height_reached = player.global_position.y
	
func setup_camera(_player: PlayerCharacter):
	if _player:
		player = _player
