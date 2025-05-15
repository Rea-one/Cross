import store from "./store";

import { Options } from "../model/options";
import { TransInside, TransOutside } from "../util/intrans"


import distributedKVStore from "@ohos.data.distributedKVStore";


export default class StoreTar {
  The: distributedKVStore.SingleKVStore | null = null;
  constructor(value: string) {
    store.get_store(value, Options).then((val: distributedKVStore.SingleKVStore) => {
      this.The = val;
    })
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
    this.The?.put(key, TransInside(target))
  }
}