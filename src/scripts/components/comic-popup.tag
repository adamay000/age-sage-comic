<comic-popup>
  <div class="age" id="popup-age">
    <div class="age__arrow" id="age-arrow"></div>
    <div class="age__text" id="age-text"></div>
  </div>
  <div class="sage" id="popup-sage">
    <div class="sage__arrow" id="sage-arrow"></div>
    <div class="sage__text" id="sage-text"></div>
  </div>

  <script>
    import Animate from '../utils/Animate';

    this.reset = () => {
      this.root.style.display = 'none';
      this['popup-age'].style.display = 'none';
      this['popup-sage'].style.display = 'none';
    };

    this.age = () => {
      this.root.style.display = 'block';
      this['popup-age'].style.display = 'block';
      this['popup-age'].style.opacity = 1;
      this['age-text'].style.opacity = 0;

      new Animate({
        duration: 360,
        easing: Animate.Easing.easeOut(3),
        onProgress: progress => {
          this['age-arrow'].style.opacity = progress;
          this['age-arrow'].style.transform = `translate(0, ${30 * (1 - progress)}px)`;
        }
      }).start();
      new Animate({
        delay: 120,
        duration: 480,
        easing: Animate.Easing.easeOut(3),
        onProgress: progress => {
          this['age-text'].style.opacity = progress;
          this['age-text'].style.transform = `translate(0, ${30 * (1 - progress)}px)`;
        }
      }).start();
      new Animate({
        delay: 480,
        duration: 240,
        easing: Animate.Easing.easeIn(3),
        onProgress: progress => {
          this['popup-age'].style.opacity = 1 - progress;
        },
        onComplete: () => {
          this.root.style.display = 'none';
          this['popup-age'].style.display = 'none';
        }
      }).start();
    };

    this.sage = () => {
      this.root.style.display = 'block';
      this['popup-sage'].style.display = 'block';
      this['popup-sage'].style.opacity = 1;
      this['sage-text'].style.opacity = 0;

      new Animate({
        duration: 360,
        easing: Animate.Easing.easeOut(3),
        onProgress: progress => {
          this['sage-arrow'].style.opacity = progress;
          this['sage-arrow'].style.transform = `translate(0, -${30 * (1 - progress)}px)`;
        }
      }).start();
      new Animate({
        delay: 120,
        duration: 480,
        easing: Animate.Easing.easeOut(3),
        onProgress: progress => {
          this['sage-text'].style.opacity = progress;
          this['sage-text'].style.transform = `translate(0, -${30 * (1 - progress)}px)`;
        }
      }).start();
      new Animate({
        delay: 480,
        duration: 240,
        easing: Animate.Easing.easeIn(3),
        onProgress: progress => {
          this['popup-sage'].style.opacity = 1 - progress;
        },
        onComplete: () => {
          this.root.style.display = 'none';
          this['popup-sage'].style.display = 'none';
        }
      }).start();
    };
  </script>

  <style scoped>
    :scope {
      display: none;
      position: absolute;
      z-index: 9999;
      top: 0;
      left: 0;
      right: 0;
      bottom: 12.50vw;
    }
    .age {
      display: none;
      position: absolute;
      top: 50%;
      left: 0;
      right: 0;
      height: 80vw;
      transform: translate(0, -50%);
      font-size: 0;
    }
    .age__arrow {
      height: 56.88vw;
      background: url(assets/images/comic-age-arrow.png) 50% 50% no-repeat;
      background-size: contain;
    }
    .age__text {
      height: 22.19vw;
      background: url(assets/images/comic-age-text.png) 50% 50% no-repeat;
      background-size: contain;
    }
    .sage {
      display: none;
      position: absolute;
      top: 50%;
      left: 0;
      right: 0;
      height: 80vw;
      transform: translate(0, -50%);
      font-size: 0;
    }
    .sage__arrow {
      height: 56.41vw;
      background: url(assets/images/comic-sage-arrow.png) 50% 50% no-repeat;
      background-size: contain;
    }
    .sage__text {
      height: 23.12vw;
      background: url(assets/images/comic-sage-text.png) 50% 50% no-repeat;
      background-size: contain;
    }
  </style>
</comic-popup>
