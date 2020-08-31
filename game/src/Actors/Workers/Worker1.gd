extends "res://src/Actors/Actor.gd"

const MOVE_SPEED = 80.0
const MOVE_ACCEL = 50.0
const JUMP_SPEED = 400.0
const FRICTION = 0.2
const AIR_FRICTION = 0.05

const ALARM_CALM = 0
const ALARM_SCARED = 0

var alarm = 0
var is_running = false;

func _ready():
	rng.randomize()
	set_physics_process(false);
	set_safe_margin(2)
	speed = Vector2( move_speed * MOVE_SPEED, 0 )
	var rand = rng.randf()
	facing = 1.0 if rand >= 0.5 else -1.0
	print('facing: ' , rand, ' : ', facing)

func _physics_process(delta):
	_velocity.y += delta * gravity
	if is_on_wall():
		facing *= -1.0
		is_running = true
		move_speed = 2.0
		speed = Vector2( move_speed * MOVE_SPEED, 0 )
		print('bump' , _velocity.x, facing)

	_velocity.x = facing * speed.x

	var player = get_node("AnimationPlayer")
	_velocity.y = move_and_slide(_velocity, FLOOR_NORMAL).y
	#if ( )
	if facing < 0.0:
		if is_running:
			player.play("run_left")
		else:
			player.play("walk_left")
	else:
		if is_running:
			player.play("run_right")
		else:
			player.play("walk_right")
	
