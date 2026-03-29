extends Area2D

var health = 2

var SPEED = 5


@onready var level = $"../.."

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if health <= 0:
		level.score += 200
		queue_free()
	
	if Input.is_action_just_pressed("debug"):
		level.health -= 1
	
	position.x -= level.cact_speed
	
	if position.x <= -1000:
		queue_free()

func _on_area_entered(area: Area2D) -> void:
	health -= 1 

func _on_body_entered(body: Node2D) -> void:
	if body is player:
		level.health -= 1
