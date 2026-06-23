// import 'package:get_storage/get_storage.dart';
// import 'package:jolo1981_app/features/creator_part/creator_vault_page/presentation/requast_payout_rx/data/post_request_payout_rx.dart';
// import 'package:jolo1981_app/features/creator_part/creator_vault_page/presentation/requast_payout_rx/model/post_request_payout_model.dart';
// import 'package:jolo1981_app/features/creator_part/indentity_info_flow/identity_information/presentation/data/post_monitization_rx.dart';
// import 'package:jolo1981_app/features/creator_part/indentity_info_flow/identity_information/presentation/model/monitization_model.dart';
// import 'package:jolo1981_app/features/creator_part/indentity_info_flow/payout_page1/presentation/data/post_payout_rx.dart';
// import 'package:jolo1981_app/features/creator_part/indentity_info_flow/payout_page1/presentation/model/payout_model.dart';
// import 'package:jolo1981_app/features/creator_part/messaging_flow/message/presentation/wispers_rx/data/get_wispers_rx.dart';
// import 'package:jolo1981_app/features/creator_part/messaging_flow/message/presentation/wispers_rx/model/get_wispers_model.dart';
// import 'package:jolo1981_app/features/creator_part/profile_flow/widgets/data/get_top_fan_creator_rx.dart';
// import 'package:jolo1981_app/features/creator_part/profile_flow/widgets/model/get_top_fan_creator_model.dart';
// import 'package:jolo1981_app/features/user_part/auth/create_new_password/presentation/data/reset_password_rx.dart';
// import 'package:jolo1981_app/features/user_part/auth/forget_password/presentation/data/fotget_password_rx.dart';
// import 'package:jolo1981_app/features/user_part/auth/otp_verify/presentation/data/otp_verify_rx.dart';
// import 'package:jolo1981_app/features/user_part/auth/sign_in/presentation/data/post_singnin_rx.dart';
// import 'package:jolo1981_app/features/user_part/auth/sign_in/presentation/model/sign_in_model.dart';
// import 'package:jolo1981_app/features/user_part/auth/sign_up/presentation/data/post_signup_rx.dart';
// import 'package:jolo1981_app/features/user_part/home_flow/home/presentation/del_story_rx/data/del_story_rx.dart';
// import 'package:jolo1981_app/features/user_part/home_flow/home/presentation/del_story_rx/model/delete_story_model.dart';
// import 'package:jolo1981_app/features/user_part/home_flow/home/presentation/lock_unlock_rx/data/post_unlocked_rx.dart';
// import 'package:jolo1981_app/features/user_part/home_flow/home/presentation/lock_unlock_rx/model/post_unlocked_model.dart';
// import 'package:jolo1981_app/features/user_part/home_flow/home/presentation/post_story_rx/data/post_story_rx.dart';
// import 'package:jolo1981_app/features/user_part/home_flow/home/presentation/post_story_rx/model/post_story_model.dart';
// import 'package:jolo1981_app/features/user_part/home_flow/home/presentation/profile_details_rx/data/get_profile_details_rx.dart';
// import 'package:jolo1981_app/features/user_part/home_flow/home/presentation/profile_details_rx/model/get_profile_details_model.dart';
// import 'package:jolo1981_app/features/user_part/home_flow/home/presentation/stories_rx/data/get_stories_rx.dart';
// import 'package:jolo1981_app/features/user_part/home_flow/home/presentation/stories_rx/model/get_story_model.dart';
// import 'package:jolo1981_app/features/user_part/home_flow/home/presentation/user_post/presentation/data/post_feed_rx.dart';
// import 'package:jolo1981_app/features/user_part/home_flow/home/presentation/user_post/presentation/edit_feed_rx/data/put_feed_rx.dart';
// import 'package:jolo1981_app/features/user_part/home_flow/home/presentation/user_post/presentation/edit_feed_rx/model/put_feed_model.dart';
// import 'package:jolo1981_app/features/user_part/home_flow/home/presentation/user_post/presentation/model/post_feed_model.dart';
// import 'package:jolo1981_app/features/user_part/home_flow/home/presentation/user_post/report_rx/data/post_report_rx.dart';
// import 'package:jolo1981_app/features/user_part/home_flow/home/presentation/user_post/report_rx/model/post_report_model.dart';
// import 'package:jolo1981_app/features/user_part/home_flow/home/presentation/user_video_page/presentation/delete_feed_rx/data/delete_feed_rx.dart';
// import 'package:jolo1981_app/features/user_part/home_flow/home/presentation/user_video_page/presentation/delete_feed_rx/model/delete_feed_model.dart';
// import 'package:jolo1981_app/features/user_part/home_flow/home/presentation/user_video_page/presentation/follow_rx/data/post_follow_rx.dart';
// import 'package:jolo1981_app/features/user_part/home_flow/home/presentation/user_video_page/presentation/follow_rx/model/follow_model.dart';
// import 'package:jolo1981_app/features/user_part/home_flow/home/presentation/user_video_page/presentation/tip_rx/data/post_tip_rx.dart';
// import 'package:jolo1981_app/features/user_part/home_flow/home/presentation/user_video_page/presentation/tip_rx/model/post_tip_model.dart';
// import 'package:jolo1981_app/features/user_part/home_flow/home/presentation/user_video_page/presentation/user_block_rx/data/post_block_rx.dart';
// import 'package:jolo1981_app/features/user_part/home_flow/home/presentation/user_video_page/presentation/user_block_rx/model/post_block_model.dart';
// import 'package:jolo1981_app/features/user_part/home_flow/home/presentation/user_video_page/turn_off_comment_rx/data/post_turn_off_rx.dart';
// import 'package:jolo1981_app/features/user_part/home_flow/home/presentation/user_video_page/turn_off_comment_rx/model/post_turn_off_comment_model.dart';
// import 'package:jolo1981_app/features/user_part/home_flow/home/suggested_friend_rx/data/get_suggested_rx.dart';
// import 'package:jolo1981_app/features/user_part/home_flow/home/suggested_friend_rx/model/get_suggested_model.dart';
// import 'package:jolo1981_app/features/user_part/home_flow/post_mute_rx/data/post_mute_rx.dart';
// import 'package:jolo1981_app/features/user_part/home_flow/post_mute_rx/model/post_mute_model.dart';
// import 'package:jolo1981_app/features/user_part/home_flow/video_comment/presentation/add_commentrx/data/post_comment_rx.dart';
// import 'package:jolo1981_app/features/user_part/home_flow/video_comment/presentation/add_commentrx/model/post_comment_model.dart';
// import 'package:jolo1981_app/features/user_part/home_flow/video_comment/presentation/data/get_comment_rx.dart';
// import 'package:jolo1981_app/features/user_part/home_flow/video_comment/presentation/delete_comment_rx/data/delete_comment_rx.dart';
// import 'package:jolo1981_app/features/user_part/home_flow/video_comment/presentation/delete_comment_rx/model/delete_comment_model.dart';
// import 'package:jolo1981_app/features/user_part/home_flow/video_comment/presentation/edit_comment_rx/data/put_edit_comment_rx.dart';
// import 'package:jolo1981_app/features/user_part/home_flow/video_comment/presentation/edit_comment_rx/model/edit_comment_model.dart';
// import 'package:jolo1981_app/features/user_part/home_flow/video_comment/presentation/model/get_comment_model.dart';
// import 'package:jolo1981_app/features/user_part/messaging_flow/chat/chat_rx/data/get_all_chat_rx.dart';
// import 'package:jolo1981_app/features/user_part/messaging_flow/chat/chat_rx/model/get_all_message_model.dart';
// import 'package:jolo1981_app/features/user_part/messaging_flow/chat/chat_search_rx/data/get_search_rx.dart';
// import 'package:jolo1981_app/features/user_part/messaging_flow/chat/chat_search_rx/model/get_search_model.dart';
// import 'package:jolo1981_app/features/user_part/messaging_flow/chat/creator_chat_message_rx/data/creator_chat_message_rx.dart';
// import 'package:jolo1981_app/features/user_part/messaging_flow/chat/creator_chat_message_rx/model/creator_chat_message_model.dart';
// import 'package:jolo1981_app/features/user_part/messaging_flow/message/presentation/creator_message_rx/data/get_chat_rx.dart';
// import 'package:jolo1981_app/features/user_part/messaging_flow/message/presentation/creator_message_rx/model/get_chat_model.dart';
// import 'package:jolo1981_app/features/user_part/messaging_flow/message/presentation/post_live_whyspers_rx/data/post_live_whyspers_rx.dart';
// import 'package:jolo1981_app/features/user_part/messaging_flow/message/presentation/post_live_whyspers_rx/model/post_live_whyspers_model.dart';
// import 'package:jolo1981_app/features/user_part/messaging_flow/message/presentation/wisper_rx/data/get_creators_rx.dart';
// import 'package:jolo1981_app/features/user_part/messaging_flow/message/presentation/wisper_rx/model/get_online_creators_model.dart';
// import 'package:jolo1981_app/features/user_part/messaging_flow/react_rx/data/post_react_rx.dart';
// import 'package:jolo1981_app/features/user_part/messaging_flow/react_rx/model/post_react_model.dart';
// import 'package:jolo1981_app/features/user_part/messaging_flow/story_view/presentation/story_react_rx/data/post_story_react_rx.dart';
// import 'package:jolo1981_app/features/user_part/messaging_flow/story_view/presentation/story_react_rx/model/post_story_react_model.dart';
// import 'package:jolo1981_app/features/user_part/messaging_flow/story_view/presentation/story_reply_rx/data/post_story_reply_rx.dart';
// import 'package:jolo1981_app/features/user_part/messaging_flow/story_view/presentation/story_reply_rx/model/post_story_reply_model.dart';
// import 'package:jolo1981_app/features/user_part/notification/presentation/data/get_notification_rx.dart';
// import 'package:jolo1981_app/features/user_part/notification/presentation/model/get_notification_model.dart';
// import 'package:jolo1981_app/features/user_part/profile_flow/edit_profile/presentation/data/get_profile_rx.dart';
// import 'package:jolo1981_app/features/user_part/profile_flow/edit_profile/presentation/data/put_profile_rx.dart';
// import 'package:jolo1981_app/features/user_part/profile_flow/edit_profile/presentation/model/get_profile_model.dart';
// import 'package:jolo1981_app/features/user_part/profile_flow/edit_profile/presentation/model/put_profile_model.dart';
// import 'package:jolo1981_app/features/user_part/profile_flow/user_profile_gallery/presentation/get_feed_rx/data/get_feed_rx.dart';
// import 'package:jolo1981_app/features/user_part/profile_flow/user_profile_gallery/presentation/get_feed_rx/model/get_feed_model.dart';
// import 'package:jolo1981_app/features/user_part/profile_flow/user_profile_gallery/presentation/like_rx/data/post_like_rx.dart';
// import 'package:jolo1981_app/features/user_part/profile_flow/user_profile_gallery/presentation/like_rx/model/post_like_model.dart';
// import 'package:jolo1981_app/features/user_part/profile_flow/user_profile_gallery/presentation/my_creators_rx/data/get_creator_rx.dart';
// import 'package:jolo1981_app/features/user_part/profile_flow/user_profile_gallery/presentation/my_creators_rx/model/get_creator_model.dart';
// import 'package:jolo1981_app/features/user_part/profile_flow/user_profile_gallery/presentation/user_profile_top_fan/presentation/data/get_top_fan_rx.dart';
// import 'package:jolo1981_app/features/user_part/profile_flow/user_profile_gallery/presentation/user_profile_top_fan/presentation/model/get_top_fan_model.dart';
// import 'package:jolo1981_app/features/user_part/setting_page_flow/presentation/block_users/presentation/data/get_user_block_rx.dart';
// import 'package:jolo1981_app/features/user_part/setting_page_flow/presentation/block_users/presentation/model/get_user_block_model.dart';
// import 'package:jolo1981_app/features/user_part/setting_page_flow/presentation/delete_account_rx/data/delete_account_rx.dart';
// import 'package:jolo1981_app/features/user_part/setting_page_flow/presentation/delete_account_rx/model/delete_account_model.dart';
// import 'package:jolo1981_app/features/user_part/setting_page_flow/presentation/logout_rx/data/post_logout_rx.dart';
// import 'package:jolo1981_app/features/user_part/setting_page_flow/presentation/setting_change_password/presentation/data/post_change_password_rx.dart';
// import 'package:jolo1981_app/features/user_part/vault_flow/payment_page/presentation/data/post_payment_rx.dart';
// import 'package:jolo1981_app/features/user_part/vault_flow/payment_page/presentation/model/payment_model.dart';
// import 'package:jolo1981_app/features/user_part/vault_flow/valut/presentation/data/get_vault_rx.dart';
// import 'package:jolo1981_app/features/user_part/vault_flow/valut/presentation/model/get_vault_model.dart';
// import 'package:jolo1981_app/features/user_part/vault_flow/valut_package/presentation/data/get_pack_rx.dart';
// import 'package:jolo1981_app/features/user_part/vault_flow/valut_package/presentation/model/get_pack_model.dart';
// import 'package:rxdart/rxdart.dart';
// final appData = GetStorage();

// PostSigninRx postSigninRx = PostSigninRx(
//   empty: SignInModel(),
//   dataFetcher:
//       BehaviorSubject<SignInModel>(),
// );
// PostSignupRx postSignupRx = PostSignupRx(
//   empty: <String, dynamic>{},
//   dataFetcher:
//       BehaviorSubject<Map<String, dynamic>>(),
// );
// ForgetPasswordRx forgetPasswordRx = ForgetPasswordRx(
//   empty: <String, dynamic>{},
//   dataFetcher:BehaviorSubject<Map<String, dynamic>>(),
// );
// VerifyOtpRx verifyOtpRx = VerifyOtpRx(
//   empty: <String, dynamic>{},
//   dataFetcher:BehaviorSubject<Map<String, dynamic>>(),
// );
// ResetPasswordRx resetPasswordRx = ResetPasswordRx(
//   empty: <String, dynamic>{},
//   dataFetcher:BehaviorSubject<Map<String, dynamic>>(),
// );
// PostLogoutRx postLogoutRx = PostLogoutRx(
//   empty: <String, dynamic>{},
//   dataFetcher:BehaviorSubject<Map<String, dynamic>>(),
// );
// PostChangePasswordRx postChangePasswordRx = PostChangePasswordRx(
//   empty: <String, dynamic>{},
//   dataFetcher:BehaviorSubject<Map<String, dynamic>>(),
// );
// GetStoriesRx getStoriesRx = GetStoriesRx(
//   empty: GetStoryModel(),
//   dataFetcher: BehaviorSubject<GetStoryModel>(),
// );
// PostStoryRx postStoryRx = PostStoryRx(
//   empty: PostStoryModel(),
//   dataFetcher: BehaviorSubject<PostStoryModel>(),
// );
// GetProfileRx getProfileRx = GetProfileRx(
//   empty: GetProfileModel(),
//   dataFetcher: BehaviorSubject<GetProfileModel>(),
// );
// PutProfileRx putProfileRx = PutProfileRx(
//   empty: PutProfileModel(),
//   dataFetcher: BehaviorSubject<PutProfileModel>(),
// );
// GetFeedRx getFeedRx = GetFeedRx(
//   empty: GetFeedModel(),
//   dataFetcher: BehaviorSubject<GetFeedModel>(),
// );
// DelStoryRx delStoryRx = DelStoryRx(
//   empty: DeleteStoryModel(),
//   dataFetcher: BehaviorSubject<DeleteStoryModel>(),
// );
// PostLikeRx postLikeRx = PostLikeRx(
//   empty: PostLikeModel(),
//   dataFetcher: BehaviorSubject<PostLikeModel>(),
// );
// PostFollowRx postFollowRx = PostFollowRx(
//   empty: FollowModel(),
//   dataFetcher: BehaviorSubject<FollowModel>(),
// );
// GetCommentRx getCommentRx = GetCommentRx(
//   empty: GetCommentModel(),
//   dataFetcher: BehaviorSubject<GetCommentModel>(),
// );
// PostCommentRx postCommentRx = PostCommentRx(
//   empty: PostCommentModel(),
//   dataFetcher: BehaviorSubject<PostCommentModel>(),
// );
// PutEditCommentRx putEditCommentRx = PutEditCommentRx(
//   empty: EditCommentModel(),
//   dataFetcher: BehaviorSubject<EditCommentModel>(),
// );
// DeleteCommentRx deleteCommentRx = DeleteCommentRx(
//   empty: DeteteCommentModel(),
//   dataFetcher: BehaviorSubject<DeteteCommentModel>(),
// );
// PostFeedRx postFeedRx = PostFeedRx(
//   empty: PostFeedModel(),
//   dataFetcher: BehaviorSubject<PostFeedModel>(),
// );
// PutFeedRx putFeedRx = PutFeedRx(
//   empty: PutFeedModel(),
//   dataFetcher: BehaviorSubject<PutFeedModel>(),
// );
// GetCreatorRx getCreatorRx = GetCreatorRx(
//   empty: GetCreatorsModel(),
//   dataFetcher: BehaviorSubject<GetCreatorsModel>(),
// );
// DeleteFeedRx deleteFeedRx = DeleteFeedRx(
//   empty: DeleteFeedModel(),
//   dataFetcher: BehaviorSubject<DeleteFeedModel>(),
// );
// GetPackRx getPackRx = GetPackRx(
//   empty: GetPackModel(),
//   dataFetcher: BehaviorSubject<GetPackModel>(),
// );
// GetVaultRx getVaultRx = GetVaultRx(
//   empty: GetVaulModel(),
//   dataFetcher: BehaviorSubject<GetVaulModel>(),
// );
// PostPaymentRx postPaymentRx = PostPaymentRx(
//   empty: PaymentModel(),
//   dataFetcher: BehaviorSubject<PaymentModel>(),
// );
// PostPayoutRx postPayoutRx = PostPayoutRx(
//   empty: payoutModel(),
//   dataFetcher: BehaviorSubject<payoutModel>(),
// );
// PostMonitizationRx postMonitizationRx = PostMonitizationRx(
//   empty: MonitizationModel(),
//   dataFetcher: BehaviorSubject<MonitizationModel>(),
// );
// GetTopFanRx getTopFanRx = GetTopFanRx(
//   empty: GetTopFanModel(),
//   dataFetcher: BehaviorSubject<GetTopFanModel>(),
// );
// GetNotificationRx getNotificationRx = GetNotificationRx(
//   empty: GetNotificationModel(),
//   dataFetcher: BehaviorSubject<GetNotificationModel>(),
// );
// GetCreatorsRx getCreatorsRx = GetCreatorsRx(
//   empty: GetOnlineCreatorsModel(),
//   dataFetcher: BehaviorSubject<GetOnlineCreatorsModel>(),
// );
// GetChatRx getChatRx = GetChatRx(
//   empty: GetChatModel(),
//   dataFetcher: BehaviorSubject<GetChatModel>(),
// );
// GetAllChatRx getAllChatRx = GetAllChatRx(
//   empty: GetAllMessageModel(),
//   dataFetcher: BehaviorSubject<GetAllMessageModel>(),
// );
// PostTipRx postTipRx = PostTipRx(
//   empty: PostTipModel(),
//   dataFetcher: BehaviorSubject<PostTipModel>(),
// );
// PostLiveWhyspersRx postLiveWhyspersRx = PostLiveWhyspersRx(
//   empty: PostLiveWhyspersModel(),
//   dataFetcher: BehaviorSubject<PostLiveWhyspersModel>(),
// );
// CreatorChatMessageRx creatorChatMessageRx = CreatorChatMessageRx(
//   empty: CreatorChatMessageModel(),
//   dataFetcher: BehaviorSubject<CreatorChatMessageModel>(),
// );
// PostUnlockedRx postUnlockedRx = PostUnlockedRx(
//   empty: PostUnlockedModel(),
//   dataFetcher: BehaviorSubject<PostUnlockedModel>(),
// );
// PostReactRx postReactRx = PostReactRx(
//   empty: PostReactModel(),
//   dataFetcher: BehaviorSubject<PostReactModel>(),
// );
// GetSearchRx getSearchRx = GetSearchRx(
//   empty: GetSearchModel(),
//   dataFetcher: BehaviorSubject<GetSearchModel>(),
// );
// PostRequestPayoutRx postRequestPayoutRx = PostRequestPayoutRx(
//   empty: PostRequestPayoutModel(),
//   dataFetcher: BehaviorSubject<PostRequestPayoutModel>(),
// );
// GetWispersRx getWispersRx = GetWispersRx(
//   empty: GetWispersModel(),
//   dataFetcher: BehaviorSubject<GetWispersModel>(),
// );
// DeleteAccountRx deleteAccountRx = DeleteAccountRx(
//   empty: DeleteAccountModel(),
//   dataFetcher: BehaviorSubject<DeleteAccountModel>(),
// );
// PostStoryReactRx postStoryReactRx = PostStoryReactRx(
//   empty: PostStoryReactModel(),
//   dataFetcher: BehaviorSubject<PostStoryReactModel>(),
// );
// PostStoryReplyRx postStoryReplyRx = PostStoryReplyRx(
//   empty: PostStoryReplyModel(),
//   dataFetcher: BehaviorSubject<PostStoryReplyModel>(),
// );
// GetTopFanCreatorRx getTopFanCreatorRx = GetTopFanCreatorRx(
//   empty: GetTopFanCreatorModel(),
//   dataFetcher: BehaviorSubject<GetTopFanCreatorModel>(),
// );
// GetProfileDetailsRx getProfileDetailsRx = GetProfileDetailsRx(
//   empty: GetProfileDetailsModel(),
//   dataFetcher: BehaviorSubject<GetProfileDetailsModel>(),
// );
// PostTurnOffRx postTurnOffRx = PostTurnOffRx(
//   empty: PostTurnOffCommentModel(),
//   dataFetcher: BehaviorSubject<PostTurnOffCommentModel>(),
// );
// PostMuteRx postMuteRx = PostMuteRx(
//   empty: PostMuteModel(),
//   dataFetcher: BehaviorSubject<PostMuteModel>(),
// );
// PostReportRx postReportRx = PostReportRx(
//   empty: PostReportModel(),
//   dataFetcher: BehaviorSubject<PostReportModel>(),
// );
// PostBlockRx postBlockRx = PostBlockRx(
//   empty: PostBlockModel(),
//   dataFetcher: BehaviorSubject<PostBlockModel>(),
// );
// GetUserBlockRx getUserBlockRx = GetUserBlockRx(
//   empty: GetUserBlockModel(),
//   dataFetcher: BehaviorSubject<GetUserBlockModel>(),
// );
// GetSuggestedRx getSuggestedRx = GetSuggestedRx(
//   empty: GetSuggestedModel(),
//   dataFetcher: BehaviorSubject<GetSuggestedModel>(),
// );
