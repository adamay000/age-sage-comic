<scene>
  <home-scene if="{this.isHome}" />
  <comic-scene if="{this.isComic}" />

  <script>
    import SceneStore from '../stores/SceneStore';

    this.isHome = false;
    this.isComic = false;

    const sceneStore = new SceneStore();
    sceneStore.on(SceneStore.EVENT_UPDATE, () => {
      const currentScene = sceneStore.getCurrentScene();
      this.isHome = currentScene === SceneStore.SCENE_HOME;
      this.isComic = currentScene === SceneStore.SCENE_COMIC;
      this.update();
    });
  </script>
</scene>
