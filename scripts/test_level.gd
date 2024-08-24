extends Node2D

@onready var player: CharacterBody2D = $Player

#func _ready():
	#Engine.max_fps = 60

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("reset_level"):
		get_tree().reload_current_scene()
	
	if !is_instance_valid(player):
		await get_tree().create_timer(1).timeout
		
		get_tree().reload_current_scene()
	
	#print("Current FPS: " + str(Engine.get_frames_per_second()))
