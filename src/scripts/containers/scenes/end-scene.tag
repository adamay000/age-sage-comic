<end-scene>
  <div class="contents">
    <div class="contents__thanks"></div>
    <div class="contents__title">SHARE</div>
    <ul class="contents__share">
      <li class="contents__share__item twitter">Twitter</li>
      <li class="contents__share__item facebook">Facebook</li>
      <li class="contents__share__item line">LINE</li>
    </ul>
    <div class="contents__title">CREDIT</div>
    <author />
  </div>
  <div class="button-top" onClick="{this.gotoHome}">TOPに戻る</div>

  <script>
    import ShowEvent from '../../mixins/ShowEvent';
    import SceneAction from '../../actions/SceneAction';
    import BackgroundMusic from '../../functions/BackgroundMusic';
    import Animate from '../../utils/Animate';

    let isAnimate = false;

    this.mixin(ShowEvent);
    this.on('onShow', () => {
      isAnimate = false;
      new Animate({
        duration: 480,
        easing: Animate.Easing.easeOut(3),
        onProgress: progress => {
          this.root.style.opacity = progress;
        }
      }).start();
    });

    this.gotoHome = () => {
      if (isAnimate) {
        return;
      }
      isAnimate = true;

      new BackgroundMusic().stop();
      new Animate({
        duration: 240,
        easing: Animate.Easing.easeOut(3),
        onProgress: progress => {
          this.root.style.opacity = (1 - progress);
        },
        onComplete: () => {
          isAnimate = false;
          SceneAction.gotoHome();
        }
      }).start();
    };
  </script>

  <style scoped>
    :scope {
      display: block;
      width: 100%;
      background: url(assets/images/comic-bg-neutral.png) 0 0 repeat;
      padding: 7.81vw;
      box-sizing: border-box;
      position: relative;
      overflow-x: hidden;
    }

    .contents {
      background: #ffffff;
      border-radius: 6.25vw;
      padding-top: 65vw;
      padding-bottom: 23.44vw;
    }
    .contents__thanks {
      position: absolute;
      top: 12vw;
      left: 50%;
      transform: translate(-50%, 0);
      margin-left: 2vw;
      width: 104vw;
      height: 62.50vw;
      background: url(assets/images/end-thanks.png) 50% 50% / contain no-repeat;
    }
    .contents__title {
      margin-top: 10.94vw;
      text-align: center;
      letter-spacing: 0.5vw;
      font-size: 4.06vw;
    }

    .contents__share {
      display: block;
      margin: 0;
      padding: 0;
      font-family: 'ヒラギノ角ゴ Pro W3', 'Hiragino Kaku Gothic Pro', 'メイリオ', Meiryo, sans-serif;
    }
    .contents__share__item {
      display: block;
      position: relative;
      width: 71.88vw;
      height: 10.94vw;
      border-radius: 5.47vw;
      margin: 4.69vw auto 0;
      padding-left: 16vw;
      box-sizing: border-box;
      line-height: 10.94vw;
      text-align: center;
      font-size: 3.75vw;
      color: #ffffff;
    }
    .contents__share__item::before {
      content: '';
      display: block;
      position: absolute;
      top: 0;
      left: 0;
      width: 18.75vw;
      height: 10.94vw;
      background-position: 50% 50%;
      background-repeat: no-repeat;
    }

    .contents__share__item.twitter::before {
      background-image: url(assets/images/icon-twitter.png);
      background-size: 22%;
    }
    .contents__share__item.facebook::before {
      background-image: url(assets/images/icon-facebook.png);
      background-size: 10%;
    }
    .contents__share__item.line::before {
      background-image: url(assets/images/icon-line.png);
      background-size: 24%;
    }
    .contents__share__item::after {
      content: '';
      display: block;
      position: absolute;
      top: 2.35vw;
      left: 18.75vw;
      width: 0.16vw;
      min-width: 1px;
      height: 6.41vw;
      background: #ffffff;
    }
    .contents__share__item.twitter {
      background: #55acee;
    }
    .contents__share__item.facebook {
      background: #315096;
    }
    .contents__share__item.line {
      background: #00c300;
    }

    .button-top {
      position: fixed;
      z-index: 2;
      bottom: 0;
      left: 0;
      right: 0;
      margin: 0 auto;
      width: 45.31vw;
      height: 12.50vw;
      background: #ffe464;
      border-top: 1.09vw solid #ffffff;
      border-left: 1.09vw solid #ffffff;
      border-right: 1.09vw solid #ffffff;
      border-radius: 4.06vw 4.06vw 0 0;
      box-sizing: border-box;
      text-align: center;
      line-height: 11.41vw;
      font-size: 4.40vw;
      font-weight: bold;
    }
    .button-top::before,
    .button-top::after {
      content: '';
      display: block;
      position: absolute;
      top: 50%;
      left: 4.69vw;
      width: 0.63vw;
      height: 3.59vw;
      background: #fff;
    }
    .button-top::before {
      transform-origin: 0 100%;
      transform: translate(0, -100%) rotate(45deg);
    }
    .button-top::after {
      transform-origin: 0 0;
      transform: translate(0, 0) rotate(-45deg);
    }
  </style>
</end-scene>
