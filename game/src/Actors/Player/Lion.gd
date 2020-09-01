extends Actor

const MOVE_SPEED = 200.0
const MOVE_ACCEL = 50.0
const JUMP_SPEED = 400.0
const FRICTION = 0.2
const AIR_FRICTION = 0.05
const STOMP_IMPULSE = 400.0

func _ready():
	# inital speed
	_speed = Vector2(MOVE_SPEED, JUMP_SPEED)
	_player = get_node("AnimationPlayer")
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
	
	_speed = Vector2( _move_speed * MOVE_SPEED, _jump_speed * JUMP_SPEED )
	var cur_friction = 0;
	var on_floor = is_on_floor()
	if direction.x:
		_facing = FACING_LEFT if direction.x < 0 else FACING_RIGHT
		_velocity.x += direction.x * MOVE_ACCEL
		if abs( _velocity.x ) > _speed.x:
			_velocity.x = _facing * _speed.x
	
	# else if still moving left / right figure friction
	elif _velocity.x:
		if on_floor:
			_player.play("idle")
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
			if _facing == FACING_LEFT:
				_player.play("walk_left")
			else:
				_player.play("walk_right")
		else:
			_player.play("idle")
	else:
		if _velocity.y < 0:
			if _facing == FACING_LEFT:
				_player.play("jump_up_left")
			else:
				_player.play("jump_up_right")
		else:
			if _facing == FACING_LEFT:
				_player.play("jump_down_left")
			else:
				_player.play("jump_down_right")

	pass

func calculate_stomp_velocty(velocity: Vector2) -> Vector2:
	var out: = velocity
	out.y = -STOMP_IMPULSE
	return out

