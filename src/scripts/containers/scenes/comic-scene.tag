<comic-scene>
  <div>Comic Scene</div>

  <script>
    import ShowEvent from '../../mixins/ShowEvent';

    this.on('mount', () => {
      this.root.style.display = 'none';
    });

    this.mixin(ShowEvent);
    this.on('onShowBefore', () => {
      this.root.style.display = 'block';
    });
    this.on('onShowAfter', () => {
      console.log('onShowAfter');
    });
    this.on('onHideBefore', () => {
      console.log('onHideBefore');
    });
    this.on('onHideAfter', () => {
      this.root.style.display = 'none';
    });
  </script>
</comic-scene>
