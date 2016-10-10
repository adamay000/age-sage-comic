import SceneStore from '../stores/SceneStore';

export default class SceneAction {

  static gotoHome() {
    new SceneStore().changeScene(SceneStore.SCENE_HOME);
  }

  static gotoComic() {
    new SceneStore().changeScene(SceneStore.SCENE_COMIC);
  }

  static gotoEnd() {
    new SceneStore().changeScene(SceneStore.SCENE_END);
  }

}
