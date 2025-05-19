extends RigidBody2D
class_name Player

signal died

@export var FLAP_FORCE = -500

const MAX_ROTATION = -30.0

@onready var animator = $AnimationPlayer
@onready var flapping = $AnimatedSprite2D
@onready var hit = $Hit
@onready var wing = $Wing

var started = false
var alive = true

func _ready():
	# Play Idle animation when the scene starts
	animator.play("Idle")
	contact_monitor = true
	max_contacts_reported = 1

func _physics_process(delta):
	if Input.is_action_just_pressed("flap") && alive:
		if !started:
			start()
		flap()
	
	if rotation_degrees <= MAX_ROTATION:
		angular_velocity = 0
		rotation_degrees = MAX_ROTATION
	
	if linear_velocity.y > 0:
		if rotation_degrees  <= 90:
			angular_velocity = 5
		else:
			angular_velocity = 0
			
	# Stop horizontal movement if colliding with ceiling
	for i in get_colliding_bodies():
		if i.is_in_group("ceiling"):
			linear_velocity.x = 0
		

func start():
	if started: return
	started = true
	gravity_scale = 2.0
	animator.play("Flap")
	

func flap():
	linear_velocity.y = FLAP_FORCE
	linear_velocity.x = 0
	angular_velocity = -8.0
	wing.play()
	
func die():
	if !alive: return
	alive = false
	animator.stop()
	flapping.stop()
	hit.play()
	emit_signal("died")
