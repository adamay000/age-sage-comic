<scene>
  <home-scene if="{this.isHome}" />
  <comic-scene if="{this.isComic}" />
  <end-scene if="{this.isEnd}" />

  <script>
    import SceneStore from '../stores/SceneStore';

    this.isHome = false;
    this.isComic = false;
    this.isEnd = false;

    const sceneStore = new SceneStore();
    sceneStore.on(SceneStore.EVENT_UPDATE, () => {
      const currentScene = sceneStore.getCurrentScene();
      this.isHome = currentScene === SceneStore.SCENE_HOME;
      this.isComic = currentScene === SceneStore.SCENE_COMIC;
      this.isEnd = currentScene === SceneStore.SCENE_END;
      this.update();
    });
  </script>

  <style scoped>
    :scope {
      display: block;
      width: 100%;
      height: 100%;
    }
  </style>
</scene>
