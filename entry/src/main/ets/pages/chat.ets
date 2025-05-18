import Message from "../model/message";
import waiter from "../viewmodel/waiter"
import nets from "../viewmodel/nets"
import guide from "../viewmodel/navigator"

@Component
export struct ChatPage {
  @Consume("chatTar") chatTar: string;

  @State target: string = ""
  @State message: string = ""


  aboutToAppear(): void {
  }

  build() {
    Column(){
      List() {
        ForEach(waiter.The_msg.get(this.chatTar)?.The, (the: Message) => {
          ListItem() {

            if (the.sender == this.chatTar) {
              Row() {
                Image(waiter.The_img.get(waiter.The_one.get(the.sender)?.IconID).URL);
                Column() {
                  Text(waiter.The_one.get(the.sender)?.Name);
                  Text(the.the)
                }
              }
            } else {
              Row() {
                Image(waiter.The_img.get(waiter.The_one.get(the.sender)?.IconID).URL);
                Column() {
                  Text(waiter.The_one.get(the.sender)?.Name);
                  Text(the.the)
                }
              }
            }
          }
        })
      }
      Row(){
        TextInput()
          .onChange((val) => {
            this.message = val
          })
        Button("发送")
          .onClick(() => {
            nets.send(`a ${waiter.The_cfg.ID} r ${this.chatTar} m ${this.message}`)
            this.message = ""
          })
      }
    }
  }
}