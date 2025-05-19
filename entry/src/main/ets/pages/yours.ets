import FriendReq from "../model/friend_req";
import Group from "../model/group";
import waiter from "../view_model/waiter"
import guide from "../view_model/navigator"
import nets from "../view_model/nets"


@Component
export struct Yours {
  @Provide('chatTar') chatTar: string = "";

  @State addFriend: boolean = false;

  aboutToAppear(): void {
    for (let elem of waiter.The_grp.The) {
      elem.Unfolds = false;
    }
  }

  build() {
    NavDestination() {
      Column() {
        Row () {
          Button("更多")
            .onClick(() => {

            })
            .margin({ right: 10 })
        }
        .margin({ right: 10 })
        .width("100%")

        Tabs({ barPosition: BarPosition.End }) {
          TabContent() {
            List() {
              ForEach(waiter.The_hot.The, (ID: string) => {
                ListItem() {
                  Button(){
                    Row() {
                      Image(waiter.The_img.get(waiter.The_one.get(ID)?.IconID).URL);
                      Column() {
                        Text(waiter.The_one.get(ID)?.Name);
                      }
                    }
                  }
                  .onClick(() => {
                    this.chatTar = ID
                    guide.to("chat");
                  })
                }
              })
            }
            .width("100%")
            .height("100%")
          }
          .tabBar("消息")


          TabContent() {
            List() {
              ForEach(waiter.The_grp.The, (the: Group) => {
                ListItem() {
                  Button(the.Name)
                    .onClick(() => {
                      the.Unfolds = !the.Unfolds;
                    })
                }
                if (the.Unfolds) {
                  ForEach(the.The, (ID: string) => {
                    ListItem() {
                      Button(){
                        Row() {
                          Image(waiter.The_img.get(waiter.The_one.get(the.ID)?.IconID).URL);
                          Text(waiter.The_one.get(ID)?.Name);
                        }
                      }
                      .onClick(() => {
                        this.chatTar = ID
                        guide.to("chat");
                      })
                    }
                  })
                }
              })
            }
            .width("100%")
            .height("100%")
          }
          .tabBar("联系人")

          TabContent(){
            Column(){
              Row(){
                Text("昵称")
                Text(waiter.The_one.get(waiter.The_cfg.ID)?.Name)
              }
              .width("100%")
              Row(){
                Text("账号")
                Text(waiter.The_cfg.ID)
              }
              .width("100%")
              Row() {
                Button()
                List() {
                  ForEach(waiter.The_frq.The, (the: FriendReq) => {
                    ListItem() {
                      Row() {
                        Image(waiter.The_img.get(waiter.The_one.get(the.ID)?.IconID).URL);
                        Text(waiter.The_one.get(the.ID)?.Name);
                        Button("同意")
                          .onClick(() => {
                            nets.send(`a ${waiter.The_cfg.ID} s ${waiter.The_cfg.ID} r ${the.ID} t rad m ture`);
                          })
                        Button("拒绝")
                          .onClick(() => {
                            nets.send(`a ${waiter.The_cfg.ID} s ${waiter.The_cfg.ID} r ${the.ID} t rad m false`);
                          })
                      }
                    }
                  })
                }
                .width("100%")
                .height("100%")
              }
              .width("100%")
              Row(){
                Button("修改密码")
                  .onClick(() => {
                    guide.to("reset_password")
                  })
              }
              .width("100%")
              Row(){
                Button("修改昵称")
                  .onClick(() => {
                    guide.to("reset_name")
                  })
              }
              .width("100%")
              Row(){
                Button("修改头像")
                  .onClick(() => {

                  })
              }
              .width("100%")
            }
            .height("100%")
            .height("100%")
            .justifyContent(FlexAlign.SpaceBetween)
          }
          .tabBar("自己")
        }
        .width("100%")
      }
      .alignItems(HorizontalAlign.Center)
      .width("100%")
    }
    .height("100%")
    .width("100%")
  }
}