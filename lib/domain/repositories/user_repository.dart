abstract class UserRepository {
 Future<void> setUserLanguage(String lang);
 Future<String?> getUserLanguage();
}
