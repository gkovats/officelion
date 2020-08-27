extends Actor

const MOVE_SPEED = 400.0
const MOVE_ACCEL = 50.0
const JUMP_SPEED = 1600.0
const FRICTION = 0.2
const AIR_FRICTION = 0.05

# @TODO: Move direction elsewhere
# @TODO: 
export var stomp_impulse: = 500.0
export var move_speed: = 1.0
export var jump_speed: = 1.0
export var friction: = 1.0
export var facing: = -1

func _ready():
	# inital speed
	pass

func _on_EnemyDetector_area_entered(_area):
	print("Boink!")
	_velocity = calculate_stomp_velocty(_velocity)

func _on_EnemyDetector_body_entered(_body):
	print("Ouch")
	queue_free()
	pass # Replace with function body.

func _physics_process(_delta: float) -> void:
	_velocity = calculate_move_velocty(_delta)
	_velocity = move_and_slide(_velocity, FLOOR_NORMAL)

func get_speed() -> Vector2:
	return Vector2( move_speed * MOVE_SPEED, jump_speed * JUMP_SPEED )

func get_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		-1.0 if Input.get_action_strength("jump") and is_on_floor() else 0.0
	)

func calculate_move_velocty(_delta: float) -> Vector2:
	var direction: = get_direction()
	# check inputs
	
	#if left:
		# left animation
	#elif right:
		# right animation
	
	var new_velocity: = _velocity
	var speed = get_speed();
	var cur_friction = 0;
	var player = get_node("AnimationPlayer")
	var on_floor = is_on_floor()
	if direction.x:
		facing = -1 if direction.x < 0 else 1
		new_velocity.x += direction.x * MOVE_ACCEL
		if abs( new_velocity.x ) > speed.x:
			new_velocity.x = direction.x * speed.x
	
	# else if still moving left / right figure friction
	elif new_velocity.x:
		if on_floor:
			player.play("idle")
			cur_friction = friction * FRICTION

		else:
			cur_friction = friction * AIR_FRICTION
		new_velocity.x = lerp(new_velocity.x, 0, cur_friction)
			
	# factor gravity
	new_velocity.y += gravity * _delta
	
	if direction.y == -1.0:
		new_velocity.y = speed.y * direction.y

	# animation
	if on_floor:
		if direction.x:
			if facing < 0:
				player.play("walk_left")
			else:
				player.play("walk_right")
		else:
			player.play("idle")
	else:
		if new_velocity.y < 0:
			if facing < 0:
				player.play("jump_up_left")
			else:
				player.play("jump_up_right")
		else:
			if facing < 0:
				player.play("jump_down_left")
			else:
				player.play("jump_down_right")

	
	#if Input.is_action_just_released("jump") and new_velocity.y < 0.0:
	#	new_velocity.y = 0.0
	
	return new_velocity

func calculate_stomp_velocty(velocity: Vector2) -> Vector2:
	var out: = velocity
	out.y = -stomp_impulse
	return out

