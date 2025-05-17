import Friend from '../../model/friend';
import Group from '../../model/group';
import Image from '../../model/image';
import Message from '../../model/message';
import One from '../../model/one';
import StoreTar from "./store_tar"

class Bunch {
  ID: string = "";
  fast: Map<string, number> = new Map();
  cache: string[] = []

  // IDCheck(the: Bunch) {
  //   return the.ID == this.ID;
  // }
  async load(the: StoreTar) {};
  submit(the: object) {};
  ubmit(the: object) {};
  save(the: StoreTar) {};
}

class OneBunch extends Bunch {
  The: One[] = [];

  async load(the: StoreTar): Promise<void> {
    const entries = await the.getAllEntries();
    entries.forEach((value, key) => {
      const tar = value as One; // 类型根据具体 Bunch 调整
      if (!this.fast.has(key)) {
        this.fast[key] = this.The.length;
        this.The.push(tar);
      }
    });
  }

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
  save(the: StoreTar) {
    for (let now = this.cache.pop(); now != undefined; now = this.cache.pop()) {
      the.put(now, this.The[this.fast[now]]);
    }
  }
}

class GroupBunch extends Bunch {
  The: Group[] = [];

  async load(the: StoreTar): Promise<void> {
    const entries = await the.getAllEntries();
    entries.forEach((value, key) => {
      const tar = value as Group; // 类型根据具体 Bunch 调整
      if (!this.fast.has(key)) {
        this.fast[key] = this.The.length;
        this.The.push(tar);
      }
    });
  }

  __submit(the: Group) {
    if (this.fast[the.ID]) {
      console.warn(`已存在的数据，拒绝  类型：${typeof this}`)
      return false;
    }
    this.fast[the.ID] = this.The.length;
    this.The.push(the);
    return true;
  }
  submit(the: Group) {
    if (this.__submit(the)) {
      this.cache.push(the.ID);
    }
  }
  __ubmit(the: Group) {
    if (this.fast[the.ID]) {
      this.The[this.fast[the.ID]] = the;
      return false;
    } else {
      this.__submit(the);
      return true;
    }
  }

  ubmit(the: Group) {
    if (this.__ubmit(the)) {
      this.cache.push(the.ID);
    }
  }
  save(the: StoreTar) {
    for (let now = this.cache.pop(); now != undefined; now = this.cache.pop()) {
      the.put(now, this.The[this.fast[now]]);
    }
  }
}


class FriendBunch extends Bunch {
  The: Friend[] = [];

  async load(the: StoreTar): Promise<void> {
    const entries = await the.getAllEntries();
    entries.forEach((value, key) => {
      const tar = value as Friend; // 类型根据具体 Bunch 调整
      if (!this.fast.has(key)) {
        this.fast[key] = this.The.length;
        this.The.push(tar);
      }
    });
  }

  __submit(the: Friend) {
    if (this.fast[the.ID]) {
      console.warn(`已存在的数据，拒绝  类型：${typeof this}`)
      return false;
    }
    this.fast[the.ID] = this.The.length;
    this.The.push(the);
    return true;
  }
  submit(the: Friend) {
    if (this.__submit(the)) {
      this.cache.push(the.ID);
    }
  }
  __ubmit(the: Friend) {
    if (this.fast[the.ID]) {
      this.The[this.fast[the.ID]] = the;
      return false;
    } else {
      this.__submit(the);
      return true;
    }
  }

  ubmit(the: Friend) {
    if (this.__ubmit(the)) {
      this.cache.push(the.ID);
    }
  }
  save(the: StoreTar) {
    for (let now = this.cache.pop(); now != undefined; now = this.cache.pop()) {
      the.put(now, this.The[this.fast[now]]);
    }
  }
}

class MessageBunch extends Bunch {
  The: MessageBun[] = [];
  filter: Map<string, boolean> = new Map();

  async load(the: StoreTar): Promise<void> {
    const entries = await the.getAllEntries();
    entries.forEach((value, key) => {
      const tar = value as MessageBun; // 类型根据具体 Bunch 调整
      if (!this.fast.has(key)) {
        this.fast[key] = this.The.length;
        this.The.push(tar);
      }
    });
  }

  __submit(the: MessageBun) {
    if (this.fast[the.ID]) {
      console.warn(`已存在的数据，拒绝  类型：${typeof this}`)
      return false;
    }
    this.fast[the.ID] = this.The.length;
    this.The.push(the);
    return true;
  }
  submit(the: MessageBun) {
    if (this.__submit(the)) {
      this.cache.push(the.ID);
    }
  }
  __ubmit(the: MessageBun) {
    if (this.fast[the.ID]) {
      this.The[this.fast[the.ID]] = the;
      return false;
    } else {
      this.__submit(the);
      return true;
    }
  }

  ubmit(the: MessageBun) {
    if (this.__ubmit(the)) {
      this.cache.push(the.ID);
    }
  }

  add(the: Message) {
    if (!this.filterCheck(this.fast[the.sender]) && this.fast[the.sender]) {
      this.cache.push(the.sender);
      this.The[this.fast[the.sender]].submit(the);
    } else if (!this.filterCheck(this.fast[the.receiver]) && this.fast[the.receiver]) {
      this.cache.push(the.receiver);
      this.The[this.fast[the.receiver]].submit(the);
    } else {
      console.warn("不存在该好友，消息无法添加");
    }
  }

  save(the: StoreTar) {
    for (let now = this.cache.pop(); now != undefined; now = this.cache.pop()) {
      this.The[this.fast[now]].save(the);
    }
  }

  filterCheck(the: string) {
    return this.filter[the] != undefined;
  }
}


class ImageBunch extends Bunch {
  The: Image[] = [];

  async load(the: StoreTar): Promise<void> {
    const entries = await the.getAllEntries();
    entries.forEach((value, key) => {
      const tar = value as Image; // 类型根据具体 Bunch 调整
      if (!this.fast.has(key)) {
        this.fast[key] = this.The.length;
        this.The.push(tar);
      }
    });
  }

  __submit(the: Image) {
    if (this.fast[the.ID]) {
      console.warn(`已存在的数据，拒绝  类型：${typeof this}`)
      return false;
    }
    this.fast[the.ID] = this.The.length;
    this.The.push(the);
    return true;
  }
  submit(the: Image) {
    if (this.__submit(the)) {
      this.cache.push(the.ID);
    }
  }
  __ubmit(the: Image) {
    if (this.fast[the.ID]) {
      this.The[this.fast[the.ID]] = the;
      return false;
    } else {
      this.__submit(the);
      return true;
    }
  }

  ubmit(the: Image) {
    if (this.__ubmit(the)) {
      this.cache.push(the.ID);
    }
  }
  save(the: StoreTar) {
    for (let now = this.cache.pop(); now != undefined; now = this.cache.pop()) {
      the.put(now, this.The[this.fast[now]]);
    }
  }
}


class MessageBun extends Bunch {
  The: Message[] = [];

  __submit(the: Message) {
    if (this.fast[the.timestamp]) {
      console.warn(`已存在的数据，拒绝  类型：${typeof this}`)
      return false;
    }
    this.fast[the.timestamp] = this.The.length;
    this.The.push(the);
    return true;
  }
  submit(the: Message) {
    if (this.__submit(the)) {
      this.cache.push(the.timestamp);
    }
  }
  __ubmit(the: Message) {
    if (this.fast[the.timestamp]) {
      this.The[this.fast[the.timestamp]] = the;
      return false;
    } else {
      this.__submit(the);
      return true;
    }
  }

  // 目前禁止更新
  ubmit(the: Message) {
    return;
    if (this.__ubmit(the)) {
      this.cache.push(the.timestamp);
    }
  }

  save(the: StoreTar) {
    for (let now = this.cache.pop(); now != undefined; now = this.cache.pop()) {
      the.put(now, this.The[this.fast[now]]);
    }
  }
}