extends Node2D

@onready var level = $".."

@onready var trySpawnTimer = $try_Spawn_Timer

var base_chance = 80.0
var spawn_chance

func _ready() -> void:
	trySpawnTimer.start(3.0)

func _process(delta: float) -> void:
	if(level.distance > 150):
		spawn_chance = base_chance + level.distance/10
	else:
		spawn_chance = 0
func _on_try_spawn_timer_timeout() -> void:
	print("trying to spawn dactyl")
	if randf_range(1.0,100.0) <= spawn_chance:
		level.spawn_pteradactyl(position)
	trySpawnTimer.start(randf_range(9.8,10.8))
	
