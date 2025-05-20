
// 对于导航的封装，可用 相对于文档中的方法，耦合程度更低
class PageStack {
  The: NavPathStack = new NavPathStack();

  to(val: string) {
    this.The.pushPathByName(val, "");
  }
  back() {
    this.The.pop()
  }
  clear() {
    this.The.clear();
  }
}

export default new PageStack()