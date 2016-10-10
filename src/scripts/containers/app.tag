<app>
  <scene />
  <orientation />

  <script>
    import SceneAction from '../actions/SceneAction';
    import ComicAction from '../actions/ComicAction';

    this.on('mount', () => {
      setTimeout(() => {
        SceneAction.gotoHome();
        ComicAction.reset();
      }, 0);
      setTimeout(() => {
        window.scrollTo(0, 1);
        setTimeout(() => {
          window.scrollTo(0, 0);
        }, 0);
      }, 0);
    });

    window.addEventListener('touchmove', event => {
//      event.preventDefault();
    }, false);

  </script>

  <style>
    html,
    body {
      width: 100%;
      height: 100%;
    }

    body {
      background: #ffffff;
      margin: 0;
      font-family: 'TsukuARdGothic-Regular', 'ヒラギノ角ゴ ProN W3', 'Hiragino Kaku Gothic ProN', 'メイリオ', Meiryo,sans-serif;
      -webkit-text-size-adjust: 100%;
      text-size-adjust: 100%;
      color: #000000;
    }

    button:focus {
      outline: 0;
    }
  </style>

  <style scoped>
     :scope {
       display: block;
       width: 100%;
       height: 100%;
     }
  </style>
</app>
