
import { TransInside, TransOutside } from "../util/intrans"

import { preferences } from "@kit.ArkData"
import { UIAbility } from "@kit.AbilityKit"
import { util } from "@kit.ArkTS";


class Pref extends UIAbility {
  Options: preferences.Options = { name: "now" };
  The: preferences.Preferences | null = null;

  onCreate(): void {
    this.The = preferences.getPreferencesSync(this.context, this.Options);
  }

  get(key: string): string {
    if (!this.The) {
      throw new Error("Pref is not initialized.");
    }
    let uInt8Array2 : preferences.ValueType = this.The.getSync(key, new Uint8Array(0));
    let textDecoder = util.TextDecoder.create('utf-8');
    return textDecoder.decodeToString(uInt8Array2 as Uint8Array);
  }

  put(key: string, val: string) {
    if (!this.The) {
      throw new Error("Pref is not initialized.");
    }
    if (this.The.hasSync(key)) {
      console.info(`The key ${key} is contained.`);
    } else {
      console.info(`The key ${key} does not contain.`);
      // 此处以此键值对不存在时写入数据为例
      this.The.putSync(key, val);
      // // 当字符串有特殊字符时，需要将字符串转为Uint8Array类型再存储
      // let uInt8Array1 = new util.TextEncoder().encodeInto("~！@#￥%……&*（）——+？");
      // this.The.putSync('uInt8', uInt8Array1);
    }
  }
  // 获取 key 对应的对象，自动反序列化
  getOBJ(key: string): object | null {
    if (!this.The) {
      throw new Error("Pref is not initialized.")
    }
    const uInt8Array2: preferences.ValueType = this.The.getSync(key, new Uint8Array(0))
    const textDecoder = util.TextDecoder.create('utf-8')
    const strValue = textDecoder.decodeToString(uInt8Array2 as Uint8Array)
    return TransOutside(strValue) // 自动转成 object
  }

  // 存储 key-value，value 是 object 类型，自动序列化
  putOBJ(key: string, val: object) {
    if (!this.The) {
      throw new Error("Pref is not initialized.")
    }
    const strValue = TransInside(val) // 序列化对象
    const encoder = new util.TextEncoder()
    const uInt8Array = encoder.encodeInto(strValue)
    this.The.putSync(key, uInt8Array) // 存储为 Uint8Array 更安全兼容
  }
}

export default new Pref()