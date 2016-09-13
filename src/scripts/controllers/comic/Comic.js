import comicData from '../../comic.json';

export default class Comic {

  static getOpeningPage() {
    return Comic.getPageById('opening01');
  }

  static getAgePage(page) {
    return Comic.getPageById(page.nextPages.age);
  }

  static getSagePage(page) {
    return Comic.getPageById(page.nextPages.sage);
  }

  static getNextPage(page) {
    return Comic.getPageById(page.nextPages.next);
  }

  static getPageById(pageId) {
    return comicData.find(data => data.pageId === pageId) || null;
  }

}
