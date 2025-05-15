
import { TransInside, TransOutside } from "../util/intrans"

import { preferences } from "@kit.ArkData"
import { UIAbility } from "@kit.AbilityKit"


class Pref extends UIAbility {
  Options: preferences.Options = { name: "now" };
  The: preferences.Preferences | null = null;

  onCreate(): void {
    preferences.getPreferences(this.context, this.Options).then((pref) => {
      this.The = pref;
    });
  }

  async get(key: string): object {
    if (!this.The) {
      throw new Error("Pref is not initialized.");
    }
    const value = this.The.getSync(key, "string");


  }
}

export default new Pref()