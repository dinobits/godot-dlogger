@abstract class_name DLog_AbstractHandler
extends Resource

const DinoLog = preload("../global.gd")
const LogRecord = DinoLog.LogRecord

@export var _level: int = DinoLog.Level.DEBUG
@export var _formatter: DLog_AbstractFormatter = DLog_LineFormatter.new()

@export var _processors: Array[DLog_AbstractProcessor]


func set_level(level: int) -> void:
	_level = level


func get_level() -> int:
	return _level


func set_formatter(formatter: DLog_AbstractFormatter) -> void:
	if not formatter:
		push_error("Formatter cannot be null")
		return
	_formatter = formatter


func get_formatter() -> DLog_AbstractFormatter:
	return _formatter


func push_processor(processor: DLog_AbstractProcessor) -> void:
	_processors.push_front(processor)


func pop_processor() -> DLog_AbstractProcessor:
	return _processors.pop_front()


func can_handle(record: LogRecord) -> bool:
	if _level > record.level:
		return false
	return true


func handle_batch(records: Array[LogRecord]) -> void:
	for record in records:
		handle(record)


func handle(record: LogRecord) -> bool:
	if not can_handle(record):
		return false

	for processor in _processors:
		record = processor.process(record)

	record.formatted = _formatter.format(record)

	return true
