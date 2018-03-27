extends Label


var accumulator = 0;

func _ready():
	add_to_group( "Labels" )

func _process(delta):
	accumulator += delta;
	text = str( accumulator )