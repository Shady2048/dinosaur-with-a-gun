extends Control

@onready var level = $".."

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Distance.text = "Distance: " + str(level.distance)
	$Score.text = "Score: " + str(level.score)
	$Ammo.text = "Ammo: " + str(level.ammo)
	
	$"Ammo Bar".value = level.ammo
