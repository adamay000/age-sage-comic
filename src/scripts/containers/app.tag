<app>
  <scene />
  <p>{this.title}</p>

  <script>
    import SceneAction from '../actions/SceneAction';

    this.on('mount', () => {
      setTimeout(() => {
        SceneAction.gotoHome();
      }, 0);
    });

    this.title = 0;
    setInterval(() => {
      this.title++;
      this.update();
    }, 1000);
  </script>
</app>
