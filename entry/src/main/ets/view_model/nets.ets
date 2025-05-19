

import SocketInfo from "../model/socket";

import { socket } from "@kit.NetworkKit";
import { BusinessError } from "@kit.BasicServicesKit";
import { UIAbility } from "@kit.AbilityKit";

class Nets {
  Sock: socket.TCPSocket = socket.constructTCPSocketInstance();
  address: socket.NetAddress = {} as socket.NetAddress;

  constructor() {
    this.init();
    this.connect();
  }

  init(){
    // 启动网络
    this.address.address = "192.168.43.188";
    this.address.port = 25054;
  }

  connect(){
    let conn: socket.TCPConnectOptions = {} as socket.TCPConnectOptions
    conn.address = this.address
    conn.timeout = 9000
    this.Sock.connect(conn)
  }


  send(value: string){
    let current_mess: socket.TCPSendOptions = {
      data: value
    }
    this.Sock.send(current_mess)
  }

  subscribe(feedback: (value: SocketInfo) => void) {
    this.Sock.on("message", feedback)
  }
}

export default new Nets()
