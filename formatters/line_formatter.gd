class_name DLog_LineFormatter
extends DLog_AbstractFormatter

@export var _template: String = "[{time}:{channel}] {level}: {message}"


func format(record: LogRecord) -> String:
	var format: Dictionary = {
		"time": record.datetime,
		"channel": record.channel,
		"level": record.level,
		"message": record.message.format(record.context)
	}
	var message := _template.format(format)
	return message
