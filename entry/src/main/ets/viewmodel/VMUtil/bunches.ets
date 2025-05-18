import One from "../../model/one";
import Group from "../../model/group";
import Friend from "../../model/friend";
import Message from "../../model/message";
import Image from "../../model/image";
import FriendReq from "../../model/friend_req"
import StoreTar from "./store_tar"
import { max, min } from "../../util/normal"

export class Bunch<T> {
  ID: string = "";
  public The: T[] = []
  public fast: Map<string, number> = new Map();
  cache: string[] = []

  // IDCheck(the: Bunch) {
  //   return the.ID == this.ID;
  // }
  async load(the: StoreTar) {};
  submit(the: object) {};
  ubmit(the: object) {};
  save(the: StoreTar) {
    for (let now = this.cache.pop(); now != undefined; now = this.cache.pop()) {
      the.put(now, this.The[this.fast[now]] as object);
    }
  }
  get(ID: string) {
    if (this.fast[ID]) {
      return this.The[this.fast[ID]];
    }
    return null;
  }
}

export class OneBunch extends Bunch<One> {

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
}

export class GroupBunch extends Bunch<Group> {

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

}


export class FriendBunch extends Bunch<Friend> {

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
}

export class MessageBun extends Bunch<Message> {

  __submit(the: Message) {
    if (this.fast[the.ID]) {
      console.warn(`已存在的数据，拒绝  类型：${typeof this}`)
      return false;
    }
    this.fast[the.ID] = this.The.length;
    this.The.push(the);
    return true;
  }
  submit(the: Message) {
    if (this.__submit(the)) {
      this.cache.push(the.ID);
    }
  }
  __ubmit(the: Message) {
    if (this.fast[the.ID]) {
      this.The[this.fast[the.ID]] = the;
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
      this.cache.push(the.ID);
    }
  }
}

export class MessageBunch extends Bunch<MessageBun> {
  public filter: Map<string, boolean> = new Map();

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
      this.addBun(the);
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
    let targetID = '';

    if (this.fast[the.sender] !== undefined && !this.filterCheck(the.sender)) {
      targetID = the.sender;
    } else if (this.fast[the.receiver] !== undefined && !this.filterCheck(the.receiver)) {
      targetID = the.receiver;
    }

    if (targetID) {
      // ✅ 新增：防止重复 push
      if (!this.cache.includes(targetID)) {
        this.cache.push(targetID);
      }
      this.The[this.fast[targetID]].submit(the);
    } else {
      console.warn("不存在该好友，消息无法添加");
    }
  }

  addBun(the: MessageBun) {
    if (this.fast[the.ID]) {
      const targetIndex: number = this.fast[the.ID];
      const target = this.The[targetIndex];

      let begin = min(the.cache.length, target.cache.length);
      let end = max(the.cache.length, target.cache.length);

      for (let order = begin; order < end; order++) {
        if (order === target.cache.length) {
          break;
        }
        target.submit(the.The[the.cache[order]]);
      }

      // ✅ 标记为需保存
      if (!this.cache.includes(the.ID)) {
        this.cache.push(the.ID);
      }
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

  setFilter(the: string) {
    if (this.filter[the]) {
      return;
    }
    this.filter[the] = true;
  }
}


export class ImageBunch extends Bunch<Image> {
  HidImage: Image = new Image();

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

  get(ID: string) {
    if (this.fast[ID]) {
      return this.The[this.fast[ID]];
    }
    return this.HidImage;
  }
}


export class FriendReqBunch extends Bunch<FriendReq> {
  async load(the: StoreTar): Promise<void> {
    const entries = await the.getAllEntries();
    entries.forEach((value, key) => {
      const tar = value as FriendReq; // 类型根据具体 Bunch 调整
      if (!this.fast.has(key)) {
        this.fast[key] = this.The.length;
        this.The.push(tar);
      }
    })
  }
  __submit(the: FriendReq) {
    if (this.fast[the.ID]) {
      console.warn(`已存在的数据，拒绝  类型：${typeof this}`)
      return false;
    }
    this.fast[the.ID] = this.The.length;
    this.The.push(the);
    return true;
  }
  submit(the: FriendReq) {
    if (this.__submit(the)) {
      this.cache.push(the.ID);
    }
  }
  __ubmit(the: FriendReq) {
    if (this.fast[the.ID]) {
      this.The[this.fast[the.ID]] = the;
      return false;
    } else {
      this.__submit(the);
      return true;
    }
  }
  ubmit(the: FriendReq) {
    if (this.__ubmit(the)) {
      this.cache.push(the.ID);
    }
  }
}