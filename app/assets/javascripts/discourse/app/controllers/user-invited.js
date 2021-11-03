import Controller from "@ember/controller";
import discourseComputed from "discourse-common/utils/decorators";
import I18n from "I18n";

export default Controller.extend({
  @discourseComputed("invitesCount.total", "invitesCount.pending")
  pendingLabel(invitesCountTotal, invitesCountPending) {
    if (invitesCountTotal > 0) {
      return I18n.t("user.invited.pending_tab_with_count", {
        count: invitesCountPending,
      });
    } else {
      return I18n.t("user.invited.pending_tab");
    }
  },

  @discourseComputed("invitesCount.total", "invitesCount.expired")
  expiredLabel(invitesCountTotal, invitesCountExpired) {
    if (invitesCountTotal > 0) {
      return I18n.t("user.invited.expired_tab_with_count", {
        count: invitesCountExpired,
      });
    } else {
      return I18n.t("user.invited.expired_tab");
    }
  },

  @discourseComputed("invitesCount.total", "invitesCount.redeemed")
  redeemedLabel(invitesCountTotal, invitesCountRedeemed) {
    if (invitesCountTotal > 0) {
      return I18n.t("user.invited.redeemed_tab_with_count", {
        count: invitesCountRedeemed,
      });
    } else {
      return I18n.t("user.invited.redeemed_tab");
    }
  },
});
