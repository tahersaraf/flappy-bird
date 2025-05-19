extends Node2D

@onready var point = $Point
@onready var die = $Die

signal score 

const SPEED = 140

func _physics_process(delta):
	position.x += -SPEED * delta
	if global_position.x <= -200:
		queue_free()

func _on_pipe_body_entered(body):
	if body is Player:
		if body.has_method("die"):
			body.die()
			die.play()

func _on_score_area_body_exited(body):
	if body is Player:
		emit_signal("score")
		point.play()
