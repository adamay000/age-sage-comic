import './containers/app.tag';
import './containers/scene.tag';
import './containers/scenes/home-scene.tag';
import './containers/scenes/comic-scene.tag';
import './components/home-header.tag';
import './components/home-footer.tag';

document.body.appendChild(document.createElement('App'));
riot.mount('*', {}, true);
