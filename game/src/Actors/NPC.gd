extends "res://src/Actors/Actor.gd"

class_name NPC

const ALARM_CALM = 0
const ALARM_SCARED = 1
const ALARM_TERRIFIED = 2

const STATE_IDLE = 0
const STATE_WALKING = 5
const STATE_FLEEING = 10

export var state = 0
var _alarm = 0
var _timer = Node

func _init():
	_timer = Timer.new()
	add_child(_timer)
	_timer.paused = false
	_timer.connect('timeout', self, '_change_state')

func get_class(): return "NPC"

func _ready():
	#set_physics_process(false);
	_timer.start(rng.randf_range(2.0, 4.0))
	set_safe_margin(2)
	_check_state()

func _update_velocity(delta: float):
	_velocity.y += delta * gravity
	_velocity.x = _move_speed * _speed.x * _facing
	pass
	
func _update_alarm(alarm: int):
	match alarm:
		ALARM_CALM:
			_update_state(STATE_WALKING)
		ALARM_SCARED:
			_update_state(STATE_FLEEING, rng.randf_range(8.0, 15.0))
		ALARM_TERRIFIED:
			_update_state(STATE_FLEEING, rng.randf_range(8.0, 15.0))
		_:
			return
	_alarm = alarm
	pass

func _facing_rand():
	_facing = FACING_RIGHT if rng.randf() >= 0.5 else FACING_LEFT

func _update_state(set_state: int = 0, wait: float = 0.0):
	state = set_state
	_check_state()
	if wait <= 0.0:
		wait = rng.randf_range(3.0, 5.0)
	_timer.start(wait)
	
func _change_state():
	# if setting state, apply
	var wait = 0.0
	match state:
		STATE_IDLE:
			_facing_rand()
			state = STATE_WALKING
			wait = rng.randf_range(3.0, 5.0)
		STATE_FLEEING:
			state = STATE_IDLE
			wait = rng.randf_range(5.0, 10.0)
		# Default - reset to idle if walking or otherwise
		_:
			state = STATE_IDLE
			wait = rng.randf_range(5.0, 10.0)
	_check_state()
	_timer.start(wait)
	return

# Check the current state and set attributes
func _check_state():
	match state:
		STATE_WALKING:
			_move_speed = 1.0
			print(name, ': Walking: ', _move_speed)
		STATE_FLEEING:
			_move_speed = 2.0
			print(name, ': Fleeing: ', _move_speed)
		_:
			_move_speed = 0.0
			print(name, ': Idle: ', _move_speed)
	return
