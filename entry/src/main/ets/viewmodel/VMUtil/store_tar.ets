import store from "./store";

import { Options } from "../../model/options";
import { TransInside, TransOutside } from "../../util/intrans"


import distributedKVStore from "@ohos.data.distributedKVStore";


// store_tar.ets

export default class StoreTar {
  public The: distributedKVStore.SingleKVStore | null = null;

  constructor(value: string) {
    store.get_store(value, Options).then((val: distributedKVStore.SingleKVStore) => {
      this.The = val;
    });
  }

  async get(key: string): Promise<object | null> {
    if (!this.The) {
      throw new Error("KVStore is not initialized.");
    }
    try {
      const value = await this.The.get(key);
      return TransOutside(value);
    } catch (error) {
      console.error(`Failed to get key ${key}:`, error);
      return null;
    }
  }

  put(key: string, target: object) {
    this.The?.put(key, TransInside(target));
  }

  // 键值库的所有值
  async getAllEntries(): Promise<Map<string, object>> {
    if (!this.The) {
      throw new Error("KVStore is not initialized.");
    }
    const entriesMap = new Map<string, object>();
    try {
      const entries = await this.The.getEntries(""); // 获取所有条目
      for (const entry of entries) {
        if (typeof entry.value === "string") {
          const obj = TransOutside(entry.value);
          if (obj !== null) {
            entriesMap.set(entry.key, obj);
          } else {
            console.warn(`Failed to parse value for key "${entry.key}"`);
          }
        } else {
          console.warn(`Unsupported value type for key "${entry.key}"`, typeof entry.value);
        }
      }
    } catch (error) {
      console.error("Failed to get all entries:", error);
    }
    return entriesMap;
  }
}