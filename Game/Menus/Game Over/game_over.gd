extends Control

@onready var level = $".."

var total = 0

func _ready() -> void:
	total = Global.score + Global.distance

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Score.text = "Score: " + str(Global.score)
	$Distance.text = "Distance: " + str(Global.distance)
	$"Total Score".text = "Total Score: " + str(total)
	
	if Input.is_action_just_pressed("restart"):
		get_tree().change_scene_to_file("res://Game/Level/level.tscn")
