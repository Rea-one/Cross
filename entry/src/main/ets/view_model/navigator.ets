

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