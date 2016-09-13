let instance;
export default class ComicStore {

  static get EVENT_UPDATE() {
    return 'ComicStore.EVENT_UPDATE';
  }

  static get EVENT_RESET() {
    return 'ComicStore.EVENT_RESET';
  }

  constructor() {
    if (instance) {
      return instance;
    }
    instance = this;
    riot.observable(this);

    this._pages = [];

    return this;
  }

  getCurrentPage() {
    return this._pages[this._pages.length - 1];
  }

  getPages() {
    return this._pages;
  }

  addPage(page) {
    this._pages.push(page);
    this.trigger(ComicStore.EVENT_UPDATE);
  }

  reset() {
    this._pages = [];
    this.trigger(ComicStore.EVENT_RESET);
  }

}
