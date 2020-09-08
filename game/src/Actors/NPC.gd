extends "res://src/Actors/Actor.gd"

class_name NPC

const ALARM_CALM = 0
const ALARM_SCARED = 1
const ALARM_TERRIFIED = 2

const ACTIONS = {
	"idle" : 0,
	"face_reverse" : 1,
	"face_random" : 2,
	"shoved": 5,
	"getup": 7,
	"walking" : 10,
	"running" : 20
}

const ACTIVITIES = {
	"mozy" : [ 
		ACTIONS.idle,
		ACTIONS.face_random,
		ACTIONS.idle,
		ACTIONS.walking,
	],
	"shoved" : [
		ACTIONS.shoved,
		ACTIONS.getup,
		ACTIONS.running
	]
}

export var activity = ACTIVITIES.mozy
var action = ACTIONS.idle
export var action_queue = []
export var alarm = ALARM_CALM
var _action_index = 0
var _alarm_timer = Node
var _action_timer = Node

func _init():
	_action_timer = Timer.new()
	add_child(_action_timer)
	_alarm_timer = Timer.new()
	add_child(_alarm_timer)
	_action_timer.set_one_shot(true)
	_alarm_timer.set_one_shot(true)
	_action_timer.connect('timeout', self, '_next_action')
	_alarm_timer.connect('timeout', self, '_downgrade_alarm')

func get_class(): return "NPC"

func _ready():
	#set_physics_process(false);
	#set_safe_margin(2)
	_action_timer.stop()
	_next_action()

func _update_velocity(delta: float):
	if ! is_on_floor():
		_velocity.y += delta * gravity
	# if slow stop, scale move factor down to 0
	if factors.slowstop > 0.0 && factors.move:
		factors.move = lerp(factors.move, 0, factors.slowstop)
	_velocity.x = factors.move * _speed.x * facing
	pass

func _facing_rand():
	facing = FACING_RIGHT if rng.randf() >= 0.5 else FACING_LEFT
	
# pull next action
func _next_action():
	# if setting action, apply
	var new_action = action_queue.pop_front()
	if new_action == null:
		if alarm > ALARM_CALM:
			new_action = ACTIONS.running
		else:
			# resume default activity
			action_queue = activity.duplicate();
			new_action = action_queue.pop_front()
	_do_action(new_action)

# Set activity
func _set_activity(new_activity: Array):
	action_queue = new_activity.duplicate()

# Do a new activity / series of actions
func _do_activity(new_activity: Array):
	action_queue = new_activity.duplicate()
	_next_action()

# Check the current action and set attributes
func _do_action(new_action: int, clear_queue: bool = false) -> void:
	action = new_action
	if clear_queue:
		action_queue = []
	var wait = rng.randf_range(3.0, 5.0)
	
	# reset some factors
	factors.slowstop = 0.0;
	
	match action:
		ACTIONS.walking:
			factors.move = 1.0
			print(name, ': Walking: ', factors.move)
			wait = rng.randf_range(3.0, 5.0)
		ACTIONS.running:
			factors.move = 2.0
			print(name, ': Fleeing: ', factors.move)
			wait = rng.randf_range(4.0, 5.0)
		ACTIONS.face_reverse:
			facing *= -1
			wait = rng.randf_range(1.0, 2.0)
		ACTIONS.face_random:
			_facing_rand()
			wait = 0.0
		ACTIONS.shoved:
			wait = rng.randf_range(0.5, 2.0)
			factors.slowstop = 0.1
			factors.move = 1.0
		ACTIONS.getup:
			wait = 0.5
			factors.move = 0.0
		_:
			factors.move = 0.0
			print(name, ': Idle: ', factors.move)
			
	_do_animation()
	if wait > 0.0:
		_action_timer.start(wait)
	else:
		_next_action()
	return

# overridden by the child to handle animation
func _do_animation() -> void:
	pass

# alarm methods
func _update_alarm(new_alarm: int):
	alarm = new_alarm
	if alarm == ALARM_CALM:
		_alarm_timer.stop()
		_next_action()
	else:
		_alarm_timer.start(rng.randf_range(6.0, 12.0))

# After alarm timer winds down, downgrade alarm
func _downgrade_alarm():
	match alarm:
		ALARM_TERRIFIED:
			print(name, ': still scared...')
			_update_alarm(ALARM_SCARED)
		_:
			print(name, ': calming down...')
			_update_alarm(ALARM_CALM)
	


	
