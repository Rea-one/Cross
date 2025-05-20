import Friend from "../model/friend";
import Group from "../model/group";
import Image from "../model/image";
import Info from "../model/info";
import Message from "../model/message";
import One from "../model/one";


// 将socketInfo 转换成json

export function TransInside(value: object): string {
  return JSON.stringify(value)
}

export function TransOutside(value: string | number | boolean | Uint8Array): object | null {
  if (typeof(value) == "string") {
    return JSON.parse(value)
  }
  return null
}

export function info2one(info: Info) {
  let the = new One();
  the.ID = info.at;
  the.Timestamp = info.timestamp;
  the.Name = info.message;
  the.IconID = info.image;
  return the;
}

export function info2group(info: Info) {
  let the = new Group();
  the.ID = info.sender;
  the.Name = info.receiver;
  the.Timestamp = info.timestamp;
  the.Unfolds = false;
  return the;
}

export function info2friend(info: Info) {
  let the = new Friend();
  the.ID = info.sender;
  the.Timestamp = info.timestamp;
  the.Group = info.receiver;
  the.State = info.message;
  return the;
}

export function info2message(info: Info) {
  let the = new Message();
  the.sender = info.sender;
  the.receiver = info.receiver;
  the.timestamp = info.timestamp;
  the.the = info.message;
  return the;
}

export function info2image(info: Info) {
  let the = new Image();
  the.ID = info.image;
  the.Timestamp = info.timestamp;
  the.URL = info.message;
  return the;
}