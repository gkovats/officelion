extends KinematicBody2D

class_name Actor

const FLOOR_NORMAL = Vector2.UP

# Facing
const FACING_LEFT  = -1.0
const FACING_RIGHT = 1.0

# Factors
var factors: = {
	"move": 1.0,
	"jump": 1.0,
	"slowstop": 0.0
}
var _speed: = Vector2.ZERO # speed factor
var _velocity: = Vector2.ZERO # current velocity

# Animation Player
var rng = RandomNumberGenerator.new()
var gravity: = 1000.0
var friction: = 1.0

# which direction facing
export var facing: = -1.0

func _init():
	rng.randomize()


# func _update_velocity() -> Vector2:

# func _physics_process( delta: float ) -> void:

	
