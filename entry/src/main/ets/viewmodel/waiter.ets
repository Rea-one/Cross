
import config from "../model/config"
import group from "../model/group"
import one from "../model/one"
import image from "../model/image"
import friend from "../model/friend"
import message from "../model/message"

import hot from "../model/hot"

import dism from "./dism"
import pref from "./pref"
import distributedKVStore from "@ohos.data.distributedKVStore"


class Waiter {
  public The_cfg: config = new config();
  public The_hot: hot = new hot();
  public The_one: Map<string, one> = new Map();
  public The_grp: Map<string, group> = new Map();
  public The_frd: Map<string, friend> = new Map();
  public The_img: Map<string, image> = new Map();
  public The_msg: Map<string, message> = new Map();
  // 库键 对象键
  stpList: [string, string][] = [];

  constructor() {
    this.The_cfg = pref.getOBJ("ID") as config;
    this.The_hot = pref.getOBJ("hot") as hot;
    this.The_one = dism.The["one"].getAllEntries();
    this.The_grp = dism.The["group"].getAllEntries();
    this.The_frd = dism.The["friend"].getAllEntries();
    this.The_msg = dism.The["message"].getAllEntries();
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
      case "message":
        this.The_msg[ID] = (obj);
        break;
      case "image":
        this.The_img[ID] = obj;
        break;
      case "config":
        this.actConfig(obj as config);
      default:
        return;
    }
    this.stpList.push([key, ID]);
    dism.The[key].put(obj);
  }


  sync() {
    let elem = this.stpList.pop();
    while (elem != undefined) {
      switch (elem[0]) {
        case "one":
          dism.put("one", elem[1], this.The_one[elem[1]]);
        case "group":
          dism.put("group", elem[1], this.The_grp[elem[1]]);
        case "friend":
          dism.put("friend", elem[1], this.The_frd[elem[1]]);
        case "message":
          dism.put("message", elem[1], this.The_frd[elem[1]]);
        case "image":
          dism.put("image", elem[1], this.The_frd[elem[1]]);
        case "config":
          pref.putOBJ("config", this.The_cfg);
        default:
          break;
      }
      elem = this.stpList.pop();
    }
  }

  actConfig(cfg: config) {
    this.The_cfg.Timestamp = cfg.Timestamp;
    if (cfg.ID != "") {
      this.The_cfg.ID = cfg.ID;
    }
    if (cfg.State != "") {
      this.The_cfg.State = cfg.State;
    }
  }
}
export default new Waiter()