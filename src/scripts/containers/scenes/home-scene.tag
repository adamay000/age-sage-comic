<home-scene>
  <div onClick="{this.onClick}" animate="enter" animate-leave="leave">Button to change scene</div>

  <script>
    import SceneAction from '../../actions/SceneAction';
//    import riotAnimate from 'riot-animate';

//    this.mixin(riotAnimate);

    this.onClick = () => {
      SceneAction.gotoComic();
    };
  </script>

  <style scoped>
    .enter.riot-animate {
      transition: all 500ms linear;
    }
    .enter.riot-enter,
    .enter.riot-leave.riot-leave.active {
      opacity: 0
    }
  </style>
</home-scene>
