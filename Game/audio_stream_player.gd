extends AudioStreamPlayer

@onready var music = preload("res://Assets/sound/spaceship shooter .mp3")

func _ready() -> void:
	stream = music
	volume_db = -5.0
	play()
