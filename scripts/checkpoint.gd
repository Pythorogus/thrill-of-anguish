extends Area2D

@export var checkpoint_position: Vector2
@export var checkpoint_position_y_water: int

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		body.last_checkpoint = checkpoint_position
		body.last_checkpoint_position_y_water = checkpoint_position_y_water
