String replaceToFarsiNumber(String input) {
  const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
  const farsi = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];

  for (int i = 0; i < english.length; i++) {
    input = input.replaceAll(english[i], farsi[i]);
  }
  return input;
}

String passedTimeLabel(DateTime dateTime) {
  final diff = dateTime.toUtc().difference(DateTime.now().toUtc()).abs();
  final diffInHours = diff.inHours;
  final diffInMinutes = diff.inMinutes;
  if (diffInHours == 0 && diffInMinutes > 0) {
    return '$diffInMinutes دقیقه پیش';
  }
  if (diffInHours < 24 && diffInHours > 0) {
    return '$diffInHours ساعت پیش';
  }
  if (diffInHours >= 24 && diffInHours < 48) {
    return 'یک روز پیش';
  }
  if (diffInHours >= 48) {
    int diffInDays = diff.inDays;
    if (diffInDays >= 30) {
      final diffInMonths = diffInDays ~/ 30;
      return '$diffInMonths ماه پیش';
    }
    return '$diffInDays روز پیش';
  }
  return 'اندکی پیش';
}
