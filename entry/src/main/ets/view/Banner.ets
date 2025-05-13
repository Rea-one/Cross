import { BannerClass } from '../model/BannerClass';
import { bufferToString } from '../util/BufferUtil';

@Component
export struct Banner {
  @State bannerList: Array<BannerClass> = [];

  aboutToAppear(): void {
    this.getBannerDataFromJSON();
  }

  getBannerDataFromJSON() {
    getContext(this).resourceManager.getRawFileContent('BannerData.json').then(value => {
      // 转换为字符串
      let res: string =  bufferToString(value);
      // 解析为数据结构
      this.bannerList = JSON.parse(bufferToString(value)) as BannerClass[];
    })
  }

  build() {
    // ...
  }
}