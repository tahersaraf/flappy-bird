extends CanvasLayer

signal start_game

@onready var start_message = $StartMenu/StartMessage
@onready var score_label = $GameOverMenu/VBoxContainer/ScoreLabel
@onready var high_score_label = $GameOverMenu/VBoxContainer/HighScoreLabel
@onready var game_over_menu = $GameOverMenu

var game_started = false

func _input(event):
	if event.is_action_pressed("flap") && !game_started:
		emit_signal("start_game")
		var tween = create_tween()
		tween.tween_property($StartMenu/StartMessage, "modulate:a", 0,1)
		game_started = true

func init_game_over_menu(score,highscore):
	score_label.text = "SCORE: " + str(score)
	high_score_label.text = "BEST: " + str(highscore)
	game_over_menu.visible = true
	

func _on_restart_pressed():
	get_tree().reload_current_scene()
