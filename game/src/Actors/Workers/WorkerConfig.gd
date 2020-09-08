extends Node

const HEAD = 'head'
const FACE = 'face'
const HAIR = 'hair'
const ARM_F = 'arm.f'
const ARM_B = 'arm.b'
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

# get skin textures: head, arm.b, arm.f
static func get_textures() -> Dictionary:
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var skin = TEXTURES_SKIN[0]
	var texture = {
		HEAD: skin[HEAD],
		ARM_B: skin[ARM_B],
		ARM_F: skin[ARM_F],
		TOP: TEXTURES_TOP[rng.randi_range(0, TEXTURES_TOP.size() - 1)],
		BOTTOM: TEXTURES_BOTTOM[rng.randi_range(0, TEXTURES_BOTTOM.size() - 1)],
		FACE: TEXTURES_FACE[rng.randi_range(0, TEXTURES_FACE.size() - 1)],
		HAIR: TEXTURES_HAIR[rng.randi_range(0, TEXTURES_HAIR.size() - 1)],
	};
	return texture
