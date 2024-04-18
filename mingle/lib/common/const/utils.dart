int convertDayToInt(String day) {
  switch (day) {
    case "MONDAY":
      return 0;
    case "TUESDAY":
      return 1;
    case "WEDNESDAY":
      return 2;
    case "THURSDAY":
      return 3;
    case "FRIDAY":
      return 4;
    case "SATURDAY":
      return 5;
    case "SUNDAY":
      return 6;
    default:
      return 0;
  }
}

String convertDayToKorDay(String day) {
  switch (day) {
    case "MONDAY":
      return "월";
    case "TUESDAY":
      return "화";
    case "WEDNESDAY":
      return "수";
    case "THURSDAY":
      return "목";
    case "FRIDAY":
      return "금";
    case "SATURDAY":
      return "토";
    case "SUNDAY":
      return "일";
    default:
      return "월";
  }
}

String convertKorDayToEngDay(String day) {
  switch (day) {
    case "월요일":
      return "MONDAY";
    case "화요일":
      return "TUESDAY";
    case "수요일":
      return "WEDNESDAY";
    case "목요일":
      return "THURSDAY";
    case "금요일":
      return "FRIDAY";
    case "토요일":
      return "SATURDAY";
    case "일요일":
      return "SUNDAY";
    default:
      return "MONDAY";
  }
}
