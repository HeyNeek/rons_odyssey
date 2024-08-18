extends CharacterBody2D

class_name Player

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var sweat_particles: GPUParticles2D = $SweatParticles
@onready var camera: Camera2D = $Camera2D
#@onready var player_jump_noise = $PlayerJumpNoise

@export var gravity: int = 400
@export var speed: int = 150
@export var jump_force: int = 225

var previous_y_velocity: int
var is_active: bool = true

func _ready() -> void:
	camera.position.x = 75

func _physics_process(delta: float) -> void:
	camera.position.y = 0
	if is_active == true:
		if is_on_floor() == false:
			velocity.y += gravity * delta
			
			if Input.is_action_pressed("dive_down"):
				velocity.y += gravity * delta * 3
				camera.position.y = 175
				#cap for dive speed
				if velocity.y > 600:
					velocity.y = 600
			
			if velocity.y > 200 && !Input.is_action_pressed("dive_down"):
				velocity.y = 200
			
			print("y velocity: " + str(velocity.y))
		
		if Input.is_action_just_pressed("jump") && is_on_floor() == true:
			#player_jump_noise.play()
			jump(jump_force)
		
		var direction: float = Input.get_axis("move_left", "move_right")
		velocity.x += direction * speed
		
		if Input.is_action_pressed("sprint") && is_on_floor() == true:
			#print("we are inside")
			velocity.x += direction * speed * 2
			if velocity.x > 300:
					velocity.x = 300
			
			if velocity.x < -300:
					velocity.x = -300
		
		if direction == 0:
			velocity.x = 0
		
		if direction == 1:
			camera.position.x = 50
		
		if direction == -1:
			camera.position.x = -50
		
		if direction != 0:
			animated_sprite.flip_h = direction == -1
		
		if Input.is_action_just_released("move_left") || Input.is_action_just_released("move_right"):
			velocity.x = 0
		
		if velocity.x > 200 && !Input.is_action_pressed("sprint"):
			velocity.x = 200
		
		if velocity.x > 200 && is_on_floor() == false:
			velocity.x = 200
		
		if velocity.x < -200 && !Input.is_action_pressed("sprint"):
			velocity.x = -200
		
		if velocity.x < -200 && is_on_floor() == false:
			velocity.x = -200
		
		move_and_slide()
		
		#print("x velocity: " + str(velocity.x))
		
		update_animations(direction)

func jump(force: int) -> void:
	velocity.y = -force

func update_animations(direction: float) -> void:
	if is_active == true:
		if is_on_floor():
			if direction == 0:
				animated_sprite.play("idle")
				sweat_particles.emitting = false
			elif Input.is_action_pressed("sprint"):
				animated_sprite.play("sprint")
				sweat_particles.emitting = true
			else:
				animated_sprite.play("run")
				sweat_particles.emitting = false
		else:
			if velocity.y < 0:
				animated_sprite.play("jump_2")
				sweat_particles.emitting = false
			else:
				animated_sprite.play("fall")
				sweat_particles.emitting = false
