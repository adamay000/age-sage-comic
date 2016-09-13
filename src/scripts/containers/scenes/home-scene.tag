<home-scene>
  <div class="button" onClick="{this.onClick}">Button to change scene</div>

  <script>
    import SceneAction from '../../actions/SceneAction';

    this.onClick = () => {
      SceneAction.gotoComic();
    };
  </script>

  <style scoped>
    :scope {
      width: 100%;
      height: 100%;
    }

    .button {
      width: 240px;
      border: 1px solid black;
      position: absolute;
      top: 50%;
      left: 0;
      right: 0;
      transform: translate(0, -50%);
      margin: auto;
      padding: 20px;
      text-align: center;
    }
  </style>
</home-scene>
