// ignore_for_file: constant_identifier_names
// const String url = 'https://rawado.reigeeky.com';

String? url = 'https://jolo.softvencealpha.com/api/';

final class NetworkConstants {
  NetworkConstants._();
  static const ACCEPT = "Accept";
  static const APP_KEY = "App-Key";
  static const ACCEPT_LANGUAGE = "Accept-Language";
  static const ACCEPT_LANGUAGE_VALUE = "pt";
  static const APP_KEY_VALUE = String.fromEnvironment("APP_KEY_VALUE");
  static const ACCEPT_TYPE = "application/json";
  static const AUTHORIZATION = "Authorization";
  static const CONTENT_TYPE = "content-Type";
}

final class Endpoints {
  Endpoints._();
  //backend_url
  // App Url

  static String logIn() => "login/";
  static String patientUpdate(int id) => "/patient-information/$id";
  static String signUp() => "signup/";
  static String forgotPassword() => "forgot-password/request/";
  static String verifyOtp() => "forgot-password/verify/";
  static String resetPassword() => "forgot-password/reset/";
  static String logout() => "logout/";
  static String changePassword() => "change-password/";
  static String stories() => "stories/";
  static String createStories() => "stories/";
  static String profile() => "profile";
  static String putProfile() => "profile/";
  static String feed() => "feed/";
  static String storyDelete(int id) => "story/$id/delete/";
  static String feedLike(int id) => "feed/$id/like/";
  static String follow(int id) => "follow/$id/";
  static String listComments({required int id}) => "feed/$id/comments/";
  static String addComments({required int id}) => "feed/$id/comments/";
  static String editComments({required int id}) => "comments/$id/";
  static String deleteComments({required int id}) => "comments/$id/";
  static String postFeed() => "feed/";
  static String editFeed({required int id}) => "feed/$id/";
  static String myTopFans() => "my-creators/";
  static String topFan({required int id}) => "top-fan/$id/";
  static String deleteFeed({required int id}) => "feed/$id/";
  static String packs() => "packs/";
  static String vault() => "vault/";
  static String checkoutCreate() => "checkout/create/";
  static String payoutAccounts() => "payout-accounts/";
  static String monetizationApply() => "monetization/apply/";
  static String notification() => "notifications/";
  static String creatorsOnline() => "creators/online/";
  static String onlineCreators() => "online-creators/";
  static String onlineUsers() => "online-users/";
  static String chats() => "chats/";
  static String chatSessions({required String id}) =>
      "chat-sessions/$id/all-messages/";
  static String tip({required int id}) => "tip/$id/";
  static String chatStart({required int id}) => "chats/start/$id/";
  static String creatorChatMessage({required String id}) =>
      "chats/$id/messages/";
  static String unlock({required int id}) => "feed/$id/unlock/";
  static String reactMessage({required String id}) => "messages/$id/reaction/";
  static String chatSearch({required String query}) =>
      "chats/search/?query=$query";
  static String creatorPayoutRequest() => "creator/payout/request/";
  static String deleteAccount() => "delete-account/";
  static String storyReact({required int id}) => "stories/$id/react/";
  static String storyReply({required int id}) => "stories/$id/reply/";

  static String topFanCreator({required int id}) => "top-fans/$id/";
  static String profileDetails({required int id}) => "profile/$id/";
  static String turnOffComment({required int id}) =>
      "feed/$id/toggle-comments/";
  static String feedMute({required int id}) => "feed/$id/mute/";
  static String feedReport({required int id}) => "feed/$id/report/";
  static String authorBlock({required int id}) => "author/$id/block/";
  static String blockUser() => "blocked-users/";
  static String suggestFriend() => "suggested-friends/";

  // Customer API Url
}
