class_name Sapphire
extends StaticBody2D

var max_balls: int = randi_range(3,12)

func _ready() -> void:
	add_to_group("sapphires")

func destroy_sapphire(original_ball: Ball) -> void:
	var main_scene = get_parent()
	
	for i in range(max_balls):
		var new_ball = original_ball.duplicate()
		new_ball.position = original_ball.position
		new_ball.is_moving = true
		
		new_ball.velocity = original_ball.velocity.rotated(randf_range(-PI / 8, PI / 8))
		main_scene.call_deferred("add_child", new_ball)
		Main.balls += 1
	
	queue_free()
