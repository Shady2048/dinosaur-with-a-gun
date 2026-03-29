extends Area2D

@onready var level = $"../.."

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x -= level.cact_speed
	
	if position.x <= -1000:
		queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body is player:
		level.ammo = 15
		queue_free()
