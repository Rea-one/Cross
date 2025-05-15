
import nets from "./nets"
import waiter from "./waiter"
import pref from "./pref"
import SocketInfo from "../model/socket";
import { arrayBufferToString } from "../util/BufferUtil"
import info from "../model/info"


class Syncer {
  timestamp: string = "";

  constructor() {
    this.timestamp = pref.get("timestamp");
    nets.subscribe((value: SocketInfo) => {
      let now = this.receive(value);
      switch (now.state) {

      }
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