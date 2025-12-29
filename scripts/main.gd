extends Node

var level_loaded := false
var balls: int = 0
var diamonds: int = 0
var sapphires: int = 0

func _process(_delta: float) -> void:
	if level_loaded:
		check_game_over()
#
##___________________________________________
#
func check_game_over() -> void:
	if diamonds == 0 and sapphires == 0:
		reset_game_state()
		get_tree().change_scene_to_file("res://scenes/win_menu.tscn")
		
	if balls == 0:
		reset_game_state()
		get_tree().change_scene_to_file("res://scenes/loose_menu.tscn")

func reset_game_state() -> void:
	level_loaded = false # Rozbrajamy system, żeby komunikaty nie spamowały
