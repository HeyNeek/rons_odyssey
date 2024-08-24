extends Node2D

@onready var player: CharacterBody2D = $Player
@onready var movingplatform1: AnimationPlayer = $MovingPlatform/AnimationPlayer

func _ready() -> void:
	#Engine.max_fps = 60
	movingplatform1.play("move_left_to_right")

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("reset_level"):
		get_tree().reload_current_scene()
	
	if !is_instance_valid(player):
		await get_tree().create_timer(1).timeout
		
		get_tree().reload_current_scene()
	
	#print("Current FPS: " + str(Engine.get_frames_per_second()))

func _on_deathzone_body_entered(body: CharacterBody2D) -> void:
	if body is Player:
		body.is_active = false
		print("deathzone entered")
		await get_tree().create_timer(1).timeout
		
		get_tree().reload_current_scene()
