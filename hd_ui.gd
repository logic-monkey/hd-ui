extends CanvasLayer

@onready var heart_bar = $Control/MarginContainer/heart_bar

var sc = 0
var hs = 122
func _process(_delta):
	if not "hiscore" in _INIT.data:
		_INIT.data["hiscore"] = 123
	if hs < _INIT.data.hiscore:
		hs += 1
		%hiscore.text = "%03d" % hs
	if not has_node("/root/_PS"): return
	if sc == _PS.points: return
	if sc > _PS.points: sc -= 1
	if sc < _PS.points: sc += 1
	%score.text = "%03d" % sc
