import { ChatPage } from "../pages/chat";
import { RalPage } from "../pages/ral_page";
import { RegPage } from "../pages/reg_page";
import { WaitPage } from "../pages/wait"
import { Yours } from "../pages/yours";

import guide from "../view_model/navigator"

import syncer from "../view_model/syncer"

@Entry
@Component
struct Index {
  // @Provide("syn") syn: Syncer = new Syncer();
  @Builder
  The(name: string) {
    if      (name === "chat")   { ChatPage(); }
    else if (name === "ral")    { RalPage(); }
    else if (name === "reg")    { RegPage(); }
    else if (name === "yours")  { Yours(); }
    else if (name === "wait")   { WaitPage(); }
    else                        { WaitPage(); }
  }

  aboutToAppear(): void {
    guide.to("wait");
  }
  build() {
    Navigation(guide.The){
      Button("开始")
        .onClick(() => {
          guide.to("ral");
        })
    }
    .navDestination(this.The)
    .width("100%")
  }
}
