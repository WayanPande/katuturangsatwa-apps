enum APP_PAGE {
  splash,
  login,
  home,
  error,
  onBoarding,
  register,
  discover,
  profile,
  storyDetail,
  reader,
  write,
  storyInput,
  categoriesDetail
}

extension AppPageExtension on APP_PAGE {
  String get toPath {
    switch (this) {
      case APP_PAGE.home:
        return "/home";
      case APP_PAGE.login:
        return "/login";
      case APP_PAGE.splash:
        return "/splash";
      case APP_PAGE.error:
        return "/error";
      case APP_PAGE.onBoarding:
        return "/start";
      case APP_PAGE.register:
        return "/register";
      case APP_PAGE.discover:
        return "/discover";
      case APP_PAGE.profile:
        return "/profile";
      case APP_PAGE.storyDetail:
        return "/storyDetail";
      case APP_PAGE.reader:
        return "/reader";
      case APP_PAGE.write:
        return "/write";
      case APP_PAGE.storyInput:
        return "/story-input";
      case APP_PAGE.categoriesDetail:
        return "/categories-detail";
      default:
        return "/";
    }
  }

  String get toName {
    switch (this) {
      case APP_PAGE.home:
        return "HOME";
      case APP_PAGE.login:
        return "LOGIN";
      case APP_PAGE.splash:
        return "SPLASH";
      case APP_PAGE.error:
        return "ERROR";
      case APP_PAGE.onBoarding:
        return "START";
      case APP_PAGE.register:
        return "REGISTER";
      case APP_PAGE.discover:
        return "DISCOVER";
      case APP_PAGE.profile:
        return "PROFILE";
      case APP_PAGE.storyDetail:
        return "STORYDETAIL";
      case APP_PAGE.reader:
        return "READER";
      case APP_PAGE.write:
        return "WRITE";
      case APP_PAGE.storyInput:
        return "STORYINPUT";
      case APP_PAGE.categoriesDetail:
        return "CATEGORIESDETAIL";
      default:
        return "";
    }
  }

  String get toTitle {
    switch (this) {
      case APP_PAGE.home:
        return "My App";
      case APP_PAGE.login:
        return "My App Log In";
      case APP_PAGE.splash:
        return "My App Splash";
      case APP_PAGE.error:
        return "My App Error";
      case APP_PAGE.onBoarding:
        return "Welcome to My App";
      default:
        return "My App";
    }
  }
}
