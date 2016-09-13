<comic-page>
  <div style="background-image: url('./comic/{this.opts.data.image}');" class="image" id="comic-image" />

  <style scoped>
    :scope {
      display: inline-block;
      float: right;
      width: 100vw;
      height: 100%;
      padding: 10px;
      box-sizing: border-box;
    }

    .image {
      width: 100%;
      height: 100%;
      background-position: center center;
      background-repeat: no-repeat;
      background-size: contain;
    }
  </style>
</comic-page>
