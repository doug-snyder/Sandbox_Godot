extends KinematicBody2D


const MAX_HEALTH = 2
const SPEED = 0
const TYPE = "ENEMY"

var health = MAX_HEALTH
var hit_stun = 0
var knock_dir = Directions.center
var move_dir = Directions.center
var sprite_dir = "down"
var texture_default = null
var texture_hurt = null


func _ready():
	texture_default = $Sprite.texture
	texture_hurt = load($Sprite.texture.get_path().replace(".png", "_hurt.png"))


func movement_loop():
	var motion
	if hit_stun == 0:
		motion = move_dir.normalized() * SPEED
	else:
		motion = knock_dir.normalized() * 125
	
	move_and_slide(motion, Directions.center)
	
	
func sprite_dir_loop():
	match move_dir:
		Directions.left:
			sprite_dir = "left"
		Directions.right:
			sprite_dir = "right"
		Directions.up:
			sprite_dir = "up"
		Directions.down:
			sprite_dir = "down"
	
			
func anim_switch(animation):
	var new_anim = str(animation, sprite_dir)
	
	if $Anim.current_animation != new_anim:
		$Anim.play(new_anim)


func damage_loop():
	if hit_stun > 0:
		hit_stun -= 1
		$Sprite.texture = texture_hurt
	else:
		$Sprite.texture = texture_default
		if TYPE == "ENEMY" && health <= 0:
			var death_animation = preload("res://Enemies/Enemy_Death.tscn").instance()
			get_parent().add_child(death_animation)
			death_animation.global_transform = global_transform
			queue_free()
	for area in $Hitbox.get_overlapping_areas():
		var body = area.get_parent()
		if hit_stun == 0 and body.get("DAMAGE") != null and body.get("TYPE") != TYPE:
			health -= body.get("DAMAGE")
			hit_stun = 10
			knock_dir = global_transform.origin - body.global_transform.origin


func use_item(item):
	var new_item = item.instance()
	new_item.add_to_group(str(new_item.get_name(), self))
	add_child(new_item)
	
	# Check if more than one item is "out". If so, free new_item because it's redundant.
	if get_tree().get_nodes_in_group(str(new_item.get_name(), self)).size() > new_item.max_amount:
		new_item.queue_free()
