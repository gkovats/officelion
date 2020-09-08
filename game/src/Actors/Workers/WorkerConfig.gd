extends Node

const HEAD = 'head'
const FACE = 'face'
const HAIR = 'hair'
const ARM_F = 'arm_f'
const ARM_B = 'arm_b'
const SKIN = 'skin'
const TOP = 'top'
const BOTTOM = 'bottom'
const SKIN_TYPES = [ 0, 1 ]

const TEXTURES = [
	HEAD,
	FACE,
	ARM_B,
	ARM_F,
	TOP,
	BOTTOM
]

const SKIN_TONES = [
	Color(1.0, 1.0, 1.0),
	Color(0.5, 0.35, 0.2),
	Color(0.25, 0.15, 0.05)
]

# Skin related textures: head, arms
const TEXTURES_SKIN = {
	# pale
	0 : {
		HEAD : preload("res://assets/actors/worker/head.png"),
		ARM_B : preload("res://assets/actors/worker/arm.b.png"),
		ARM_F : preload("res://assets/actors/worker/arm.f.png"),
	}
}

# hair
const TEXTURES_HAIR = [
	preload("res://assets/actors/worker/hair.balding.png"),
	preload("res://assets/actors/worker/hair.cropped.png"),
	preload("res://assets/actors/worker/hair.full.png"),
	preload("res://assets/actors/worker/hair.short.png")
]

const TEXTURES_FACE = [
	preload("res://assets/actors/worker/face.blue.png"),
	preload("res://assets/actors/worker/face.brown.png")
]

const TEXTURES_TOP = [
	preload("res://assets/actors/worker/shirt.blue.png"),
	preload("res://assets/actors/worker/shirt.white.2.png"),
	preload("res://assets/actors/worker/shirt.white.png")
]

const TEXTURES_BOTTOM = [
	preload("res://assets/actors/worker/bottom.tan.png")
]

# given the Worker instance, set up nodes / textures
static func config(worker) -> void:
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var skin = TEXTURES_SKIN[0]
	var textures = {
		HEAD: skin[HEAD],
		ARM_B: skin[ARM_B],
		ARM_F: skin[ARM_F],
		TOP: TEXTURES_TOP[rng.randi_range(0, TEXTURES_TOP.size() - 1)],
		BOTTOM: TEXTURES_BOTTOM[rng.randi_range(0, TEXTURES_BOTTOM.size() - 1)],
		FACE: TEXTURES_FACE[rng.randi_range(0, TEXTURES_FACE.size() - 1)],
		HAIR: TEXTURES_HAIR[rng.randi_range(0, TEXTURES_HAIR.size() - 1)],
	}
	worker.get_node(HEAD).texture = textures[HEAD]
	worker.get_node(ARM_B).texture = textures[ARM_B]
	worker.get_node(ARM_F).texture = textures[ARM_F]
	worker.get_node(HAIR).texture = textures[HAIR]
	worker.get_node(FACE).texture = textures[FACE]

	# variation on skin tone
	var skin_tone_index = rng.randi_range(0, SKIN_TONES.size() - 1);
	var skin_tone = SKIN_TONES[skin_tone_index]
	worker.get_node(HEAD).modulate = skin_tone
	worker.get_node(ARM_B).modulate = skin_tone
	worker.get_node(ARM_F).modulate = skin_tone
	worker.get_node(HAIR).modulate = skin_tone
	worker.get_node(FACE).modulate = skin_tone

	worker.get_node(TOP).texture = textures[TOP]
	worker.get_node(BOTTOM).texture = textures[BOTTOM]
	
	# variation on clothing
	worker.get_node(TOP).modulate = Color(rng.randf_range(0.8, 1.0), rng.randf_range(0.8, 1.0), rng.randf_range(0.8, 1.0))
	worker.get_node(BOTTOM).modulate = Color(rng.randf_range(0.8, 1.0), rng.randf_range(0.8, 1.0), rng.randf_range(0.8, 1.0))
	return
	
	
