import ComicStore from '../stores/ComicStore';
import Animate from '../utils/Animate';

export default class ComicScroller {

  static get LEFT() {
    return 'Comicscroller.LEFT';
  }

  static get RIGHT() {
    return 'Comicscroller.RIGHT';
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

    this._onTouchStart = this._onTouchStart.bind(this);
    this._onTouchMove = this._onTouchMove.bind(this);
    this._onTouchEnd = this._onTouchEnd.bind(this);

    this._pages = [];
    const comicStore = new ComicStore();
    comicStore.on(ComicStore.EVENT_UPDATE, () => {
      this._pages = comicStore.getPages();
    });
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

    return this._pages[currentIndex].pageId;
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

    const isAfterBounce = startScrollX < 0 || startScrollX > (this._pages.length - 1) * window.innerWidth;

    this._animation = new Animate({
      duration: isAfterBounce ? 240 : 600 * Math.sqrt(Math.abs(diffScrollX) / window.innerWidth),
      easing: Animate.Easing.easeInOut(3),
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

    this._isTouching = false;
    this._isDragging = false;
    this.moveTo(this.getNearPageId());
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
