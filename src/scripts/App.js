import './containers/app.tag';
import './containers/scene.tag';
import './containers/scenes/home-scene.tag';
import './containers/scenes/comic-scene.tag';
import './components/home-header.tag';
import './components/home-footer.tag';
import './components/comic-page.tag';

document.body.appendChild(document.createElement('app'));
riot.mount('app');
