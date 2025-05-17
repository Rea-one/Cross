import waiter from "../viewmodel/waiter"


@Component
export struct ChatPage {
  @State target: string = ""
  @State message: string = ""


  aboutToAppear(): void {
  }

  build() {
    Column(){
      List() {
        ForEach(waiter., (item: string, index: number) => {
          ListItem() {
            if (item[0] == this.chatTar) {
              Row() {
                if (this.friend != null) {
                  Image(this.waiter.getImg(this.friend.IconID))
                  Column() {
                    Text(this.friend.Name)
                    Text(item[1])
                  }
                } else {
                  Image(this.waiter.getImg("default"))
                  Column() {
                    Text("这是一个名字")
                    Text(item[1])
                  }
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
            if (this.self != null){
              this.nets.send(`a ${this.self.ID} r ${this.chatTar} m ${this.message}`)
            }
            this.message = ""
          })
      }
    }
  }
}