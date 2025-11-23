extends CharacterBody2D
class_name PlayerCharacter

@onready var Animator = $AnimationPlayer

var speed: float = 300.0
var gravity: float = 15.0
var terminal_velocity: float = 1000.0
var jump_velocity: float = -800.0
var viewport_margin: int = 20
var viewport_size

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	viewport_size = get_viewport_rect().size

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	handle_animation()

func handle_animation() -> void:
	if velocity.y > 0:
		if $AnimationPlayer.current_animation != "fall":
			$AnimationPlayer.play("fall")
	elif velocity.y < 0:
		if $AnimationPlayer.current_animation != "jump":
			$AnimationPlayer.play("jump")

func _input(event) -> void:
	pass

func _physics_process(delta: float) -> void:
	handle_character_movement()
	handle_character_gravity()
	handle_viewport_edge_teleporting()
	move_and_slide()
	
func handle_character_movement() -> void:	
	var direction_x = Input.get_axis("move_left", "move_right")
	if direction_x:
		velocity.x = direction_x * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		
func handle_character_gravity() -> void:
	velocity.y += gravity
	if velocity.y >= terminal_velocity:
		velocity.y = terminal_velocity
	
func handle_viewport_edge_teleporting() -> void:
	if global_position.x > viewport_size.x + viewport_margin:
		global_position.x = 0 - viewport_margin
	if global_position.x < 0 - viewport_margin:
		global_position.x = viewport_size.x + viewport_margin
	if global_position.y > viewport_size.y:
		global_position.y = 0
	
func platform_bounce() -> void:
	if velocity.y > 0:
		velocity.y = jump_velocity
		
