extends Area2D

# Correct player z index on the heart

var player_z_index = 0

func _on_body_entered(body: Node2D) -> void:
	player_z_index = body.z_index
	body.z_index = 10

func _on_body_exited(body: Node2D) -> void:
	body.z_index = player_z_index
