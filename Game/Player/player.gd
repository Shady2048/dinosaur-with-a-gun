extends CharacterBody2D
class_name player

const SPEED = 600.0
const JUMP_VELOCITY = -1300.0


var jumpBuffer = false
@onready var jumpTimer = $JBufferTimer
var wasOnGround = false
@onready var level = $".."

func _process(delta: float) -> void:
	if level.health <= 0:
		level.player_death()

func _physics_process(delta: float) -> void:
	if level.health > 0:
		move_player(delta)

func move_player(delta: float):
		# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta * 3.75

	# Handle jump.
	if Input.is_action_just_pressed("up"):
		if is_on_floor():
			jump()
		else:
			if !jumpBuffer:
				jumpBuffer = true
				jumpTimer.start()
				print("Jump Timer start")
	
	# Allows a jump in the jump buffer timer window
	if (!wasOnGround && is_on_floor()) && !jumpTimer.is_stopped():
		jump()
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
		# cuts the jump shorter if the player releases up early
	if Input.is_action_just_released("up") && velocity.y < 0:
		velocity.y *= 0.5
	
	if Input.is_action_pressed("down"):
		set_collision_mask_value(5,false)
		if(is_on_floor()):
			velocity.y += 100
		else:
			velocity.y += 45
	else:
		set_collision_mask_value(5,true)
	
	wasOnGround = is_on_floor()
	
	move_and_slide()

func jump():
	velocity.y = JUMP_VELOCITY


func _on_j_buffer_timer_timeout() -> void:
	jumpBuffer = false
