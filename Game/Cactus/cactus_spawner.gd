extends Node2D

@onready var level = $".."

@onready var trySpawnTimer = $Try_Spawn_Timer

var base_chance = 25.0
var spawn_chance

func _ready() -> void:
	trySpawnTimer.start(3.0)

func _process(delta: float) -> void:
	spawn_chance = base_chance + level.distance/10

func _on_try_spawn_timer_timeout() -> void:
	if randi_range(1,30) != 1:
		# try spawn cactus
		if randf_range(1.0,100.0) <= spawn_chance:
			level.spawn_cactus(position)
	else:
		level.spawn_battery(Vector2(position.x,position.y - 20))
	
	trySpawnTimer.start(randf_range(0.8,1.8))
