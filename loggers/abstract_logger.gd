@abstract class_name DLog_AbstractLogger
extends Resource

signal logged(level: int, message: String, context: Dictionary[String, Variant])
signal debug_logged(message: String, context: Dictionary[String, Variant])

const Global = preload("../global.gd")
const Level = Global.Level
const LogRecord = Global.LogRecord

@export var _channel: StringName
@export var _handlers: Array[DLog_AbstractHandler]
@export var _processors: Array[DLog_AbstractProcessor]


func debug(message: String, context: Dictionary[String, Variant] = {}) -> void:
	_log(Level.DEBUG, message, context)
	debug_logged.emit(message, context)


func info(message: String, context: Dictionary[String, Variant] = {}) -> void:
	_log(Level.INFO, message, context)


func notice(message: String, context: Dictionary[String, Variant] = {}) -> void:
	_log(Level.NOTICE, message, context)


func warning(message: String, context: Dictionary[String, Variant] = {}) -> void:
	_log(Level.WARNING, message, context)


func error(message: String, context: Dictionary[String, Variant] = {}) -> void:
	_log(Level.ERROR, message, context)


func critical(message: String, context: Dictionary[String, Variant] = {}) -> void:
	_log(Level.CRITICAL, message, context)


func alert(message: String, context: Dictionary[String, Variant] = {}) -> void:
	_log(Level.ALERT, message, context)


func emergency(message: String, context: Dictionary[String, Variant] = {}) -> void:
	_log(Level.EMERGENCY, message, context)


func add_handler(handler: DLog_AbstractHandler) -> void:
	_handlers.push_front(handler)


func add_processor(processor: DLog_AbstractProcessor) -> void:
	_processors.push_front(processor)


func _log(level: int, message: String, context: Dictionary[String, Variant] = {}) -> void:
	var record: LogRecord = LogRecord.new()
	record.level = level
	record.channel = _channel
	record.datetime = Time.get_datetime_string_from_system()
	record.context = context
	record.message = message
	record.formatted = ""

	for processor in _processors:
		record = processor.process(record)

	for handler in _handlers:
		handler.handle(record)

	logged.emit(level, message, context)
