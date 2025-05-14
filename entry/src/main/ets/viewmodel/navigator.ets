

class PageStack {
  The: NavPathStack = new NavPathStack();

  to(val: string) {
    this.The.pushPathByName(val, "");
  }
}

export default new PageStack()