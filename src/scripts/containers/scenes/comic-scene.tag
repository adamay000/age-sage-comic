<comic-scene>
  <div class="background">
    <div class="background__base" id="background-base"></div>
    <div class="background__change" id="background-change"></div>
  </div>
  <div class="page-list" id="comic-page-list">
    <comic-page each="{page in this.pages}" data="{page}" />
  </div>
  <comic-popup />
  <div class="howto" id="howto" onclick="{this.closeHowTo}">
    <div class="howto__image"></div>
    <div class="howto__close"></div>
  </div>
  <div if="{this.pages.length && this.pages[this.pages.length - 1].nextPages.age != null}" onClick="{this.tryAge}" class="button-age">あげ？</div>
  <div if="{this.pages.length && this.pages[this.pages.length - 1].nextPages.sage != null}" onClick="{this.trySage}" class="button-sage">さげ？</div>
  <div if="{this.pages.length && this.pages[this.pages.length - 1].nextPages.next != null && this.pages[this.pages.length - 1].pageType === 'age'}" onClick="{this.tryNext}" class="button-next">あげエンディングへ</div>
  <div if="{this.pages.length && this.pages[this.pages.length - 1].nextPages.next != null && this.pages[this.pages.length - 1].pageType === 'sage'}" onClick="{this.tryNext}" class="button-next">さげエンディングへ</div>
  <div if="{this.pages.length && this.pages[this.pages.length - 1].nextPages.end != null}" onClick="{this.tryEnd}"
       class="button-end">おしまい</div>
  <div
    if="{this.pages.length && (this.pages[this.pages.length - 1].nextPages.age != null || this.pages[this.pages.length - 1].nextPages.sage != null)}" class="shake-symbol" id="shake-symbol"></div>

  <script>
    import ShowEvent from '../../mixins/ShowEvent';
    import SceneAction from '../../actions/SceneAction';
    import ComicAction from '../../actions/ComicAction';
    import ComicStore from '../../stores/ComicStore';
    import Comic from '../../controllers/comic/Comic';
    import ComicScroller from '../../functions/ComicScroller';
    import DeviceMotionHandler from '../../functions/DeviceMotionHandler';
    import BackgroundMusic from '../../functions/BackgroundMusic';
    import Animate from '../../utils/Animate';

    const backgroundMusic = new BackgroundMusic();

    const scroller = new ComicScroller(this['comic-page-list'], window.innerWidth);
    scroller.on(ComicScroller.EVENT_SCROLL, () => {
      const sidePages = scroller.getSidePages();

      this['background-base'].style.backgroundImage = getBackgroundImage(sidePages.base);

      if (!sidePages.change) {
        this['background-change'].style.opacity = 0;
        return;
      }

      this['background-change'].style.backgroundImage = getBackgroundImage(sidePages.change);
      this['background-change'].style.opacity = 1 - sidePages.baseRatio;
    });
    function getBackgroundImage(pageType) {
      switch (pageType) {
        case 'age':
          return 'url(assets/images/comic-bg-age.png)';
          break;
        case 'sage':
          return 'url(assets/images/comic-bg-sage.png)';
          break;
        default:
          return 'url(assets/images/comic-bg-neutral.png)';
      }
    }

    let isEnabled = false;
    function enable() {
      isEnabled = true;
      scroller.enable();
      shakeRequest();
    }
    function disable() {
      isEnabled = false;
      scroller.disable();
      removeShakeRequest();
    }

    let isShowHowTo = false;

    this.mixin(ShowEvent);
    this.on('onShow', () => {
      disable();

      this.tags['comic-popup'].reset();
      backgroundMusic.seekZero();
      new DeviceMotionHandler().hasDeviceMotionEvent() || this.howto.classList.add('no-device-motion');

      isShowHowTo = false;
      this.howto.style.opacity = 0;
      this.howto.style.display = 'block';
      new Animate({
        duration: 480,
        easing: Animate.Easing.easeOut(3),
        onProgress: progress => {
          this.root.style.opacity = progress;
          this.howto.style.opacity = progress;
          this.howto.style.marginTop = `${(1 - progress) * -20}px`;
        },
        onComplete: () => {
          isShowHowTo = true;
        }
      }).start();
    });

    this.closeHowTo = () => {
      if (!isShowHowTo) {
        return;
      }
      isShowHowTo = false;

      new Animate({
        duration: 480,
        easing: Animate.Easing.easeOut(3),
        onProgress: progress => {
          this.howto.style.opacity = 1 - progress;
          this.howto.style.marginTop = `${progress * -20}px`;
        },
        onComplete: () => {
          this.howto.style.display = 'none';
          enable();
        }
      }).start();
    };

    this.pages = [];

    this.tryAge = () => {
      if (scroller.isScrolling() || !isEnabled) {
        return;
      }
      ComicAction.age();
      backgroundMusic.playAge();
      shakeRequest();

      this.tags['comic-popup'].age();
    };

    this.trySage = () => {
      if (scroller.isScrolling() || !isEnabled) {
        return;
      }
      ComicAction.sage();
      backgroundMusic.playSage();
      shakeRequest();

      this.tags['comic-popup'].sage();
    };

    this.tryNext = () => {
      if (scroller.isScrolling() || !isEnabled) {
        return;
      }
      shakeRequest();

      ComicAction.next();
    };

    this.tryEnd = () => {
      if (scroller.isScrolling() || !isEnabled) {
        return;
      }

      disable();

      new Animate({
        duration: 240,
        easing: Animate.Easing.easeOut(3),
        onProgress: progress => {
          this.root.style.opacity = (1 - progress);
        },
        onComplete: () => {
          SceneAction.gotoEnd();
          ComicAction.reset();
        }
      }).start();
    };

    const comicStore = new ComicStore();
//    comicStore.on(ComicStore.EVENT_RESET, () => {});
    comicStore.on(ComicStore.EVENT_UPDATE, () => {
      this.pages = comicStore.getPages();
      resize();
      if (!this.pages.length) {
        this.update();
        return;
      }

      Comic.preloadNextPages(this.pages[this.pages.length - 1]);

      const lastPageId = scroller.getLastPageId();
      lastPageId && scroller.setTo(lastPageId);
      lastPageId || scroller.setTo(this.pages[0].pageId);
      scroller.moveTo(this.pages[this.pages.length - 1].pageId);
      this.update();
    });

    const deviceMotionHandler = new DeviceMotionHandler();
    deviceMotionHandler.enable();
    deviceMotionHandler.on(DeviceMotionHandler.AGE, () => {
      if (isShowHowTo) {
        this.closeHowTo();
        return;
      }
      if (this.pages[this.pages.length - 1].nextPages.age) {
        this.tryAge();
        return;
      }
      if (this.pages[this.pages.length - 1].nextPages.next) {
        this.tryNext();
      }
    });
    deviceMotionHandler.on(DeviceMotionHandler.SAGE, () => {
      if (isShowHowTo) {
        this.closeHowTo();
        return;
      }
      if (this.pages[this.pages.length - 1].nextPages.sage) {
        this.trySage();
        return;
      }
      if (this.pages[this.pages.length - 1].nextPages.next) {
        this.tryNext();
      }
    });

    window.addEventListener('resize', resize, false);

    function resize() {
      scroller.setWidth(window.innerWidth);
      self['comic-page-list'].style.width = `${self.pages.length * window.innerWidth}px`;
    }

    let shakeRequestTimer = null;
    const self = this;
    function shakeRequest() {
      clearTimeout(shakeRequestTimer);
      shakeRequestTimer = setTimeout(shakeRequestCallback, 10 * 1000);
    }
    function removeShakeRequest() {
      clearTimeout(shakeRequestTimer);
    }
    function shakeRequestCallback() {
      self['shake-symbol'].classList.add('move');
      setTimeout(function() {
        self['shake-symbol'].classList.remove('move');
      }, 3000);
      shakeRequest();
    }
  </script>

  <style scoped>
    :scope {
      overflow: hidden;
      display: block;
      position: fixed;
      top: 0;
      left: 0;
      right: 0;
      bottom: 0;
    }

    .background {
      position: absolute;
      top: 0;
      left: 0;
      right: 0;
      bottom: 0;
    }
    .background__change {
      position: absolute;
      top: 0;
      left: 0;
      right: 0;
      bottom: 0;
    }
    .background__base {
      width: 100%;
      height: 100%;
      background: url(assets/images/comic-bg-neutral.png);
    }

    .page-list {
      position: absolute;
      top: 0;
      bottom: 12.50vw;
      font-size: 0;
    }
    .page-list::after {
      content: '';
      display: table;
      clear: both;
    }

    .howto {
      position: absolute;
      z-index: 9999;
      top: -20px;
      left: 0;
      right: 0;
      bottom: -20px;
      background: rgba(0, 0, 0, 0.5);
    }
    .howto__image {
      width: 66.41vw;
      height: 66.41vw;
      position: absolute;
      top: 50%;
      left: 0;
      right: 0;
      margin: 0 auto;
      transform: translate(0, -50%);
      background: url(assets/images/comic-howto.png) 50% 50% no-repeat;
      background-size: contain;
    }
    .howto.no-device-motion .howto__image {
      background-image: url(assets/images/comic-howto-no-device-motion.png);
    }
    .howto__close {
      position: absolute;
      top: 50%;
      right: 22.92vw;
      margin-top: -41.88vw;
      transform: translate(0, -50%);
    }
    .howto__close::before,
    .howto__close::after {
      position: absolute;
      top: 0;
      content: '';
      display: block;
      background: #e6e5eb;
      width: 1.34vw;
      height: 7.68vw;
    }
    .howto__close::before {
      transform: rotate(45deg);
    }
    .howto__close::after {
      transform: rotate(-45deg);
    }

    .button-age,
    .button-sage,
    .button-next,
    .button-end {
      position: absolute;
      z-index: 2;
      bottom: 0;
      width: 40.63vw;
      height: 12.50vw;
      background: #ffe464 50% 50% no-repeat;
      border-top: 1.09vw solid #ffffff;
      border-left: 1.09vw solid #ffffff;
      border-right: 1.09vw solid #ffffff;
      border-radius: 4.06vw 4.06vw 0 0;
      box-sizing: border-box;
    }
    .button-age {
      left: 3.13vw;
      background-image: url(assets/images/comic-button-age.png);
      background-size: 25.31vw 7.50vw;
      overflow: hidden;
      text-indent: 100%;
      white-space: nowrap;
    }
    .button-sage {
      right: 3.13vw;
      background-image: url(assets/images/comic-button-sage.png);
      background-size: 25.00vw 6.41vw;
      overflow: hidden;
      text-indent: 100%;
      white-space: nowrap;
    }
    .button-next,
    .button-end {
      width: 74vw;
      left: 0;
      right: 0;
      margin: 0 auto;
      text-align: center;
      line-height: 11.41vw;
      font-size: 4.40vw;
      font-weight: bold;
    }
    .button-next::before,
    .button-next::after,
    .button-end::before,
    .button-end::after {
      content: '';
      display: block;
      position: absolute;
      top: 50%;
      left: 4.69vw;
      width: 0.63vw;
      height: 3.59vw;
      background: #fff;
    }
    .button-next::before,
    .button-end::before {
      transform-origin: 0 100%;
      transform: translate(0, -100%) rotate(45deg);
    }
    .button-next::after,
    .button-end::after {
      transform-origin: 0 0;
      transform: translate(0, 0) rotate(-45deg);
    }
    .shake-symbol {
      pointer-events: none;
      position: absolute;
      z-index: 3;
      bottom: -2vw;
      left: 0;
      right: 6vw;
      margin: 0 auto;
      width: 28.28vw;
      height: 32.34vw;
      background: url(assets/images/comic-hand-symbol-01.png) 50% 50% / contain no-repeat;
    }
    .shake-symbol.move {
      animation: shake 500ms 2 linear;
    }
    @keyframes shake {
      0% {
        background-image: url(assets/images/comic-hand-symbol-01.png);
      }
      20% {
        background-image: url(assets/images/comic-hand-symbol-02.png);
      }
      40% {
        background-image: url(assets/images/comic-hand-symbol-03.png);
      }
      60% {
        background-image: url(assets/images/comic-hand-symbol-02.png);
      }
      80%,
      100% {
        background-image: url(assets/images/comic-hand-symbol-01.png);
      }
    }
  </style>
</comic-scene>
