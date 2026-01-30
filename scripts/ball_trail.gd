extends Line2D

var previous_position: Vector2 = Vector2.ZERO
const BALL_RADIUS: float = 16

func _ready() -> void:
	var texture = get_parent().texture
	previous_position = get_parent().global_position

func _process(delta: float) -> void:
	var current_position = get_parent().global_position
	var direction = (current_position - previous_position).normalized()
	
	add_point(current_position - BALL_RADIUS * direction)
	
	if points.size() > 25:
		remove_point(0)

	previous_position = current_position
