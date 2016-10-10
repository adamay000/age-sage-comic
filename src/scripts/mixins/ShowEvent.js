export default {
  init() {
    let isMounted = false;
    let isShow = false;
    this.on('mount', () => {
      isShow = this.opts.if;
      isMounted = true;
      this.trigger(isShow ? 'onShow' : 'onHide');
    });
    this.on('update', () => {
      if (!isMounted || isShow === this.opts.if) {
        return;
      }
      isShow = this.opts.if;
      this.trigger(isShow ? 'onShow' : 'onHide');
    });
  }
};
