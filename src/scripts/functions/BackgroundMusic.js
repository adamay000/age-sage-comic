import { Howl } from 'howler';

let instance;
export default class BackgroundMusic {

  constructor() {
    if (instance) {
      return instance;
    }
    instance = this;

    this.volume = 1.0;
    this.fadeDuration = 600;
    this.isPlayingAge = false;
    this.isPlayingSage = false;

    this.age = new Howl({
      src: ['music/age.mp3'],
      // html5: true,
      preload: true,
      loop: true,
      onfade() {
        if (this.volume() === 0) {
          this.pause();
          this.isPlayingAge = false;
        }
      }
    });
    this.sage = new Howl({
      src: ['music/sage.mp3'],
      // html5: true,
      preload: true,
      loop: true,
      onfade() {
        if (this.volume() === 0) {
          this.pause();
          this.isPlayingSage = false;
        }
      }
    });

    return this;
  }

  playAge() {
    if (this.isPlayingAge) {
      return;
    }
    this.isPlayingAge = true;

    if (!this.age.playing()) {
      this.age.play();
    }
    this.age.fade(0, this.volume, this.fadeDuration);

    if (this.isPlayingSage) {
      this.isPlayingSage = false;
      this.sage.fade(this.volume, 0, this.fadeDuration);
    }
  }

  playSage() {
    if (this.isPlayingSage) {
      return;
    }
    this.isPlayingSage = true;

    if (!this.sage.playing()) {
      this.sage.play();
    }
    this.sage.fade(0, this.volume, this.fadeDuration);

    if (this.isPlayingAge) {
      this.isPlayingAge = false;
      this.age.fade(this.volume, 0, this.fadeDuration);
    }
  }

  stop() {
    this.isPlayingAge = false;
    this.isPlayingAge = false;
    this.age.fade(this.volume, 0, this.fadeDuration);
    this.sage.fade(this.volume, 0, this.fadeDuration);
  }

  seekZero() {
    this.age.seek(0);
    this.sage.seek(0);
  }

}
