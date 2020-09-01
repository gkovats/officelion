extends KinematicBody2D

class_name Actor

const FLOOR_NORMAL = Vector2.UP

# Facing
const FACING_LEFT  = -1.0
const FACING_RIGHT = 1.0

# Speed
var _speed: = Vector2.ZERO # speed factor
var _move_speed: = 1.0 # speed factor
var _jump_speed: = 1.0 # jump factor
var _velocity: = Vector2.ZERO # current velocity

# Animation Player
var _player = Node

var rng = RandomNumberGenerator.new()
var gravity: = 1000.0
var friction: = 1.0

# which direction facing
export var _facing: = -1.0

func _init():
	rng.randomize()


# func _update_velocity() -> Vector2:

# func _physics_process( delta: float ) -> void:

	
