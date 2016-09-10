<scene>
  <header-tag is-show="{this.isHeader}" />
  <home-scene is-show="{this.isHome}" />
  <comic-scene is-show="{this.isComic}" />
  <footer-tag is-show="{this.isFooter}" />

  <script>
    import SceneStore from '../stores/SceneStore';

    this.isHome = false;
    this.isComic = false;

    const sceneStore = new SceneStore();
    sceneStore.on(SceneStore.EVENT_UPDATE, () => {
      if (sceneStore.getCurrentScene() === SceneStore.SCENE_HOME) {
        this.isHome = true;
        this.isComic = false;
        this.update();
        return;
      }
      if (sceneStore.getCurrentScene() === SceneStore.SCENE_COMIC) {
        this.isHome = false;
        this.isComic = true;
        this.update();
        return;
      }
    });
  </script>
</scene>
