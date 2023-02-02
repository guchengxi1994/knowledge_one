extension ToString on DateTime {
  String toChinese() {
    return "$year年$month月$day日 $hour:$minute:$second";
  }

  String toEnglish() {
    return "$year/$month/$day $hour:$minute:$second";
  }
}
