extends Node2D

@onready var ghost: CharacterBody2D = $CharacterBody2D

var player: CharacterBody2D
var speed: float = 50.0

func _ready() -> void:
	player = get_tree().get_nodes_in_group("player")[0] as CharacterBody2D

func _process(delta: float) -> void:
	if is_instance_valid(player):
		var direction: Vector2 = (player.global_position - ghost.global_position).normalized()
		ghost.velocity = direction * speed
		ghost.move_and_slide()
	else:
		ghost.velocity = Vector2.ZERO

func _on_damage_area_body_entered(body: CharacterBody2D) -> void:
	if body is Player:
		body.queue_free()
