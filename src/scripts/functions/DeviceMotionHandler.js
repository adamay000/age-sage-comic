const THRESHOLD = 2.0;

const NONE = 'NONE';
const UP = 'UP';
const DOWN = 'DOWN';

let instance;
export default class DeviceMotionHandler {

  static get AGE() {
    return 'DeviceMotionHandler.AGE';
  }

  static get SAGE() {
    return 'DeviceMotionHandler.SAGE';
  }

  constructor() {
    if (instance) {
      return instance;
    }
    instance = this;
    riot.observable(this);

    this.isEnabled = false;
    this.triggerdOnce = false;

    this.lastDirection = NONE;
    this.sameDirectionCount = 0;
    this.isSleep = true;

    this.deviceMotionCheck = this.deviceMotionCheck.bind(this);
    this.onDeviceMotion = this.onDeviceMotion.bind(this);

    window.addEventListener('devicemotion', this.deviceMotionCheck, false);

    return this;
  }

  hasDeviceMotionEvent() {
    return this.triggerdOnce;
  }

  enable() {
    if (!this.triggerdOnce && this.isEnabled) {
      return;
    }
    this.isEnabled = true;

    this.lastDirection = NONE;
    this.sameDirectionCount = 0;
    this.isSleep = true;
    window.addEventListener('devicemotion', this.onDeviceMotion, false);
  }

  disable() {
    if (!this.isEnabled) {
      return;
    }
    this.isEnabled = false;

    window.removeEventListener('devicemotion', this.onDeviceMotion);
  }

  onDeviceMotion(event) {
    const acceleration = {
      x: event.acceleration.x,
      y: event.acceleration.y,
      z: event.acceleration.z
    };
    const accelerationIncludingGravity = {
      x: (event.accelerationIncludingGravity.x - acceleration.x) / 9.81,
      y: (event.accelerationIncludingGravity.y - acceleration.y) / 9.81,
      z: (event.accelerationIncludingGravity.z - acceleration.z) / 9.81
    };

    const deltaY = (
      (acceleration.x * accelerationIncludingGravity.x) +
      (acceleration.y * accelerationIncludingGravity.y) +
      (acceleration.z * accelerationIncludingGravity.z)
    ) | 0;

    let direction = NONE;
    if (deltaY > THRESHOLD) {
      direction = UP;
    }
    if (deltaY < -THRESHOLD) {
      direction = DOWN;
    }

    if (direction === this.lastDirection) {
      this.sameDirectionCount++;
    } else {
      this.lastDirection = direction;
      this.sameDirectionCount = 0;
    }

    if (direction === NONE) {
      if (this.isSleep && this.sameDirectionCount >= 30) {
        this.isSleep = false;
      }
      return;
    }

    if (!this.isSleep && this.sameDirectionCount >= 2) {
      this.isSleep = true;
      direction === UP && this.trigger(DeviceMotionHandler.AGE);
      direction === DOWN && this.trigger(DeviceMotionHandler.SAGE);
    }
  }

  deviceMotionCheck(event) {
    if (event.acceleration && event.accelerationIncludingGravity) {
      this.triggerdOnce = true;
      window.removeEventListener('devicemotion', this.deviceMotionCheck);
    }
  }

}
