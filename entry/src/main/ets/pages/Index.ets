import pageStack from "../viewmodel/navigator"
import pageMap from "../viewmodel/page_map"
import nets from "../viewmodel/nets"

@Entry
@Component
struct Index {
  build() {
    Navigation(pageStack.The){

    }
    .navDestination(pageMap.The)
  }
}