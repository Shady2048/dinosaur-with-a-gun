extends Node2D

var bullet_scene: PackedScene = load("res://Game/Player/bullet.tscn")
var cactus_scene: PackedScene = load("res://Game/Cactus/cactus.tscn")
var pteradactyl_scene: PackedScene = load("res://Game/Pteradactyl/pteradactyl.tscn")
var enemy_bullet_scene: PackedScene = load("res://Game/Pteradactyl/enemy_bullet.tscn")
var battery_scene: PackedScene = load("res://Game/battery/battery.tscn")

var allowedToShoot = true
@onready var bulletCooldownTimer = $BulletCooldown

var health = 1
var ammo = 15

var frame = 0
var distance = 0
var score = 0

const BASE_CACT_SPEED = 5.0
var cact_speed = BASE_CACT_SPEED

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	update_distance()
	# handle player shooting
	if ammo > 0:
		player_shoot()

func player_shoot():
	if(Input.is_action_pressed("shoot") && allowedToShoot):
		var bullet = bullet_scene.instantiate()
		$Bullets.add_child(bullet)
		bullet.position = $Player.position
		allowedToShoot = false
		bulletCooldownTimer.start()
		ammo -= 1
		$AudioStreamPlayer2D.play()

func update_distance():
	frame += 1
	if frame == 5:
		distance += 1
		frame = 0
	
	cact_speed = BASE_CACT_SPEED + distance/100.0

func _on_bullet_cooldown_timeout() -> void:
	allowedToShoot = true

func spawn_cactus(pos: Vector2):
	var cactus = cactus_scene.instantiate()
	$Cacti.add_child(cactus)
	cactus.position = pos
	cactus.scale = Vector2(4,4)

func spawn_pteradactyl(pos: Vector2):
	var pteradactyl = pteradactyl_scene.instantiate()
	$Cacti.add_child(pteradactyl)
	pteradactyl.position = pos
	pteradactyl.scale = Vector2(4,4)

func pteradactyl_shoot(pos: Vector2):
	var enemy_bullet = enemy_bullet_scene.instantiate()
	$Bullets.add_child(enemy_bullet)
	enemy_bullet.position = pos

func spawn_battery(pos: Vector2):
	var battery = battery_scene.instantiate()
	$Cacti.add_child(battery)
	battery.position = pos
	battery.scale = Vector2(4,4)

func player_death():
	Global.score = score
	Global.distance = distance
	get_tree().change_scene_to_file("res://Game/Menus/Game Over/game_over.tscn")
