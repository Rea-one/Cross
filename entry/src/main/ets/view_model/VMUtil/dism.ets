

import StoreTar from "./store_tar"


import distributedKVStore from "@ohos.data.distributedKVStore"

class Dism {
  The: Map<string, StoreTar> = new Map<string, StoreTar>();
  public targets: string[] = ["one", "group", "friend", "message", "image", "friendReq"];

  constructor() {
    for (let elem of this.targets) {
      this.The[elem] = new StoreTar(elem);
    }
  }

  reset(value: string[]) {
    this.The.clear();
    this.targets = value;
    for (let elem of this.targets) {
      this.The[elem] = new StoreTar(elem);
    }
  }

  check (store: string) {
    if (this.The[store]) {
      return
    } else {
      this.targets.push(store);
      this.The[store] = new StoreTar(store);
    }
  }

  get(index: string, key: string): object {
    this.check(index);
    return this.The[index].get(key)
  }
  put(index: string, key: string, target: object) {
    this.check(index);
    this.The[index].put(key, target)
  }

  tar(key: string): StoreTar {
    this.check(key);
    return this.The[key];
  }
}

export default new Dism()