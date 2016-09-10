export default {
  init() {
    this.on('mount', () => {
      this._isShow = this.opts.isShow;
    });
    this.on('update', () => {
      if (this._isShow === this.opts.isShow) {
        return;
      }
      this.trigger(this.opts.isShow ? 'onShowBefore' : 'onHideBefore');
    });
    this.on('updated', () => {
      if (this._isShow === this.opts.isShow) {
        return;
      }
      this.trigger(this.opts.isShow ? 'onShowAfter' : 'onHideAfter');
      this._isShow = this.opts.isShow;
    });
  }
};
