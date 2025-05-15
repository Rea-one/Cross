import { util } from "@kit.ArkTS";

export function bufferToString(buffer: Uint8Array): string {
  let textDecoder = util.TextDecoder.create("utf-8", {
    ignoreBOM: true
  });
  let resultPut = textDecoder.decodeToString(buffer);
  return resultPut;
}

export function arrayBufferToString(buffer: ArrayBuffer): string {
  let str = '';
  const dataView = new DataView(buffer);
  for (let order = 0; order < dataView.byteLength; order++) {
    str += String.fromCharCode(dataView.getUint8(order));
  }
  return str;
}