extends Area2D

class_name enemy_bullet

@onready var level = $"../.."

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x -= 15
	
	if position.x < -2000:
		queue_free()


func _on_area_entered(area: Area2D) -> void:
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	print("collided")
	if body is player:
		level.health -= 1
	queue_free()
