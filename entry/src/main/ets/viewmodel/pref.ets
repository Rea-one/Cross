import { preferences } from '@kit.ArkData'
import { UIAbility } from '@kit.AbilityKit'


class Pref extends UIAbility {
  Options: preferences.Options = { name: "now" };
  The: preferences.Preferences | null = null;

  onCreate(): void {
    preferences.getPreferences(this.context, this.Options).then((pref) => {
      this.The = pref;
    });
  }
}

export default new Pref()