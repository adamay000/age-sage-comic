let instance;
export default class SceneStore {

  static get SCENE_HOME() {
    return 'SceneStore.SCENE_HOME';
  }
  static get SCENE_COMIC() {
    return 'SceneStore.SCENE_COMIC';
  }
  static get SCENE_ENDING() {
    return 'SceneStore.SCENE_ENDING';
  }

  static get EVENT_UPDATE() {
    return 'SceneStore.EVENT_UPDATE';
  }

  constructor() {
    if (instance) {
      return instance;
    }
    instance = this;
    riot.observable(this);

    this._currentScene = null;

    return this;
  }

  changeScene(scene) {
    this._currentScene = scene;
    this.trigger(SceneStore.EVENT_UPDATE);
  }

  getCurrentScene() {
    return this._currentScene;
  }

}
