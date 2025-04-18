extends Node2D 

var speed = 125
var go = false

@onready var checkpoint: Area2D = $"../Checkpoints/Checkpoint"
@onready var checkpoint2: Area2D = $"../Checkpoints/Checkpoint2"
@onready var checkpoint3: Area2D = $"../Checkpoints/Checkpoint3"
@onready var checkpoint4: Area2D = $"../Checkpoints/Checkpoint4"
@onready var checkpoint5: Area2D = $"../Checkpoints/Checkpoint5"
@onready var checkpoint6: Area2D = $"../Checkpoints/Checkpoint6"


func _process(delta) -> void:
	if (position.y <= 680) :
		speed = 0
	elif(position.y <= checkpoint3.checkpoint_position.y) :
		speed = 70
	elif(position.y <= checkpoint6.checkpoint_position_y_water) :
		speed = 125
		
	if go :
		position.y -= speed * delta
		
	

func start() -> void :
	go = true

func moveTo(newY) -> void:
	position.y = newY
	#var tween = create_tween()
	#tween.tween_property(self, "position:y", newY, 0.2).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
