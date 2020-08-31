extends KinematicBody2D

const FLOOR_NORMAL = Vector2.UP

class_name Actor

var rng = RandomNumberGenerator.new()
var speed = Vector2( 300.0, 1600.0 )
var gravity: = 1000.0
var move_speed: = 1.0
var jump_speed: = 1.0
var friction: = 1.0
var facing: = -1.0

var _velocity: = Vector2.ZERO


# func _physics_process( delta: float ) -> void:

	
