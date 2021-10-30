extends ItemList
onready var viewport_rect := get_viewport_rect()
const Explosion := preload("res://Source/Explosion.tscn")
enum Weapon{
	UNARMED = -1,
	RIFLE,
	GRENADE	
}
func fire(at: Vector2):
	var parent = get_parent()
	var items := get_selected_items()
	if not items:
		return
	if len(items) > 1:
		breakpoint
	var item := items[0]
	match item:
		Weapon.RIFLE:
			$RayCast2D.cast_to = at - $RayCast2D.position
			$RayCast2D.force_raycast_update()
			if $RayCast2D.is_colliding():
				var collider = $RayCast2D.get_collider()
				collider.queue_free()
		Weapon.GRENADE:
			var explosion := Explosion.instance()
			explosion.position = at
			parent.add_child(explosion)
func _ready():
	add_item("rifle")
	add_item("grenade")
	$RayCast2D.position.y = viewport_rect.size.y
	$RayCast2D.position.x = (viewport_rect.size.x - rect_size.x) *0.5 + rect_size.x

func _input(event):
	if event is InputEventMouseButton and event.is_action_pressed("fire"):
		fire(event.position)


	
