
import config from "../model/config"
import group from "../model/group"
import one from "../model/one"
import image from "../model/image"
import friend from "../model/friend"

import dism from "./dism"
import pref from "./pref"
import distributedKVStore from "@ohos.data.distributedKVStore"


class Waiter {
  The_one: Map<string, one> = new Map()
  The_grp: Map<string, group> = new Map()
  The_frd: Map<string, friend> = new Map()
  The_img: Map<string, image> = new Map()

  constructor() {
    this.The_one = dism.The["one"].getAllEntries();
    this.The_grp = dism.The["group"].getAllEntries();
    this.The_frd = dism.The["friend"].getAllEntries();
    this.The_img = dism.The["image"].getAllEntries();
  }

  write(key: string, ID: string, obj: object) {
    switch (key) {
      case "one":
        this.The_one[ID] = obj;
        break;
      case "group":
        this.The_grp[ID] = obj;
        break;
      case "friend":
        this.The_frd[ID] = obj;
        break;
      case "image":
        this.The_img[ID] = obj;
        break;
      default :
        return
    }
    dism.The[key].put(obj);
  }

}
export default new Waiter()