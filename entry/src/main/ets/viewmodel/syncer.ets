
import nets from "./nets"
import waiter from "./waiter"
import pref from "./VMUtil/pref"
import SocketInfo from "../model/socket";
import { arrayBufferToString } from "../util/BufferUtil"
import info from "../model/info"
import One from "../model/one";
import Group from "../model/group";
import { info2friend, info2group, info2image, info2message, info2one } from "../util/intrans";


class Syncer {
  timestamp: string = "";

  constructor() {
    this.timestamp = pref.get("timestamp");
    nets.subscribe((value: SocketInfo) => {
      let now = this.receive(value);
      switch (now.state) {
        // case "one":
        //   break;
        // case "group":
        //   break;
        // case "friend":
        //   break;
        // case "message":
        //   break;
        // case "image":
        //   break;
        case "one":
          let the_one = info2one(now);
          waiter.write("one", the_one.ID, the_one);
          break;
        case "group":
          let the_group = info2group(now);
          waiter.write("group", "id", the_group);
          break;
        case "friend":
          let the_friend = info2friend(now);
          waiter.write("friend", the_friend.ID, the_friend);
          break;
        case "message":
          let the_message = info2message(now);
          waiter.write("message", "ID", the_message);
          break;
        case "image":
          let the_img = info2image(now);
          waiter.write("image", the_img.ID, the_img);
        case "config":
          waiter.write("config", "", now);
          break;
      }
      waiter.sync();
    })
  }

  receive(value: SocketInfo): info {
    return JSON.parse(arrayBufferToString(value.message));
  }

  arrayBufferToString(buffer: ArrayBuffer): string {
    let str = '';
    const dataView = new DataView(buffer);
    for (let order = 0; order < dataView.byteLength; order++) {
      str += String.fromCharCode(dataView.getUint8(order));
    }
    return str;
  }
}

export default new Syncer();