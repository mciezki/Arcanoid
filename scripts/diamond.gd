class_name Diamond
extends StaticBody2D

var is_destroyed := false

func _ready() -> void:
	add_to_group("diamonds")

func destroy_diamond() -> void:
	if is_destroyed:
		return
	
	is_destroyed = true
	
	Main.diamonds -= 1
	queue_free()
