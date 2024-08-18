extends CharacterBody2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var animation_player: AnimationPlayer = get_parent().get_node("AnimationPlayer")

@export var gravity: int = 400

var is_idle: bool = false
var should_move_right: bool = true
var is_moving: bool = false

func _physics_process(delta: float) -> void:
	if not is_moving:
		if is_idle:
			go_idle()
		else:
			move_side_to_side()
	
	if is_on_floor() == false:
			velocity.y += gravity * delta

func move_side_to_side() -> void:
	is_moving = true
	
	if should_move_right:
		print("right")
		animated_sprite.flip_h = false
		animated_sprite.play("move")
		animation_player.play("move_right")
	else:
		print("left")
		animated_sprite.flip_h = true
		animated_sprite.play("move")
		animation_player.play("move_left")
	
	await get_tree().create_timer(1).timeout
	
	should_move_right = not should_move_right  # Toggle the direction
	is_idle = true
	is_moving = false

func go_idle() -> void:
	animated_sprite.play("idle")
	await get_tree().create_timer(1).timeout
	is_idle = false
