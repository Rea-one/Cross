import nets from "../viewmodel/nets"

import guide from "../viewmodel/navigator"

@Component
export struct RalPage {

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
              guide.to("yours");
            });

          Button('登录')
            .onClick(() => {
              nets.send(`a ${this.account} pw ${this.password} t lg`)
            });
        }
      }
    }
  }
}