/* eslint-disable */

class Animate {

  static get Easing() {
    return {
      linear(progress) {
        return progress;
      },
      easeIn(power) {
        return function (progress) {
          return Math.pow(progress, power);
        };
      },
      easeOut(power) {
        return function (progress) {
          return 1 - Math.abs(Math.pow(1 - progress, power));
        };
      },
      easeInOut(power) {
        return function (progress) {
          return progress < 0.5 ? Animate.Easing.easeIn(power)(progress * 2) / 2 : Animate.Easing.easeOut(power)(progress * 2 - 1) / 2 + 0.5;
        };
      }
    };
  }

  constructor(_params) {
    const params = _params || {};
    this._isRunning = false;
    this._progress = 0;

    this._lastTime = 0;
    this._stackedTime = 0;

    this._delay = typeof params.delay === 'number' ? params.delay : 0;
    this._duration = typeof params.duration === 'number' ? params.duration : 1000;
    this._easing = typeof params.easing === 'function' ? params.easing : Animate.Easing.linear;
    this._onProgress = typeof params.onProgress === 'function' ?
      params.onProgress :
      function dummyOnProgress() {};
    this._onBegin = typeof params.onBegin === 'function' ?
      params.onBegin :
      function dummyOnBegin() {};
    this._onComplete = typeof params.onComplete === 'function' ?
      params.onComplete :
      function dummyOnComplete() {};

    this._id = 0;
  }

  start() {
    if (this._isRunning) {
      return;
    }

    this._lastTime = +new Date;
    this._isRunning = true;
    this._loop();
  }

  stop() {
    if (!this._isRunning) {
      return;
    }

    this._isRunning = false;
    window.cancelAnimationFrame(this._id);
  }

  isRunning() {
    return this._isRunning;
  }

  _loop() {
    this._id = requestAnimationFrame(this._loop.bind(this));

    const currentTime = +new Date;
    this._stackedTime += currentTime - this._lastTime;
    this._lastTime = currentTime;

    if (this._stackedTime < this._delay) {
      return;
    }
    this._progress || this._onBegin(this._progress);

    this._progress = (this._stackedTime - this._delay) / this._duration;
    if (this._progress > 1) {
      this._progress = 1;
      this.stop();
      this._onProgress(this._progress);
      this._onComplete(this._progress);
      return;
    }

    this._progress = this._easing(this._progress);
    this._onProgress(this._progress);
  }

}

export default Animate;
