extends Area2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x += 30
	
	if position.x > 2000:
		queue_free()


func _on_area_entered(area: Area2D) -> void:
	if area is not enemy_bullet:
		queue_free()
