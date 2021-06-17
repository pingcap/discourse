import { htmlHelper } from "discourse-common/lib/helpers";
import { avatarImg } from "discourse/lib/utilities";
import { addExtraUserClasses } from "discourse/helpers/user-avatar";

export default htmlHelper((user, size) => {
  if (Ember.isEmpty(user)) {
    return "<div class='avatar-placeholder'></div>";
  }

  const avatarTemplate = Ember.get(user, "avatar_template");
  const img = avatarImg(addExtraUserClasses(user, { size, avatarTemplate }));
  const verified = Ember.get(user, "is_verified") || Ember.get(user, "user_is_verified") || Ember.get(user, "user.is_verified")

  if (verified) {
    return "<div class='tc-verified-avatar-wrapper'>" + img + "</div>";
  } else {
    return img;
  }
});
