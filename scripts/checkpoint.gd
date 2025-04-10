extends Area2D

@export var checkpoint_position: Vector2

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		body.last_checkpoint = checkpoint_position
