export default class Preload {

  static image(imagePath, callback) {
    const image = new Image();
    if (typeof callback === 'function') {
      image.onload = callback;
    }
    image.src = imagePath;
  }

}
