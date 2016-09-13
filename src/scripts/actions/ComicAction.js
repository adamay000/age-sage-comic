import ComicStore from '../stores/ComicStore';
import Comic from '../controllers/comic/Comic';

export default class ComicAction {

  static reset() {
    new ComicStore().reset();
    new ComicStore().addPage(Comic.getOpeningPage());
  }

  static age() {
    const comicStore = new ComicStore();
    const currentPage = comicStore.getCurrentPage();
    const nextPage = Comic.getAgePage(currentPage);
    if (nextPage) {
      comicStore.addPage(nextPage);
      return true;
    }

    return false;
  }

  static sage() {
    const comicStore = new ComicStore();
    const currentPage = comicStore.getCurrentPage();
    const nextPage = Comic.getSagePage(currentPage);
    if (nextPage) {
      comicStore.addPage(nextPage);
      return true;
    }

    return false;
  }

  static next() {
    const comicStore = new ComicStore();
    const currentPage = comicStore.getCurrentPage();
    const nextPage = Comic.getNextPage(currentPage);
    if (nextPage) {
      comicStore.addPage(nextPage);
      return true;
    }

    return false;
  }

}
