import 'package:logger/logger.dart';

class MyLogger {
  static final MyLogger singleton = MyLogger._internal();
  MyLogger._internal ();

  static final Logger _logger=Logger(
    printer: PrettyPrinter(
      methodCount: 2, // number of method calls to be displayed
      errorMethodCount: 8, // number of method calls if stacktrace is provided
      lineLength: 120, // width of the output
      colors: true, // Colorful log messages
      printEmojis: true, // Print an emoji for each log message
      printTime: false // Should each log print contain a timestamp
    )
  );

  void logD(String message){
    _logger.d(message);
  }
  void logI(String message){
    _logger.i(message);
  }

  Logger logger(){
    return _logger;
  }

}