<home-scene>
  <div class="header">
    <h1 class="header__title">あげさげコミック</h1>
    <div class="header__link-author" onClick="{this.gotoAuthor}"></div>
  </div>
  <div class="contents__wrapper">
    <div class="contents-scroller" id="scroller">
      <div class="contents start">
        <div class="contents__description-image"></div>
        <p class="contents__description-text">スマホを上げると、テンションの上がる展開に、<br>下げるとテンションの下がる展開に進む</p>
        <button class="contents__start-button" onClick="{this.gotoComic}">START</button>
        <p class="contents__caution">※音楽が流れます。マナーモードを切ってお楽しみ下さい。</p>
      </div>
      <div class="contents author">
        <author />
        <button class="contents__back-button" onClick="{this.gotoAuthor}">戻る</button>
      </div>
    </div>
  </div>
  <div class="footer">
    <div class="footer-inner">
      <div class="footer__share-title">SHARE</div>
      <ul class="footer__share">
        <li class="footer__share__item twitter"><a href="https://twitter.com/intent/tweet?url=http%3A%2F%2Ffujiimary.com%2Fagesagecomic&text=%E3%81%82%E3%81%92%E3%81%95%E3%81%92%E3%82%B3%E3%83%9F%E3%83%83%E3%82%AF" target="_blank" class="header__share__twitter">Twitterでシェアする</a></li>
        <li class="footer__share__item facebook"><a href="https://www.facebook.com/sharer/sharer.php?u=http%3A%2F%2Ffujiimary.com%2Fagesagecomic" target="_blank"
                                                    class="header__share__facebook">Facebookでシェアする</a></li>
        <li class="footer__share__item line"><a href="http://line.me/R/msg/text/?http%3A%2F%2Ffujiimary.com%2Fagesagecomic" target="_blank"
                                                class="header__share__facebook">LINEでシェアする</a></li>
      </ul>
    </div>
  </div>

  <script>
    import ShowEvent from '../../mixins/ShowEvent';
    import SceneAction from '../../actions/SceneAction';
    import Animate from '../../utils/Animate';

    let isAuthor = false;
    let isAnimate = false;

    this.mixin(ShowEvent);
    this.on('onShow', () => {
      isAuthor = false;
      isAnimate = false;
      new Animate({
        duration: 480,
        easing: Animate.Easing.easeOut(3),
        onProgress: progress => {
          this.root.style.opacity = progress;
        }
      }).start();
    });

    this.gotoComic = () => {
      if (isAnimate) {
        return;
      }
      isAnimate = true;

      new Animate({
        duration: 240,
        easing: Animate.Easing.easeOut(3),
        onProgress: progress => {
          this.root.style.opacity = (1 - progress);
        },
        onComplete: () => {
          isAnimate = false;
          SceneAction.gotoComic();
        }
      }).start();
    };

    this.gotoAuthor = () => {
      if (isAnimate) {
        return;
      }

      isAnimate = true;
      new Animate({
        duration: 480,
        easing: Animate.Easing.easeOut(3),
        onProgress: progress => {
          const x = (isAuthor ? (1 - progress) : progress) * 100;
          this.scroller.style.transform = `translate(${-x}%, 0)`;
        },
        onComplete: () => {
          isAnimate = false;
          isAuthor = !isAuthor;
        }
      }).start();
    };
  </script>

  <style scoped>
    :scope {
      display: block;
      width: 100%;
      height: 100%;
      background: #fff;
    }

    .header {
      position: fixed;
      z-index: 2;
      top: 0;
      left: 0;
      right: 0;
      background: url(assets/images/home-background-top.png) 50% 0 no-repeat;
      background-size: 100% auto;
      padding-top: 3.75%;
    }
    .header__title {
      width: 65.16%;
      height: 0;
      padding-top: 28.28%;
      margin: 0 auto;
      background: url(assets/images/home-logo.png) 50% 50% no-repeat;
      background-size: contain;
      font-size: 0;
      overflow: hidden;
    }
    .header__link-author {
      position: absolute;
      top: 0;
      right: 0;
      width: 14.22%;
      height: 0;
      padding-top: 26.56%;
      background: url(assets/images/home-monkey.png) 100% 0 no-repeat;
      background-size: contain;
      font-size: 0;
      overflow: hidden;
    }

    .footer {
      position: fixed;
      z-index: 2;
      bottom: 0;
      left: 0;
      right: 0;
      height: 0;
      padding-top: 17.19%;
      background: url(assets/images/home-background-bottom.png) 50% 100% no-repeat;
      background-size: 100% auto;
    }
    .footer-inner {
      position: absolute;
      left: 0;
      right: 0;
      bottom: 0;
      width: 88%;
      height: 0;
      padding-top: 9.38%;
      margin: 0 auto;
    }
    .footer__share-title {
      position: absolute;
      top: 0;
      left: 0;
      letter-spacing: 0.14em;
      line-height: 9.38vw;
      font-size: 4.06vw;
      color: #fff;
    }
    .footer__share {
      position: absolute;
      top: 0;
      right: 0;
      width: 100%;
      height: 100%;
      margin: 0 auto;
      text-align: right;
      font-size: 0;
    }
    .footer__share__item {
      display: inline-block;
      width: 20.31vw;
      height: 100%;
      border-radius: 2.5vw 2.5vw 0 0;
      background: #ffbf64 50% 50% no-repeat;
    }
    .footer__share__item.twitter {
      background-image: url(assets/images/icon-twitter.png);
      background-size: 22%;
    }
    .footer__share__item.facebook {
      background-image: url(assets/images/icon-facebook.png);
      background-size: 10%;
      margin: 0 3.13vw;
    }
    .footer__share__item.line {
      background-image: url(assets/images/icon-line.png);
      background-size: 24%;
    }

    .contents__wrapper {
      position: relative;
      z-index: 1;
      width: 100%;
      height: 100%;
      overflow: hidden;
    }
    .contents {
      position: absolute;
      width: 100%;
      top: 50%;
      transform: translate(0, -50%);
    }
    .contents.start {
      margin-top: 7.34vw;
    }
    .contents.author {
      margin-top: 4.28vw;
      transform: translate(100%, -50%);
    }
    .contents-scroller {
      width: 100%;
      height: 100%;
    }
    .contents__description-image {
      width: 53.75%;
      height: 0;
      padding-top: 43.44%;
      margin: 0 auto;
      background: url(assets/images/home-description-image.png) 50% 50% no-repeat;
      background-size: contain;
    }
    .contents__description-text {
      margin: 1em 0 0;
      text-align: center;
      font-size: 4.06vw;
      color: #363129;
    }
    .contents__start-button {
      display: block;
      width: 90.62%;
      height: 14.06vw;
      background: #ff9054;
      margin: 1em auto 0;
      border: 0;
      border-radius: 7.03vw;
      text-align: center;
      line-height: 14.06%;
      font-size: 5.62vw;
      color: #fff;
    }
    .contents__caution {
      margin: 1em 0 0;
      text-align: center;
      font-size: 3.13vw;
      color: #363129;
      opacity: 0.8;
    }

    .contents__back-button {
      display: block;
      position: relative;
      width: 46.88%;
      height: 14.06vw;
      background: #ffe464;
      margin: 1.7em auto 0;
      border: 0;
      border-radius: 7.03vw;
      text-align: center;
      line-height: 14.06%;
      font-size: 4.38vw;
      color: #291d1d;
    }
    .contents__back-button::before,
    .contents__back-button::after {
      content: '';
      display: block;
      position: absolute;
      top: 50%;
      left: 7.03vw;
      width: 0.63vw;
      height: 3.59vw;
      background: #fff;
    }
    .contents__back-button::before {
      transform-origin: 0 100%;
      transform: translate(0, -100%) rotate(45deg);
    }
    .contents__back-button::after {
      transform-origin: 0 0;
      transform: translate(0, 0) rotate(-45deg);
    }
  </style>
</home-scene>
