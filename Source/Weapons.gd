extends ItemList
onready var viewport_rect := get_viewport_rect()

enum Weapon{
	UNARMED = -1,
	RIFLE,
	ROCKET	
}
func fire():
	var items := get_selected_items()
	if not items:
		return
	if len(items) > 1:
		breakpoint
	var item := items[0]
	match item:
		Weapon.RIFLE:
			pass
		Weapon.ROCKET:
			pass
func _ready():
	add_item("rifle")
	add_item("rocket")
	$RayCast2D.position.y = viewport_rect.size.y
	$RayCast2D.position.x = (viewport_rect.size.x - rect_size.x) *0.5 + rect_size.x

func _input(event):
	if event.is_action_pressed("fire"):
		fire()


	
