extends Parallax2D

@onready var level = $".."

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	autoscroll.x = -level.cact_speed * 20
	print(autoscroll.x)
