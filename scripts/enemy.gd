extends Node2D

const SPEED = 150

var direction = 1

@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var ray_cast_bottom_right: RayCast2D = $RayCastBottomRight
@onready var ray_cast_bottom_left: RayCast2D = $RayCastBottomLeft

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if $RayCastRight.is_colliding():
		direction = -1
		animated_sprite.flip_h = true
	elif $RayCastLeft.is_colliding():
		direction = 1
		animated_sprite.flip_h = false
	elif !$RayCastBottomLeft.is_colliding():
		direction = 1
		animated_sprite.flip_h = false
	elif !$RayCastBottomRight.is_colliding():
		direction = -1
		animated_sprite.flip_h = true
	
	position.x += direction * SPEED * delta
