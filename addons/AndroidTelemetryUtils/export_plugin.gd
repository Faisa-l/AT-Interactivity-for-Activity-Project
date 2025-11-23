@tool
extends EditorPlugin

var android_plugin : AndroidExportPlugin

#region probably not needed
func _enable_plugin() -> void:
	# Add autoloads here.
	pass


func _disable_plugin() -> void:
	# Remove autoloads here.
	pass
#endregion

func _enter_tree() -> void:
	android_plugin = AndroidExportPlugin.new()
	add_export_plugin(android_plugin)

func _exit_tree() -> void:
	remove_export_plugin(android_plugin)
	android_plugin = null
	pass

# Class which holds the plugin
class AndroidExportPlugin extends EditorExportPlugin:
	# Name of plugin
	var _plugin_name = "AndroidTelemetryUtils"
	
	# Specified supported platforms (just android)
	func _supports_platform(platform: EditorExportPlatform) -> bool:
		if platform is EditorExportPlatformAndroid:
			return true
		return false
	
	# Returns paths to the plugin's AAR. Currently just using debug one
	func _get_android_libraries(platform: EditorExportPlatform, debug: bool) -> PackedStringArray:
		if debug:
			return PackedStringArray(["res://addons/AndroidTelemetryUtils/AndroidTelemetryUtils-debug.aar"])
		else:
			return PackedStringArray(["res://addons/AndroidTelemetryUtils/AndroidTelemetryUtils-release.aar"])
	
	# Returns the plugin name
	func _get_name() -> String:
		return _plugin_name
