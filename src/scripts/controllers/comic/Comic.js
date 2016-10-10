import comicData from '../../comic.json';
import Preload from '../../utils/Preload';

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

  static preloadNextPages(page) {
    page.nextPages.age && Preload.image(`comic/${Comic.getPageById(page.nextPages.age).image}`);
    page.nextPages.sage && Preload.image(`comic/${Comic.getPageById(page.nextPages.sage).image}`);
    page.nextPages.next && Preload.image(`comic/${Comic.getPageById(page.nextPages.next).image}`);
  }

}
