<app>
  <scene />

  <script>
    import SceneAction from '../actions/SceneAction';
    import ComicAction from '../actions/ComicAction';

    this.on('mount', () => {
      setTimeout(() => {
        SceneAction.gotoComic();
        ComicAction.reset();
      }, 0);
    });
  </script>

  <style>
    body {
      background: #ffdd4c;
      margin: 0;
      color: black;
    }
  </style>
</app>
