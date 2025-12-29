extends Node2D
#36x32 grid
var max_stones_per_row: int = 36

@export var diamond_scene: PackedScene
@export var sapphire_scene: PackedScene

var max_sapphire_count: int = randi_range(2, 12)
@export var diamond_count: int = 1292 - max_sapphire_count  

var all_stones_count: int = max_sapphire_count + diamond_count

@export var cell_size: int = 16

var sapphires_left: int = max_sapphire_count

var spawn_area := Rect2(64, 96, 576, 512)

func _ready() -> void:
	generate_game_objects()

func generate_game_objects() -> void:
	if not diamond_scene:
		push_error("No assigned diamond")
		return

	var columns = int((spawn_area.size.x / cell_size) / 2)
	var rows = int(spawn_area.size.y / cell_size)
	
	var available_slots: Array[Vector2] = []
	
	for x in range(columns):
		for y in range(rows):
			var can_create_spawn_point: bool = randi_range(2,7) % 2 == 0
			if can_create_spawn_point:
				available_slots.append(Vector2(x, y))
				available_slots.append(Vector2(max_stones_per_row - 1 - x, y))
				
	var limit = min(all_stones_count, available_slots.size())
	
	for i in range(limit):
		var grid_pos = available_slots[i] 
		create_stone(grid_pos)
	
	Main.diamonds = get_tree().get_node_count_in_group('diamonds')
	Main.sapphires = get_tree().get_node_count_in_group('sapphires')
	Main.balls = get_tree().get_node_count_in_group('balls')
	
	if Main.balls and Main.sapphires and Main.diamonds:
		Main.level_loaded = true
	

func create_stone(grid_pos: Vector2) -> void:
	var stone
	var can_spawn_sapphire = randi_range(1,50) < 3
	
	if can_spawn_sapphire and sapphires_left > 0:
		sapphires_left = sapphires_left - 1
		stone = sapphire_scene.instantiate()
	else:
		stone = diamond_scene.instantiate()
	
	add_child(stone)
	
	var pos_x = spawn_area.position.x + (grid_pos.x * cell_size) + (cell_size / 2.0)
	var pos_y = spawn_area.position.y + (grid_pos.y * cell_size) + (cell_size / 2.0)
	
	stone.position = Vector2(pos_x, pos_y)
