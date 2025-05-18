import { ChatPage } from "../pages/chat";
import { RalPage } from "../pages/ral_page";
import { RegPage } from "../pages/reg_page";
import { WaitPage } from "../pages/wait"
import { Yours } from "../pages/yours";
import { UIAbility } from "@kit.AbilityKit";


class PageMap extends UIAbility {
  The(name: string) {
    if      (name == "chat")  { ChatPage(); }
    else if (name == "ral")   { RalPage(); }
    else if (name == "reg")   { RegPage(); }
    else if (name == "yours") { Yours(); }
    else if (name == "wait")  { WaitPage(); }
    else                      { WaitPage(); }
  }
}


export default new PageMap()