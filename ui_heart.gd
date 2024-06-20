@tool
extends Control
class_name HDUI_HEART

@export var value : int = 4:
	set(v):
		if not Engine.is_editor_hint() and not is_node_ready(): await ready
		v = clampi(v, 0, 4)
		value = v
		if value < 4:
			$AnimationPlayer.play("%s" % v)
			$center/Sprite2D.position = Vector2(0,0)
		else:
			$AnimationPlayer.play("4 %s" % randi_range(0,2))
			$center/Sprite2D.position = Vector2.from_angle(randf_range(0, TAU)) * Vector2(0.5,1) * randf_range(0.1,3)
	get:
		return value
		
		
