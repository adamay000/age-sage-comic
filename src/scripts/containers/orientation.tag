<orientation>
  <div class="orientation" if="{this.isShow}">
    <div class="orientation__inner">
      <div class="orientation__image"></div>
      <div class="orientation__text">端末を縦向きにして御覧ください</div>
    </div>
  </div>

  <script>
    this.isShow = false;

    const self = this;
    checkOrientation();
    window.addEventListener('resize', checkOrientation, false);
    window.addEventListener('orientationchange', checkOrientation, false);

    function checkOrientation() {
      self.isShow = Math.abs(window.orientation) === 90;
      self.update();
    }
  </script>

  <style scoped>
    .orientation {
      position: fixed;
      z-index: 9999;
      top: 0;
      right: 0;
      bottom: 0;
      left: 0;
      background: #ffffff;
    }
    .orientation__inner {
      position: absolute;
      top: 50%;
      left: 0;
      right: 0;
      transform: translate(0, -50%);
    }
    .orientation__image {
      width: 36.44vw;
      height: 23.24vw;
      margin: 0 auto;
      background: url(assets/images/orientation.png) 50% 50% / contain no-repeat;
    }
    .orientation__text {
      margin-top: 5.28vw;
      text-align: center;
      font-size: 2.11vw;
    }
  </style>
</orientation>
