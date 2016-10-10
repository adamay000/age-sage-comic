<author>
  <ul class="authors">
    <li class="authors__item">
      <p class="authors__item__role">漫画・デザイン</p>
      <p class="authors__item__name">藤井　マリー</p>
      <ul class="authors__item__link">
        <li class="authors__item__link__website"><a href="#">Website</a></li>
        <li class="authors__item__link__twitter"><a href="#">Twitter</a></li>
      </ul>
    </li>
    <li class="authors__item">
      <p class="authors__item__role">音楽</p>
      <p class="authors__item__name">馬道まさたか</p>
      <ul class="authors__item__link">
        <li class="authors__item__link__website"><a href="#">Website</a></li>
        <li class="authors__item__link__twitter"><a href="#">Twitter</a></li>
      </ul>
    </li>
    <li class="authors__item">
      <p class="authors__item__role">マークアップ・フロントエンド</p>
      <p class="authors__item__name">やまだだいき</p>
      <ul class="authors__item__link">
        <li class="authors__item__link__website"><a href="#">Website</a></li>
      </ul>
    </li>
  </ul>

  <style scoped>
    :scope {
      display: block;
      width: 100%;
      font-family: 'ヒラギノ角ゴ Pro W3', 'Hiragino Kaku Gothic Pro', 'メイリオ', Meiryo, sans-serif;
    }
    .authors {
      width: 59.38vw;
      list-style-type: none;
      margin: 0 auto;
      padding: 0;
    }
    .authors__item {}
    .authors__item__role {
      margin: 2.1em 0 0;
      font-size: 3.12vw;
      color: #363129;
    }
    .authors__item__name {
      margin: 0.3em 0 0;
      font-weight: bold;
      font-size: 4.06vw;
      color: #363129;
    }
    .authors__item__link {
      display: block;
      margin: 0.7em 0 0;
      padding: 0;
      font-size: 0;
    }
    .authors__item__link a {
      text-decoration: none;
      color: #ff9054;
    }
    .authors__item__link__website {
      display: inline-block;
      margin-right: 6.25vw;
      vertical-align: text-bottom;
      letter-spacing: 0.14em;
      font-size: 3.12vw;
      color: #ff9054;
    }
    .authors__item__link__twitter {
      display: inline-block;
      margin-right: 6.25vw;
      vertical-align: text-bottom;
      letter-spacing: 0.14em;
      font-size: 3.12vw;
      color: #ff9054;
    }
    .authors__item__link__website::before {
      content: '';
      display: inline-block;
      width: 4.06vw;
      height: 3.75vh;
      margin-right: 1.56vw;
      background: url(assets/images/icon-link-website.png) 50% 50% no-repeat;
      background-size: contain;
      vertical-align: bottom;
    }
    .authors__item__link__twitter::before {
      content: '';
      display: inline-block;
      width: 4.06vw;
      height: 3.44vh;
      margin-right: 1.56vw;
      background: url(assets/images/icon-link-twitter.png) 50% 50% no-repeat;
      background-size: contain;
      vertical-align: bottom;
    }
  </style>
</author>
