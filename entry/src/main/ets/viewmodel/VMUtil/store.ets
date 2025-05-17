

import distributedKVStore from "@ohos.data.distributedKVStore";
import { AbilityConstant, UIAbility, Want } from "@kit.AbilityKit";
import { BusinessError } from "@kit.BasicServicesKit";


class Store extends UIAbility {
  store: distributedKVStore.KVManager | null = null

  onCreate(): void {
    let context = this.context;
    const config: distributedKVStore.KVManagerConfig = {
      context: context,
      bundleName: "cn.edu.hit"
    }
    this.store = distributedKVStore.createKVManager(config)
  }

  get_store(target: string, opt: distributedKVStore.Options): Promise<distributedKVStore.SingleKVStore> {
    return new Promise((resolve, reject) => {
      this.store?.getKVStore(target, opt, (err: BusinessError, store: distributedKVStore.SingleKVStore) => {
        if (err) {
          reject(err);
        }
        else {
          resolve(store);
        }
      });
    });
  }
}

export  default new Store()