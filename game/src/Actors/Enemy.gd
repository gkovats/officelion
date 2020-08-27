extends "res://src/Actors/Actor.gd"

func _ready():
	set_physics_process(false);
	_velocity.x = -speed.x

func _on_StompDetector_body_entered(body:PhysicsBody2D):
	body
	_velocity.x = 0;
	#get_node("CollisionShape2D").disabled = true
	queue_free()

func _physics_process(delta):
	_velocity.y += delta * gravity
	if is_on_wall():
		_velocity.x *= -1.0
		
	_velocity.y = move_and_slide(_velocity, FLOOR_NORMAL).y
	
