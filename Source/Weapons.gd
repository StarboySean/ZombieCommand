extends ItemList
signal rifle(at)
signal grenade(at)
var disabled := false

const Explosion := preload("res://Source/Explosion.tscn")
enum Weapon{
	UNARMED = -1,
	RIFLE,
	GRENADE	
}
func fire(at: Vector2):
	if disabled:
		return
	if at.x <= rect_size.x:
		return
	var parent = get_parent()
	var items := get_selected_items()
	if not items:
		return
	if len(items) > 1:
		breakpoint
	var item := items[0]
	match item:
		Weapon.RIFLE:
			emit_signal("rifle", at)
		Weapon.GRENADE:
			var explosion := Explosion.instance()
			explosion.position = at
			parent.add_child(explosion)
func _ready():
	add_item("rifle")
	add_item("grenade")
	

func _input(event):
	if event is InputEventMouseButton and event.is_action_pressed("fire"):
		fire(event.position)


	
