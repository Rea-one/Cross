import pageStack from "../viewmodel/navigator"
import pageMap from "../viewmodel/page_map"
import nets from "../viewmodel/nets"
import syncer from "../viewmodel/syncer"

@Entry
@Component
struct Index {

  build() {
    Navigation(pageStack.The){

    }
    .navDestination(pageMap.The)
  }
}