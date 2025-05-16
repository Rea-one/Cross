

import manager from "./store_tar"


import distributedKVStore from "@ohos.data.distributedKVStore"

class Dism {
  The: Map<string, manager> = new Map<string, manager>();
  public targets: string[] = [];

  constructor() {
    for (let elem of this.targets) {
      this.The[elem] = new manager(elem);
    }
  }

  reset(value: string[]) {
    this.The.clear();
    this.targets = value;
    for (let elem of this.targets) {
      this.The[elem] = new manager(elem);
    }
  }

  check (store: string) {
    if (this.The[store]) {
      return
    } else {
      this.targets.push(store);
      this.The[store] = new manager(store);
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

  tar(key: string): manager {
    this.check(key);
    return this.The[key];
  }
}

export default new Dism()