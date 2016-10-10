import ComicStore from '../stores/ComicStore';
import Animate from '../utils/Animate';

export default class ComicScroller {

  static get LEFT() {
    return 'Comicscroller.LEFT';
  }

  static get RIGHT() {
    return 'Comicscroller.RIGHT';
  }

  static get EVENT_SCROLL() {
    return 'ComicScroller.EVENT_SCROLL';
  }

  constructor($wrapper, width) {
    this.$wrapper = $wrapper;
    this._width = width;
    this._animation = { stop: () => null };

    this._lastPageId = null;
    this._scrollX = 0;
    this._isScrolling = false;
    this._isEnabled = false;

    this._isTouching = false;
    this._isDragging = false;
    this._startPoint = null;
    this._lastPoint = null;
    this._lastMoveX = 0;

    this._onTouchStart = this._onTouchStart.bind(this);
    this._onTouchMove = this._onTouchMove.bind(this);
    this._onTouchEnd = this._onTouchEnd.bind(this);

    this._pages = [];
    const comicStore = new ComicStore();
    comicStore.on(ComicStore.EVENT_UPDATE, () => {
      this._pages = comicStore.getPages();
    });

    riot.observable(this);
  }

  enable() {
    if (this._isEnabled) {
      return;
    }
    this._isEnabled = true;
    this._isTouching = false;
    this._isDragging = false;
    this._startPoint = null;
    this._lastPoint = null;
    this._lastMoveX = 0;

    this.$wrapper.addEventListener('touchstart', this._onTouchStart, false);
    this.$wrapper.addEventListener('touchmove', this._onTouchMove, false);
    this.$wrapper.addEventListener('touchend', this._onTouchEnd, false);
  }

  disable() {
    if (!this._isEnabled) {
      return;
    }
    this._isEnabled = false;
    this._isTouching = false;
    this._isDragging = false;
    this._startPoint = null;
    this._lastPoint = null;
    this._lastMoveX = 0;

    this.$wrapper.removeEventListener('touchstart', this._onTouchStart);
    this.$wrapper.removeEventListener('touchmove', this._onTouchMove);
    this.$wrapper.removeEventListener('touchend', this._onTouchEnd);
  }

  isScrolling() {
    return this._isScrolling;
  }

  setWidth(width) {
    this._width = width;
  }

  getLastPageId() {
    return this._lastPageId;
  }

  getNearPageId(direction) {
    let currentIndex = this._pages.length - Math.round(this._scrollX / window.innerWidth) - 1;
    direction === ComicScroller.LEFT && currentIndex++;
    direction === ComicScroller.RIGHT && currentIndex--;
    currentIndex < 0 && (currentIndex = 0);
    currentIndex >= this._pages.length && (currentIndex = this._pages.length - 1);

    return this._pages[currentIndex] ? this._pages[currentIndex].pageId : null;
  }

  getSidePages() {
    const result = {
      baseRatio: 1,
      base: null,
      change: null
    };

    if (!this._pages.length) {
      return result;
    }

    let currentIndex = this._pages.length - Math.round(this._scrollX / window.innerWidth) - 1;
    currentIndex < 0 && (currentIndex = 0);
    currentIndex >= this._pages.length && (currentIndex = this._pages.length - 1);

    if (Math.abs(this._scrollX % window.innerWidth) < 0.001) {
      result.base = this._pages[currentIndex].pageType;
      return result;
    }

    let leftPageIndex = this._pages.length - Math.floor(this._scrollX / window.innerWidth) - 1;
    leftPageIndex < 0 && (leftPageIndex = 0);
    leftPageIndex >= this._pages.length && (leftPageIndex = this._pages.length - 1);
    let rightPageIndex = this._pages.length - Math.ceil(this._scrollX / window.innerWidth) - 1;
    rightPageIndex < 0 && (rightPageIndex = 0);
    rightPageIndex >= this._pages.length && (rightPageIndex = this._pages.length - 1);

    if (leftPageIndex === rightPageIndex) {
      result.base = this._pages[leftPageIndex].pageType;
      return result;
    }

    const leftDiff = (this._scrollX / window.innerWidth) - (this._scrollX / window.innerWidth | 0);

    if (leftDiff < 0.5) {
      result.base = this._pages[leftPageIndex].pageType;
      result.change = this._pages[rightPageIndex].pageType;
      result.baseRatio = 1 - leftDiff;
      return result;
    }

    result.base = this._pages[rightPageIndex].pageType;
    result.change = this._pages[leftPageIndex].pageType;
    result.baseRatio = leftDiff;
    return result;
  }

  resetScroll() {
    this._lastPageId = null;
    this._scroll(0);
  }

  moveTo(pageId) {
    this._animation.stop();
    this._isScrolling = true;

    const startScrollX = this._scrollX;
    const endScrollX = this._getXByPageId(pageId);
    const diffScrollX = (endScrollX - startScrollX);

    if (diffScrollX === 0) {
      this._isScrolling = false;
      return;
    }

    const isAfterBounce = startScrollX < 0 || startScrollX > (this._pages.length - 1) * window.innerWidth;

    this._animation = new Animate({
      duration: isAfterBounce ? 240 : 600 * Math.sqrt(Math.abs(diffScrollX) / window.innerWidth),
      easing: Animate.Easing.easeOut(3),
      onProgress: progress => {
        this._scroll(startScrollX + (diffScrollX * progress));
        this._lastPageId = pageId;
      },
      onComplete: () => {
        this._isScrolling = false;
      }
    });
    this._animation.start();
  }

  setTo(pageId) {
    this._animation.stop();
    this._lastPageId = pageId;

    const scrollX = this._getXByPageId(pageId);
    this._scroll(scrollX);
  }

  _scroll(scrollX) {
    this._scrollX = scrollX;
    if (scrollX < 0) {
      scrollX = -Math.sqrt(-scrollX);
    }
    const maxScrollX = (this._pages.length - 1) * window.innerWidth;
    if (scrollX > maxScrollX) {
      scrollX = maxScrollX + Math.sqrt(scrollX - ((this._pages.length - 1) * window.innerWidth));
    }

    this.$wrapper.style.transform = `translate(${-scrollX}px, 0) translate3d(0, 0, 0)`;
    this.$wrapper.style['-webkit-transform'] = `translate(${-scrollX}px, 0) translate3d(0, 0, 0)`;

    this.trigger(ComicScroller.EVENT_SCROLL);
  }

  _getXByPageId(pageId) {
    const pageNumber = this._pages.findIndex(page => page.pageId === pageId);
    return (this._pages.length - pageNumber - 1) * this._width;
  }

  _onTouchStart(event) {
    if (this._isTouching) {
      return;
    }
    this._isTouching = true;
    this._isDragging = false;

    this._animation.stop();
    this._isScrolling = true;

    this._startPoint = getPointFromEvent(event);
  }

  _onTouchMove(event) {
    if (!this._isTouching) {
      return;
    }
    const point = getPointFromEvent(event);

    if (!this._isDragging) {
      if (getDistance(point, this._startPoint) > 5) {
        this._isDragging = true;
      }
      this._lastPoint = point;
      return;
    }

    const movedX = point.x - this._lastPoint.x;
    this._scroll(this._scrollX - movedX);
    this._lastMoveX = movedX;

    this._lastPoint = point;
  }

  _onTouchEnd(event) {
    if (!this._isTouching) {
      return;
    }
    const point = getPointFromEvent(event);

    if (!this._isDragging) {
      if (point.x < window.innerWidth / 2) {
        this.moveTo(this.getNearPageId(ComicScroller.LEFT));
        return;
      }
      this.moveTo(this.getNearPageId(ComicScroller.RIGHT));
      return;
    }

    if (this._lastMoveX > 4) {
      this.moveTo(this.getNearPageId(ComicScroller.LEFT));
    } else if (this._lastMoveX < -4) {
      this.moveTo(this.getNearPageId(ComicScroller.RIGHT));
    } else {
      this.moveTo(this.getNearPageId());
    }

    this._isTouching = false;
    this._isDragging = false;
  }

}

function getPointFromEvent(event) {
  const touch = event.changedTouches[0];
  return {
    x: touch.clientX,
    y: touch.clientY
  };
}

function getDistance(point1, point2) {
  return Math.sqrt(((point1.x - point2.x) ** 2) + ((point1.y - point2.y) ** 2));
}
