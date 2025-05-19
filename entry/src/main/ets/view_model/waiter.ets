
import config from "../model/config"
import { OneBunch, GroupBunch, FriendBunch, MessageBunch, ImageBunch, FriendReqBunch } from "./VMUtil/bunches"

import hot from "../model/hot"

import dism from "./VMUtil/dism"
import pref from "./VMUtil/pref"


import One from "../model/one"
import Group from "../model/group"
import Friend from "../model/friend"
import Message from "../model/message"
import Image from "../model/image"


class Waiter {
  public timestamp = "";
  public The_cfg: config = new config();
  public The_hot: hot = new hot();
  public The_one: OneBunch = new OneBunch();
  public The_grp: GroupBunch = new GroupBunch();
  public The_frd: FriendBunch = new FriendBunch();
  public The_msg: MessageBunch = new MessageBunch();
  public The_img: ImageBunch = new ImageBunch();
  public The_frq: FriendReqBunch= new FriendReqBunch();
  // 库键 对象键
  stpList: [string, string][] = [];

  private initialized: boolean = false;

  constructor() {
    this.init();
  }

  async init(): Promise<void> {
    if (this.initialized) return;

    try {
      pref.onCreate(); // 等待 Pref 初始化完成

      // 再继续加载数据
      this.timestamp = pref.get("timestamp");
      this.The_cfg = pref.getOBJ("ID") as config;
      this.The_hot = pref.getOBJ("hot") as hot;

      await Promise.all([
        this.The_one.load(dism.The["one"]),
        this.The_grp.load(dism.The["group"]),
        this.The_frd.load(dism.The["friend"]),
        this.The_msg.load(dism.The["message"]),
        this.The_img.load(dism.The["image"]),
        this.The_frq.load(dism.The["friendReq"])
      ]);

      this.The_msg.setFilter(this.The_cfg.ID);
      this.initialized = true;
    } catch (error) {
      console.error("Waiter 初始化失败:", error);
    }
  }

  isInitialized(): boolean {
    return this.initialized;
  }

  write(key: string, obj: object) {
    switch (key) {
      case "one":
        this.The_one.ubmit(obj as One);
        break;
      case "group":
        this.The_grp.ubmit(obj as Group);
        break;
      case "friend":
        this.The_frd.ubmit(obj as Friend);
        break;
      case "message":
        this.The_msg.add(obj as Message);
        break;
      case "image":
        this.The_img.ubmit(obj as Image);
        break;
      case "config":
        this.actConfig(obj as config);
      default:
        return;
    }
  }


  save() {
    this.The_one.save(dism.The["one"]);
    this.The_grp.save(dism.The["group"]);
    this.The_frd.save(dism.The["friend"]);
    this.The_msg.save(dism.The["message"]);
    this.The_img.save(dism.The["image"]);
    this.The_frq.save(dism.The["friendReq"]);
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