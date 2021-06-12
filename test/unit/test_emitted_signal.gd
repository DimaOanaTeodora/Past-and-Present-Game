extends "res://addons/gut/test.gd"

var signalWatcher = load('res://addons/gut/signal_watcher.gd').new()
class SignalObject:
	extends Node2D
	func _init():
		add_user_signal('no_parameters')
		
var signalObject = SignalObject.new()
func test_emitted_signal():
	signalWatcher.watch_signal(signalObject, 'no_parameters')
	signalObject.emit_signal('no_parameters')
	assert_eq(signalWatcher.get_emit_count(signalObject, 'no_parameters'), 1, 'The signal should have been counted.')

