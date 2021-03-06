extends Actor

const MOVE_SPEED = 200.0
const MOVE_ACCEL = 50.0
const JUMP_SPEED = 400.0
const FRICTION = 0.2
const AIR_FRICTION = 0.05
const STOMP_IMPULSE = 400.0

func _init():
	_speed = Vector2(MOVE_SPEED, JUMP_SPEED)

func get_class(): return "Lion"

func _ready():
	# inital speed
	pass

func _on_EnemyDetector_body_entered(_body):
	print("Ouch")
	pass

func _physics_process(_delta: float) -> void:
	update_velocity(_delta)
	_velocity = move_and_slide(_velocity, FLOOR_NORMAL)

func get_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		-1.0 if Input.get_action_strength("jump") and is_on_floor() else 0.0
	)

func update_velocity(_delta: float):
	var direction: = get_direction()
	# check inputs
	
	#if left:
		# left animation
	#elif right:
		# right animation
	
	_speed = Vector2(factors.move * MOVE_SPEED, factors.jump * JUMP_SPEED)
	var cur_friction = 0;
	var on_floor = is_on_floor()
	if direction.x:
		facing = FACING_LEFT if direction.x < 0 else FACING_RIGHT
		_velocity.x += direction.x * MOVE_ACCEL
		if abs( _velocity.x ) > _speed.x:
			_velocity.x = facing * _speed.x
	
	# else if still moving left / right figure friction
	elif _velocity.x:
		if on_floor:
			$player.play("idle")
			cur_friction = friction * FRICTION

		else:
			cur_friction = friction * AIR_FRICTION
		_velocity.x = lerp(_velocity.x, 0, cur_friction)
			
	# factor gravity
	_velocity.y += gravity * _delta
	
	if direction.y == -1.0:
		_velocity.y = _speed.y * direction.y

	# animation
	if on_floor:
		if direction.x:
			if facing == FACING_LEFT:
				$player.play("walk_left")
			else:
				$player.play("walk_right")
		else:
			$player.play("idle")
	else:
		if _velocity.y < 0:
			if facing == FACING_LEFT:
				$player.play("jump_up_left")
			else:
				$player.play("jump_up_right")
		else:
			if facing == FACING_LEFT:
				$player.play("jump_down_left")
			else:
				$player.play("jump_down_right")
	return

func calculate_stomp_velocty(velocity: Vector2) -> Vector2:
	var out: = velocity
	out.y = -STOMP_IMPULSE
	return out

