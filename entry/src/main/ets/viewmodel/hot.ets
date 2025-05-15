
import config from "../model/config"
import group from "../model/group"
import one from "../model/one"
import image from "../model/image"

class Hot {
  The_cfg: config = new config()
  The_grp: group[] = []
  The_one: one[] = []
  The_img: image[] = []
  The_hot: string[] = []

  constructor() {

  }
}

export default new Hot()