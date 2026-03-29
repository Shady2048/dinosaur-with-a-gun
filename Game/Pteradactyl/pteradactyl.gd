extends Area2D

var heights: Array = [600,408,217]
var targetHeight = 0	# 0, 1, 2, correspond with heightsArray
var atTargetHeight = true

var health = 3

@onready var level = $"../.."

@onready var changeHeightTimer = $changeHeightTimer
@onready var bulletTimer = $bulletTimer

var H_speed = 1.0
var V_speed = 8.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	changeHeightTimer.start()
	targetHeight = position.y


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(position.y == targetHeight):
		atTargetHeight = true
		if(bulletTimer.is_stopped()):
			bulletTimer.start(1.7)
			print("shooting soon")
	
	if(atTargetHeight && changeHeightTimer.is_stopped()):
		changeHeightTimer.start()
	
	position.y = move_toward(position.y,targetHeight,V_speed)
	
	position.x -= H_speed
	
	if(health <= 0):
		level.score += 500
		queue_free()


func _on_change_height_timer_timeout() -> void:
	targetHeight = heights[randi_range(0,2)]
	atTargetHeight = false


func _on_body_entered(body: Node2D) -> void:
	if body is player:
		level.health -= 1


func _on_bullet_timer_timeout() -> void:
	if(atTargetHeight):
		level.pteradactyl_shoot(Vector2(position.x,position.y + 30))


func _on_area_entered(area: Area2D) -> void:
	print("hit dactyl")
	health -= 1
