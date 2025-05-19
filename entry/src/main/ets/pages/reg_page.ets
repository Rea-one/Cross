import nets from "../view_model/nets"
import guide from "../view_model/navigator"
import { promptAction } from "@kit.ArkUI";

@Component
export struct RegPage {
  @State account: string = '';
  @State cpassword: string = '';
  @State password: string = '';
  @State reject: boolean = true;

  build() {
    NavDestination() {
      Column() {
        Row() {
          Text('账号')
          TextInput({ placeholder: '请输入账号' })
            .onChange((value: string) => {
              this.account = value;
            })
        }
        .width("90%")

        Row() {
          Text('密码')
          TextInput({ placeholder: '请输入密码' })
            .onChange((value: string) => {
              this.cpassword = value;
            })
            .type(InputType.Password);
        }
        .width("90%")

        Row() {
          Text('确认密码')
          TextInput({ placeholder: '请输入密码' })
            .onChange((value: string) => {
              if (value == this.cpassword) {
                this.reject = false;
              } else {
                this.reject = true;
              }
            })
            .type(InputType.Password)
        }
        .width("90%")

        Button('确认')
          .onClick(() => {
            if (!this.reject) {
              this.password = this.cpassword;
              nets.send(`a ${this.account} pw ${this.password} t rg`);
              guide.back();
            } else {
              promptAction.showToast({
                message: "输入密码不一致"
              })
            }
            this.password = ''
            this.cpassword = ''
          })
      }
    }
  }
}