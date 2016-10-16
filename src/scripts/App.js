import './containers/app.tag';
import './containers/pc.tag';
import './containers/orientation.tag';
import './containers/scene.tag';
import './containers/scenes/home-scene.tag';
import './containers/scenes/comic-scene.tag';
import './containers/scenes/end-scene.tag';
import './components/author.tag';
import './components/comic-page.tag';
import './components/comic-popup.tag';

document.body.appendChild(document.createElement('app'));
riot.mount('app');
