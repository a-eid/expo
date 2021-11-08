// Copyright 2021-present 650 Industries. All rights reserved.

public struct Logger {
  static var level: LogType = .trace

  public static func log(type: LogType = .trace, message: String, file: String = #fileID, line: UInt = #line) {
    if type.rawValue >= level.rawValue {
      let filename = file.replacingOccurrences(of: ".swift", with: "")
      print("\(type.icon)《\(filename):\(line)》\(message)")
    }
  }

  public static func trace(_ message: String, file: String = #fileID, line: UInt = #line) {
    log(type: .trace, message: message, file: file, line: line)
  }

  public static func debug(_ message: String, file: String = #fileID, line: UInt = #line) {
    log(type: .debug, message: message, file: file, line: line)
  }

  public static func info(_ message: String, file: String = #fileID, line: UInt = #line) {
    log(type: .info, message: message, file: file, line: line)
  }

  public static func notice(_ message: String, file: String = #fileID, line: UInt = #line) {
    log(type: .notice, message: message, file: file, line: line)
  }

  public static func warn(_ message: String, file: String = #fileID, line: UInt = #line) {
    log(type: .warn, message: message, file: file, line: line)
  }

  public static func error(_ message: String, file: String = #fileID, line: UInt = #line) {
    log(type: .error, message: message, file: file, line: line)
  }

  public static func fatal(_ message: String, file: String = #fileID, line: UInt = #line) {
    log(type: .fatal, message: message, file: file, line: line)
  }

  public static func stacktrace() {
    Thread.callStackSymbols.forEach { print($0) }
  }

  public enum LogType: Int {
    case trace = 0
    case debug = 1
    case info = 2
    case notice = 3
    case warn = 4
    case error = 5
    case fatal = 6
    case off = 7

    var icon: String {
      switch self {
      case .trace:
        return "⚪️"
      case .debug:
        return "🟣"
      case .info:
        return "🔵"
      case .notice:
        return "🟢"
      case .warn:
        return "🟡"
      case .error:
        return "🟠"
      case .fatal:
        return "🔴"
      case .off:
        return "⚫️"
      }
    }
  }
}
