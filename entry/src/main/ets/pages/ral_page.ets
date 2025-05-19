import nets from "../view_model/nets"

import guide from "../view_model/navigator"

import syncer from "../view_model/syncer"

@Component
export struct RalPage {
  // @Consume("syn") syn: Syncer

  @State account: string = '';
  @State password: string = '';

  build() {
    NavDestination() {
      Column() {
        Row() {
          Text('账号');
          TextInput({ placeholder: '请输入账号' })
            .onChange((value: string) => {
              this.account = value;
            });
        }

        Row() {
          Text('密码');
          TextInput({ placeholder: '请输入密码' })
            .onChange((value: string) => {
              this.password = value;
            })
            .type(InputType.Password);
        }

        Row() {
          Button('注册')
            .onClick(() => {
              guide.to("reg");
            });
          Button('登录')
            .onClick(() => {
              nets.send(`a ${this.account} pw ${this.password} t lg`);
              // 开始轮询
              const pollInterval = setInterval(() => {
                if (syncer.state === "login success") {
                  clearInterval(pollInterval); // 停止轮询
                  guide.clear();
                  guide.to("yours");
                } else if (syncer.state === "reject") {
                  clearInterval(pollInterval); // 停止轮询
                }
              }, 500); // 每500毫秒检查一次
            });
        }
      }
    }
  }
}