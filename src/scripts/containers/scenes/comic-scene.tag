<comic-scene>
  <div class="page-list" id="comic-page-list">
    <comic-page each="{page in this.pages}" data="{page}" />
  </div>
  <div if="{this.pages[this.pages.length - 1].nextPages.age != null}" onClick="{this.onClickAge}" class="button-age">あげ？({this.pages[this.pages.length - 1].nextPages.age})</div>
  <div if="{this.pages[this.pages.length - 1].nextPages.sage != null}" onClick="{this.onClickSage}" class="button-sage">さげ？({this.pages[this.pages.length - 1].nextPages.sage})</div>
  <div if="{this.pages[this.pages.length - 1].nextPages.next != null}" onClick="{this.onClickNext}" class="button-next">次へ({this.pages[this.pages.length - 1].nextPages.next})</div>
  <div if="{this.pages[this.pages.length - 1].nextPages.end != null}" onClick="{this.onClickEnd}" class="button-end">おしまい({this.pages[this.pages.length - 1].nextPages.end})</div>

  <script>
    import ComicAction from '../../actions/ComicAction';
    import ComicStore from '../../stores/ComicStore';
    import ComicScroller from '../../functions/ComicScroller';

    const scroller = new ComicScroller(this['comic-page-list'], window.innerWidth);
    scroller.enable();

    this.pages = [];

    this.onClickAge = () => {
      if (scroller.isScrolling()) {
        return;
      }
      ComicAction.age();
    };

    this.onClickSage = () => {
      if (scroller.isScrolling()) {
        return;
      }
      ComicAction.sage();
    };

    this.onClickNext = () => {
      if (scroller.isScrolling()) {
        return;
      }
      ComicAction.next();
    };

    this.onClickEnd = () => {
      if (scroller.isScrolling()) {
        return;
      }
      ComicAction.reset();
    };


    const comicStore = new ComicStore();
    comicStore.on(ComicStore.EVENT_RESET, () => {
      this.pages = [];
      scroller.resetScroll();
      this.update();
    });
    comicStore.on(ComicStore.EVENT_UPDATE, () => {
      this.pages = comicStore.getPages();
      resize();
      const lastPageId = scroller.getLastPageId();
      lastPageId && scroller.setTo(lastPageId);
      scroller.moveTo(this.pages[this.pages.length - 1].pageId);
      this.update();
    });

    window.addEventListener('resize', resize, false);

    const self = this;
    function resize() {
      scroller.setWidth(window.innerWidth);
      self['comic-page-list'].style.width = `${self.pages.length * window.innerWidth}px`;
    }
  </script>

  <style scoped>
    :scope {
      overflow: hidden;
      display: block;
      width: 100vw;
      height: 100vh;
      padding-bottom: 100px;
      box-sizing: border-box;
    }

    .page-list {
      height: 100%;
      font-size: 0;
    }
    .page-list::after {
      content: '';
      display: table;
      clear: both;
    }

    .button-age,
    .button-sage,
    .button-next,
    .button-end {
      position: absolute;
      z-index: 2;
      bottom: 0;
      width: 50vw;
      height: 100px;
      background: white;
      border: 2px solid gray;
      box-sizing: border-box;
      text-align: center;
      font-size: 16px;
      line-height: 96px;
    }
    .button-age {
      left: 0;
    }
    .button-sage {
      right: 0;
    }
    .button-next,
    .button-end {
      left: 0;
      right: 0;
      margin: 0 auto;
    }
  </style>
</comic-scene>
