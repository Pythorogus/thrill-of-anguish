extends Area2D

@onready var water: Node2D = $"../Water"

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		# Water
		water.visible = true;
		water.process_mode = Node.PROCESS_MODE_INHERIT
		water.start()
