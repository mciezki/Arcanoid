extends CanvasLayer
@onready var diamonds_label: Label = $DiamondsContainer/DiamondsLabel
@onready var sapphires_label: Label = $SapphiresContainer/SapphiresLabel
@onready var balls_label: Label = $BallsContainer/BallsLabel

func _physics_process(_delta: float) -> void:
	balls_label.text = 'x' + str(Main.balls)
	diamonds_label.text = 'x' + str(Main.diamonds)
	sapphires_label.text = 'x' + str(Main.sapphires)
