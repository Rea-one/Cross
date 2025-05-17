import Message from './message';
import One from './one';
import distributedKVStore from '@ohos.data.distributedKVStore';

class Bunch {
  ID: string = "";
  fast: Map<string, number> = new Map();
  cache: string[] = []

  // IDCheck(the: Bunch) {
  //   return the.ID == this.ID;
  // }
  submit(the: object) {};
  ubmit(the: object) {};
  save(the: distributedKVStore.SingleKVStore) {};
}

class OneBunch extends Bunch {
  The: One[] = [];

  __submit(the: One) {
    if (this.fast[the.ID]) {
      console.warn(`已存在的数据，拒绝  类型：${typeof this}`)
      return false;
    }
    this.fast[the.ID] = this.The.length;
    this.The.push(the);
    return true;
  }
  submit(the: One) {
    if (this.__submit(the)) {
      this.cache.push(the.ID);
    }
  }
  __ubmit(the: One) {
    if (this.fast[the.ID]) {
      this.The[this.fast[the.ID]] = the;
      return false;
    } else {
      this.__submit(the);
      return true;
    }
  }

  ubmit(the: One) {
    if (this.__ubmit(the)) {
      this.cache.push(the.ID);
    }
  }
  save(the: distributedKVStore.SingleKVStore) {

  }
}


class MessageBunch {
  ID: string = "";
  The: Message[] = [];
  Timestamp: string = "";

  update(now: MessageBunch) {
    if (now.ID != this.ID) {
      console.warn("ID不符");
      return;
    }
    this.Timestamp = now.Timestamp;
  }
}