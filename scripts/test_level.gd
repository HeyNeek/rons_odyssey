extends Node2D

#func _ready():
	#Engine.max_fps = 60

func _process(_delta):
	if Input.is_action_just_pressed("reset_level"):
		get_tree().reload_current_scene()
	
	print("Current FPS: " + str(Engine.get_frames_per_second()))
