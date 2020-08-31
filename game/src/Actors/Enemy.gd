extends "res://src/Actors/Actor.gd"

const MOVE_SPEED = 200.0
const MOVE_ACCEL = 50.0
const JUMP_SPEED = 400.0
const FRICTION = 0.2
const AIR_FRICTION = 0.05

const ALARM_CALM = 0
const ALARM_SCARED = 0

export var alarm = 0
export var player = 0

func _ready():
	set_physics_process(false);
	_velocity.x = -speed.x

func _physics_process(delta):
	_velocity.y += delta * gravity
	if is_on_wall():
		_velocity.x *= -1.0
		
	_velocity.y = move_and_slide(_velocity, FLOOR_NORMAL).y
	
