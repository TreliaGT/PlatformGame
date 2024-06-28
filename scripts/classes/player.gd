class_name Player extends CharacterBody2D

var SPEED = Global.speed
var JUMP_VELOCITY = Global.jump_vol
var JUMP_TIME = Global.jump_time
var COYOTE_TIME = Global.coyote_time
var GRAVITY_MULTIPLIER = Global.gravity_multiplier

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var is_jumping : bool = false
var jump_timer : float = 0
var coyote_timer : float = 0
var can_control :bool = true
@onready var sprite = $AnimatedSprite2D;

func get_input():
	var input_direction = Input.get_vector("MOVE_LEFT", "MOVE_RIGHT", "MOVE_UP", "MOVE_DOWN")
	velocity = input_direction * SPEED


func _physics_process(delta):
	if not can_control:
		return
	# Add the gravity.
	if not is_on_floor() and not is_jumping:
		velocity.y += gravity * delta
		coyote_timer += delta
	else:
		coyote_timer = 0

	# Handle jump.
	if Input.is_action_just_pressed("MOVE_UP") and (is_on_floor() or coyote_timer < COYOTE_TIME):
		velocity.y = JUMP_VELOCITY
		is_jumping = true
		
	elif Input.is_action_pressed("MOVE_UP") and is_jumping:
		velocity.y = JUMP_VELOCITY
		
	if Input.is_action_pressed("MOVE_UP") and is_jumping and jump_timer < JUMP_TIME:
		jump_timer += delta
	else:
		is_jumping = false
		jump_timer = 0
		
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("MOVE_LEFT", "MOVE_RIGHT")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if direction != 0:
		sprite.flip_h = direction > 0
	_handleAnimation(direction)
	move_and_slide()
	
func _handleAnimation(direction) -> void:
	if abs(direction) > 0.1 and is_on_floor():
		sprite.play("Walking")
	elif not is_on_floor():
		sprite.play("Walking")
	else:
		sprite.play("Idle")
		
func _handle_danger() ->void:
	print('player died')
	visible = false
	can_control = false
	
	await get_tree().create_timer(1).timeout
	_reset_player()
	
func _reset_player() ->void :
	global_position = Levelmanager.loaded_level.spawnpoint.global_position
	visible = true
	can_control = true
	
func _high_jump() ->void :
	print("Jump!!")
	velocity.y = JUMP_VELOCITY * 3
	is_jumping = true
