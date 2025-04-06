class UrlManager {
  // Base URLs
  static const String baseUrl =
      'YOUR_IP_HERE'; // Replace with your actual base URL

  // Authentication endpoints
  static const String login = '$baseUrl/api/login';
  static const String logout = '$baseUrl/api/logout';
  static const String register = '$baseUrl/api/register';
  static const String verify = '$baseUrl/api/verify';
  static const String resend = '$baseUrl/api/resend';
  static const String refreshToken = '$baseUrl/api/refresh-token';

  // parent/reminder/departmnt
  static const String getParentReminder = 'api/child/childId/reminders';
  static const String createParentReminder = 'api/reminders';

  // parent/child/departmnt
  static const String getChildren = 'api/children';
  static const String createChild = 'api/children';

  // Location/departmnt
  static const String getLocation = 'api/locations';

  // child/prayerTimes/departmnt
  static const String getReminder = 'api/reminders/reminderId';
  static const String sendInfoChild = 'api/attendances';
  static const String getPrayersName = 'api/prayers';
  static const String getPrayerTimes = 'api/prayer-times';

  // child/Eductional_Section/departmnt
  static const String getStoryFromId = 'api/educational_sections/storyId';
  static const String getSectionImage = 'api/educational_sections';
}
