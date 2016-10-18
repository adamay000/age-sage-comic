# あげさげコミック

http://fujiimary.com/agesagecomic

```
git clone https://github.com/adamay000/age-sage-comic.git

cd age-sage-comic
npm install
npm run build
```

## コマンド

|コマンド|説明|サーバ|html5lint|
|---|---|---|---|
|`npm start`|開発用にビルドする|o|x|
|`npm run build`|公開用にビルドする|x|o|

## 留意点

- サーバは http://localhost:8901/ で立ち上がる
- distはgitで管理しない。直接何かを入れたい場合はsrc/statics以下に置いておく。

## ディレクトリ構成

```
├─ dist        ビルド後のファイルが入る。gitで管理しない
│
├─ gulp
│ ├─ tasks     タスクファイルが入ってる
│ ├─ store.js  タスクで利用するデータ管理
│ └─ utils.js  タスクで利用するユーティリティ
│
├─ src
│ ├─ scripts
│ └─ statics   distにコピーしたいファイルをここに置く
```
