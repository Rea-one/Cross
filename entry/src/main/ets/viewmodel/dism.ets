

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

  get(index: string, key: string): object {
    return this.The[index].get(key)
  }
  put(index: string, key: string, target: object) {
    this.The[index].put(key, target)
  }
}

export default new Dism()