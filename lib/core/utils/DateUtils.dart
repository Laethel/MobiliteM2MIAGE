class DateUtils {

  static String dateToString(DateTime date) {

    return date.day.toString() + " " + DateUtils.getLabelOfMonth(date.month) + " " + date.year.toString();
  }

  static String getLabelOfMonth(int index) {

    switch(index) {
      case 1:
        return "Janvier";
        break;
      case 2:
        return "Février";
        break;
      case 3:
        return "Mars";
        break;
      case 4:
        return "Avril";
        break;
      case 5:
        return "Mai";
        break;
      case 6:
        return "Juin";
        break;
      case 7:
        return "Juillet";
        break;
      case 8:
        return "Août";
        break;
      case 9:
        return "Septembre";
        break;
      case 10:
        return "Octobre";
        break;
      case 11:
        return "Novembre";
        break;
      case 12:
        return "Décembre";
        break;
    }
  }
}