<pc>
  <div class="background"></div>
  <div class="background-left-bottom"></div>
  <div class="background-right-bottom"></div>
  <div class="header">
    <h1 class="header__title">あげさげコミック</h1>
    <div class="header__share">
      <span class="header__share__title">SHARE</span>
      <a href="https://twitter.com/intent/tweet?url=http%3A%2F%2Ffujiimary.com%2Fagesagecomic&text=%E3%81%82%E3%81%92%E3%81%95%E3%81%92%E3%82%B3%E3%83%9F%E3%83%83%E3%82%AF" target="_blank" class="header__share__twitter">Twitterでシェアする</a>
      <a href="https://www.facebook.com/sharer/sharer.php?u=http%3A%2F%2Ffujiimary.com%2Fagesagecomic" target="_blank"
         class="header__share__facebook">Facebookでシェアする</a>
    </div>
  </div>
  <div class="wrapper">
    <div class="description">
      <p class="description__main-text">スマホを上げると、テンションの上がる展開に、<br>下げるとテンションの下がる展開に進むwebコミックです。</p>
      <div class="description__url-area">
        <img src="assets/images/qr-code.png" width="165" height="165" alt="http://fujiimary.com/agesagecomic" class="description__url-area__qr-code">
        <p class="description__url-area__url">http://fujiimary.com/agesagecomic</p>
      </div>
      <ul class="authors">
        <li class="authors__item">
          <p class="authors__item__role">漫画・デザイン</p>
          <p class="authors__item__name">藤井　マリー</p>
          <ul class="authors__item__link">
            <li class="authors__item__link__website"><a href="http://fujiimary.com" target="_blank">Website</a></li>
            <li
              class="authors__item__link__twitter"><a href="https://twitter.com/maryfujii" target="_blank">Twitter
            </a></li>
          </ul>
        </li>
        <li class="authors__item">
          <p class="authors__item__role">音楽</p>
          <p class="authors__item__name">馬道まさたか</p>
          <ul class="authors__item__link">
            <li class="authors__item__link__website"><a href="http://umamichi.com" target="_blank">Website</a></li>
            <li class="authors__item__link__twitter"><a href="https://twitter.com/masaumamichi" target="_blank">Twitter</a></li>
          </ul>
        </li>
        <li class="authors__item">
          <p class="authors__item__role">マークアップ・フロントエンド</p>
          <p class="authors__item__name">やまだだいき</p>
          <ul class="authors__item__link">
            <li
              class="authors__item__link__website"><a href="http://adamay000.github.io/" target="_blank">Website</a></li>
          </ul>
        </li>
      </ul>
    </div>
    <div class="thumbnail">
      <img src="assets/images/pc-thumbnail.png" width="300" height="531" alt="サムネイル" class="thumbnail__image">
    </div>
  </div>
  <p class="footer">© agesagecomic All Rights Reserved.</p>

  <script>

  </script>

  <style scoped>
    :scope {
      display: block;
      width: 100%;
      height: 100%;
      font-family: 'ヒラギノ角ゴ Pro W3', 'Hiragino Kaku Gothic Pro', 'メイリオ', Meiryo, sans-serif;
      color: #363129;
    }
    .background {
      pointer-events: none;
      position: fixed;
      z-index: -1;
      top: 0;
      right: 0;
      bottom: 0;
      left: 0;
      background: url(assets/images/pc-background.jpg) 50% 50% / cover no-repeat;
    }
    .background-left-bottom {
      pointer-events: none;
      position: fixed;
      z-index: 2;
      left: 0;
      bottom: 0;
      width: 11.83vw;
      min-width: 107px;
      max-width: 213px;
      height: 0;
      padding-top: 39.96%;
      background: url(assets/images/pc-background-left-bottom.png) 0% 100% / contain no-repeat;
    }
    .background-right-bottom {
      pointer-events: none;
      position: fixed;
      z-index: 2;
      right: 0;
      bottom: 0;
      width: 24.56vw;
      min-width: 221px;
      max-width: 442px;
      height: 0;
      padding-top: 82.93%;
      background: url(assets/images/pc-background-right-bottom.png) 100% 100% / contain no-repeat;
    }
    .header {
      position: relative;
      min-width: 960px;
      padding-top: 22px;
    }
    .header__title {
      width: 313px;
      height: 135px;
      margin: 0 auto;
      background: url(assets/images/pc-logo.png) 50% 50% no-repeat;
      background-size: contain;
      overflow: hidden;
      text-indent: 100%;
      white-space: nowrap;
    }
    .header__share {
      position: absolute;
      top: 98px;
      left: 0;
      right: 0;
      width: 960px;
      margin: 0 auto;
      text-align: right;
      font-size: 0;
    }
    .header__share__title {
      display: inline-block;
      margin-right: 20px;
      vertical-align: middle;
      font-size: 16px;
    }
    .header__share a {
      transition: opacity 200ms ease-in-out;
    }
    .header__share a:hover {
      opacity: 0.8;
    }
    .header__share__twitter {
      display: inline-block;
      width: 40px;
      height: 40px;
      background: url(assets/images/pc-twitter.png) 50% 50% no-repeat;
      background-size: contain;
      margin-right: 10px;
      vertical-align: middle;
      overflow: hidden;
      text-indent: 100%;
      white-space: nowrap;
    }
    .header__share__facebook {
      display: inline-block;
      width: 40px;
      height: 40px;
      background: url(assets/images/pc-facebook.png) 50% 50% no-repeat;
      background-size: contain;
      vertical-align: middle;
      overflow: hidden;
      text-indent: 100%;
      white-space: nowrap;
    }

    .wrapper {
      width: 960px;
      margin: 50px auto 0;
    }
    .wrapper::after {
      content: '';
      display: block;
      clear: both;
    }

    .description {
      width: 50%;
      float: left;
      background: #ffe464;
      padding: 32px 40px 28px;
      box-sizing: border-box;
      border-radius: 30px;
      text-align: center;
    }
    .description__main-text {
      margin: 0;
      line-height: 26px;
      text-align: left;
      font-size: 14px;
      font-weight: bold;
    }
    .description__url-area {
      margin-top: 24px;
      background: #fff;
      padding: 38px 0 28px;
      text-align: center;
    }
    .description__url-area__qr-code {
      width: 150px;
      height: 150px;
    }
    .description__url-area__url {
      margin: 28px 0 0;
      letter-spacing: 2px;
      font-size: 16px;
      font-weight: bold;
    }

    .authors {
      display: inline-block;
      list-style: none;
      min-width: 400px;
      margin: 20px auto 0;
      padding: 0;
      box-sizing: border-box;
      border: 1px solid #ffe464;
      border-radius: 10px;
      text-align: left;
    }
    .authors__item {
      display: block;
      padding: 0;
    }
    .authors__item__role {
      display: inline-block;
      margin: 0;
      font-size: 14px;
    }
    .authors__item__name {
      display: inline-block;
      margin: 0 0.5em 0 1em;
      font-size: 16px;
      font-weight: bold;
    }
    .authors__item__link {
      display: inline-block;
      padding: 0;
    }
    .authors__item__link__website {
      display: inline-block;
      vertical-align: middle;
    }
    .authors__item__link__twitter {
      display: inline-block;
      vertical-align: middle;
    }
    .authors__item__link__website a {
      display: inline-block;
      width: 13px;
      height: 12px;
      background: url(assets/images/icon-link-website.png) 50% 50% no-repeat;
      background-size: contain;
      overflow: hidden;
      text-indent: 100%;
      white-space: nowrap;
    }
    .authors__item__link__twitter a {
      display: inline-block;
      width: 13px;
      height: 11px;
      background: url(assets/images/icon-link-twitter.png) 50% 50% no-repeat;
      background-size: contain;
      overflow: hidden;
      text-indent: 100%;
      white-space: nowrap;
    }

    .thumbnail {
      width: 50%;
      float: right;
      text-align: center;
    }
    .thumbnail__image {}

    .footer {
      margin: 150px auto 30px;
      text-align: center;
      font-size: 12px;
    }
  </style>
</pc>
