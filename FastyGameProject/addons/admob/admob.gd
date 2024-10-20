@icon("res://admob-lib/icon.png")
class_name AdMob
extends Node

signal banner_loaded
signal banner_failed_to_load(error_code)
signal interstitial_failed_to_load(error_code)
signal interstitial_loaded
signal interstitial_opened
signal interstitial_closed
signal interstitial_clicked
signal interstitial_impression
signal rewarded_video_opened
signal rewarded_video_loaded
signal rewarded_video_closed
signal rewarded_video_failed_to_load(error_code)
signal rewarded_interstitial_opened
signal rewarded_interstitial_loaded
signal rewarded_interstitial_closed
signal rewarded_interstitial_failed_to_load(error_code)
signal rewarded_interstitial_failed_to_show(error_code)
signal rewarded(currency, amount)
signal rewarded_clicked
signal rewarded_impression

@export var is_real:bool :
	set = is_real_set
@export var banner_on_top:bool = true
# SMART_BANNER is deprecated
@export_enum("ADAPTIVE_BANNER", "SMART_BANNER", "BANNER", "LARGE_BANNER", "MEDIUM_RECTANGLE", "FULL_BANNER", "LEADERBOARD") var banner_size : String = "ADAPTIVE_BANNER"
@export var banner_id:String
@export var interstitial_id:String
@export var rewarded_id:String
@export var rewarded_interstitial_id:String
@export var child_directed:bool = false :
	set = child_directed_set
@export var is_personalized:bool = true :
	set = is_personalized_set
@export_enum("G", "PG", "T", "MA") var max_ad_content_rate: String = "G" :
	set = max_ad_content_rate_set

var _admob_singleton = null
var _is_interstitial_loaded:bool = false
var _is_rewarded_video_loaded:bool = false
var _is_rewarded_interstitial_loaded:bool = false


func _enter_tree():
	if not init():
		print_debug("AdMob Java Singleton not found. This plugin will only work on Android")


func is_real_set(new_val) -> void:
	is_real = new_val
# warning-ignore:return_value_discarded
	init()

func child_directed_set(new_val) -> void:
	child_directed = new_val
# warning-ignore:return_value_discarded
	init()

func is_personalized_set(new_val) -> void:
	is_personalized = new_val
# warning-ignore:return_value_discarded
	init()


func max_ad_content_rate_set(new_val) -> void:
	if new_val not in ["G", "PG", "T", "MA"]:
		max_ad_content_rate = "G"
		print_debug("Invalid max_ad_content_rate, using 'G'")
	else:
		max_ad_content_rate = new_val
	init()


func init() -> bool:
	if not Engine.has_singleton("GodotAdMob"):
		return false

	_admob_singleton = Engine.get_singleton("GodotAdMob")

	# check if one signal is already connected
	if not _admob_singleton.on_admob_ad_loaded.is_connected(_on_admob_ad_loaded):
		connect_signals()

	_admob_singleton.initWithContentRating(
		is_real,
		child_directed,
		is_personalized,
		max_ad_content_rate
	)
	return true


# connect the AdMob Java signals
func connect_signals() -> void:
	_admob_singleton.on_admob_ad_loaded.connect(_on_admob_ad_loaded)
	_admob_singleton.on_admob_banner_failed_to_load.connect(_on_admob_banner_failed_to_load)
	_admob_singleton.on_interstitial_failed_to_load.connect(_on_interstitial_failed_to_load)
	_admob_singleton.on_interstitial_opened.connect(_on_interstitial_opened)
	_admob_singleton.on_interstitial_loaded.connect(_on_interstitial_loaded)
	_admob_singleton.on_interstitial_close.connect(_on_interstitial_close)
	_admob_singleton.on_interstitial_clicked.connect(_on_interstitial_clicked)
	_admob_singleton.on_interstitial_impression.connect(_on_interstitial_impression)
	_admob_singleton.on_rewarded_video_ad_loaded.connect(_on_rewarded_video_ad_loaded)
	_admob_singleton.on_rewarded_video_ad_opened.connect(_on_rewarded_video_ad_opened)
	_admob_singleton.on_rewarded_video_ad_closed.connect(_on_rewarded_video_ad_closed)
	_admob_singleton.on_rewarded_video_ad_failed_to_load.connect(_on_rewarded_video_ad_failed_to_load)
	_admob_singleton.on_rewarded_interstitial_ad_loaded.connect(_on_rewarded_interstitial_ad_loaded)
	_admob_singleton.on_rewarded_interstitial_ad_opened.connect(_on_rewarded_interstitial_ad_opened)
	_admob_singleton.on_rewarded_interstitial_ad_closed.connect(_on_rewarded_interstitial_ad_closed)
	_admob_singleton.on_rewarded_interstitial_ad_failed_to_load.connect(_on_rewarded_interstitial_ad_failed_to_load)
	_admob_singleton.on_rewarded_interstitial_ad_failed_to_show.connect(_on_rewarded_interstitial_ad_failed_to_show)
	_admob_singleton.on_rewarded.connect(_on_rewarded)
	_admob_singleton.on_rewarded_clicked.connect(_on_rewarded_clicked)
	_admob_singleton.on_rewarded_impression.connect(_on_rewarded_impression)


func load_banner() -> void:
	if _admob_singleton != null:
		_admob_singleton.loadBanner(banner_id, banner_on_top, banner_size)


func load_interstitial() -> void:
	if _admob_singleton != null:
		_admob_singleton.loadInterstitial(interstitial_id)


func is_interstitial_loaded() -> bool:
	if _admob_singleton != null:
		return _is_interstitial_loaded
	return false


func load_rewarded_video() -> void:
	if _admob_singleton != null:
		_admob_singleton.loadRewardedVideo(rewarded_id)


func is_rewarded_video_loaded() -> bool:
	if _admob_singleton != null:
		return _is_rewarded_video_loaded
	return false


func load_rewarded_interstitial() -> void:
	if _admob_singleton != null:
		_admob_singleton.loadRewardedInterstitial(rewarded_interstitial_id)


func is_rewarded_interstitial_loaded() -> bool:
	if _admob_singleton != null:
		return _is_rewarded_interstitial_loaded
	return false


func show_banner() -> void:
	if _admob_singleton != null:
		_admob_singleton.showBanner()


func hide_banner() -> void:
	if _admob_singleton != null:
		_admob_singleton.hideBanner()


func move_banner(on_top: bool) -> void:
	if _admob_singleton != null:
		banner_on_top = on_top
		_admob_singleton.move(banner_on_top)


func show_interstitial() -> void:
	if _admob_singleton != null:
		_admob_singleton.showInterstitial()
		_is_interstitial_loaded = false


func show_rewarded_video() -> void:
	if _admob_singleton != null:
		_admob_singleton.showRewardedVideo()
		_is_rewarded_video_loaded = false


func show_rewarded_interstitial() -> void:
	if _admob_singleton != null:
		_admob_singleton.showRewardedInterstitial()
		_is_rewarded_interstitial_loaded = false


func banner_resize() -> void:
	if _admob_singleton != null:
		_admob_singleton.resize()


func get_banner_dimension() -> Vector2:
	if _admob_singleton != null:
		return Vector2(_admob_singleton.getBannerWidth(), _admob_singleton.getBannerHeight())
	return Vector2()


func _on_admob_ad_loaded() -> void:
	banner_loaded.emit()


func _on_admob_banner_failed_to_load(error_code:int) -> void:
	banner_failed_to_load.emit(error_code)


func _on_interstitial_failed_to_load(error_code:int) -> void:
	_is_interstitial_loaded = false
	interstitial_failed_to_load.emit(error_code)


func _on_interstitial_opened() -> void:
	interstitial_opened.emit()


func _on_interstitial_loaded() -> void:
	_is_interstitial_loaded = true
	interstitial_loaded.emit()


func _on_interstitial_close() -> void:
	interstitial_closed.emit()


func _on_interstitial_clicked() -> void:
	interstitial_clicked.emit()


func _on_interstitial_impression() -> void:
	interstitial_impression.emit()


func _on_rewarded_video_ad_loaded() -> void:
	_is_rewarded_video_loaded = true
	rewarded_video_loaded.emit()


func _on_rewarded_video_ad_opened() -> void:
	rewarded_video_opened.emit()


func _on_rewarded_video_ad_closed() -> void:
	rewarded_video_closed.emit()


func _on_rewarded_video_ad_failed_to_load(error_code:int) -> void:
	_is_rewarded_video_loaded = false
	rewarded_video_failed_to_load.emit(error_code)


func _on_rewarded_interstitial_ad_opened() -> void:
	rewarded_interstitial_opened.emit()


func _on_rewarded_interstitial_ad_loaded() -> void:
	_is_rewarded_interstitial_loaded = true
	rewarded_interstitial_loaded.emit()


func _on_rewarded_interstitial_ad_closed() -> void:
	rewarded_interstitial_closed.emit()


func _on_rewarded_interstitial_ad_failed_to_load(error_code:int) -> void:
	_is_rewarded_interstitial_loaded = false
	rewarded_interstitial_failed_to_load.emit(error_code)


func _on_rewarded_interstitial_ad_failed_to_show(error_code:int) -> void:
	_is_rewarded_interstitial_loaded = false
	rewarded_interstitial_failed_to_show.emit(error_code)


func _on_rewarded(currency:String, amount:int) -> void:
	rewarded.emit(currency, amount)


func _on_rewarded_clicked() -> void:
	rewarded_clicked.emit()


func _on_rewarded_impression() -> void:
	rewarded_impression.emit()
