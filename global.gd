@abstract class_name DLog
extends Object
## Dlog (short from DinoLog or DinoLogger)

## Logging levels described by RFC 5424. (taken from php Monolog)
enum Level {
	DEBUG = 100,  ## Detailed debug information.
	INFO = 200,  ## Interesting events. Examples: User logs in, SQL logs.
	NOTICE = 250,  ## Normal but significant events.
	WARNING = 300,  ## Exceptional occurrences that are not errors. Examples: Use of deprecated APIs, poor use of an API, undesirable things that are not necessarily wrong.
	ERROR = 400,  ## Runtime errors that do not require immediate action but should typically be logged and monitored.
	CRITICAL = 500,  ## Critical conditions. Example: Application component unavailable, unexpected exception.
	ALERT = 550,  ## Action must be taken immediately. Example: Entire website down, database unavailable, etc. This should trigger the SMS alerts and wake you up.
	EMERGENCY = 600,  ## Emergency: system is unusable.
}

static var AbstractLogger := DLog_AbstractLogger
static var BasicLogger := DLog_BasicLogger
static var NullLogger := DLog_NullLogger

static var AbstractHandler := DLog_AbstractHandler
static var FileHandler := DLog_FileHandler

static var AbstractFormatter := DLog_AbstractFormatter

static var AbstractProcessor := DLog_AbstractProcessor


func _init() -> void:
	push_error("Not allowed to be instantiated")


class LogRecord:
	extends RefCounted
	var datetime: String
	var channel: String
	var level: int = Level.DEBUG
	var message: String = ""
	var context: Dictionary[String, Variant]
	var extra: Dictionary[String, Variant]
	var formatted: String
