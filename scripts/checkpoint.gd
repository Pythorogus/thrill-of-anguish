extends Area2D

@export var checkpoint_position: Vector2
@export var checkpoint_position_y_water: int
@onready var sprite: Sprite2D
@onready var checkpoints: Node2D = $".."

func _ready():
	if has_node("Sprite2D"):
		sprite = $Sprite2D

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		body.last_checkpoint = checkpoint_position
		body.last_checkpoint_position_y_water = checkpoint_position_y_water
		for checkpoint in checkpoints.get_children():
			if checkpoint.sprite:
				checkpoint.sprite.region_rect.position.x = 64
		if sprite :
			sprite.region_rect.position.x = 0
