class OperationTime {
  int id;
  String optDay;
  String openHr;
  String closeHr;

  OperationTime({
    required this.id,
    required this.optDay,
    required this.openHr,
    required this.closeHr,
  });

  factory OperationTime.fromJson(Map<String, dynamic> json) {
    return OperationTime(
        id: json['ID'],
        optDay: json['Opt_Day'],
        openHr: formatTime(json['Opt_OpenHR']),
        closeHr: formatTime(json['Opt_CloseHR']));
  }

  static String formatTime(String time) {
    time = time.substring(0, time.length - 3);

    if (time.substring(0, 2).endsWith(':')) {
      time = '0$time';
    }

    return time;
  }
}
