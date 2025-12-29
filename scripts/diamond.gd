class_name Diamond
extends StaticBody2D

func _ready() -> void:
	add_to_group("diamonds")

func destroy_diamond() -> void:
	queue_free()
