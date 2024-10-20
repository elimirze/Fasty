extends Node

var _ad_view : AdView

func _ready():
	#The initializate needs to be done only once, ideally at app launch.
	MobileAds.initialize()

func _create_ad_view() -> void:
	#free memory
	if _ad_view:
		
		#destroy_ad_view()

	var unit_id : String
	if OS.get_name() == "Android":
		unit_id = "ca-app-pub-3940256099942544/6300978111"
	elif OS.get_name() == "iOS":
		unit_id = "ca-app-pub-3940256099942544/2934735716"

	_ad_view = AdView.new(unit_id, AdSize.BANNER, AdPosition.Values.TOP)
