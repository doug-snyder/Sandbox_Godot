extends Panel


var count = 0
var physicsCount = 0
var sprite


func _ready():	
	sprite = Sprite.new()
	add_child(sprite)
	
	add_to_group( "Labels" )
	get_node( "Button" ).connect( "pressed", self, "_on_button_pressed" )
	print ( get_tree().get_nodes_in_group( "Labels" ) )
	
func _process(delta):
	count += 1
	get_node( "Label3" ).text = str( count )
	
func _physics_process(delta):
	physicsCount += 1
	get_node( "Label4" ).text = str( physicsCount )
	
func _on_button_pressed():
	get_node( "Label" ).text = "HELLO!"
	
	
#sprite.free()
	
#var scene = load("res://myscene.tcsn")

#var scene = preload("res://myscene.tcsn")
#var node = scene.instance()
#add_child(node)	
