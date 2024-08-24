extends Node2D

@onready var ghost: CharacterBody2D = $CharacterBody2D
@onready var ghost_sprite: Sprite2D = $CharacterBody2D/Sprite2D

var player: CharacterBody2D
var speed: float = 50.0

func _ready() -> void:
	#this is a way to access the player in a seperate scene without the need for it to 
	#be directly in the scene's node tree using Godot's group system
	player = get_tree().get_nodes_in_group("player")[0] as CharacterBody2D

func _process(delta: float) -> void:
	if is_instance_valid(player):
		var direction: Vector2 = (player.global_position - ghost.global_position).normalized()
		
		if(direction.x > 0):
			ghost_sprite.flip_h = true
		else:
			ghost_sprite.flip_h = false
		
		ghost.velocity = direction * speed
		ghost.move_and_slide()
	else:
		ghost.velocity = Vector2.ZERO

func _on_damage_area_body_entered(body: CharacterBody2D) -> void:
	if body is Player:
		body.queue_free()
