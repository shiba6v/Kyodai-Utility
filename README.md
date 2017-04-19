# Kyodai-Utility
京都大学で使える自分用便利スクリプトです

## 確認済みの動作環境
macOS Sierra
Ruby 2.3.1

## Windowsで動かない場合の対処法
SSL_connect: certificate verify failed
のようなエラーが出るときはこちらを参考にしたらうまくいくかもしれない
http://qiita.com/whiteleaf7@github/items/4504b208ad2eec1f9357

## lecture_table_public.rb
KULASISから講義情報を取得して出力します．

### Installation
```
$ gem install mechanize
```

### Usage
```
$ ruby lecture_table_public.rb YOUR_ECS_ID YOUR_PASSWORD
```

## lecture_table_public_engineering.rb
lecture_table_public.rbと同じ．工学部の場合は講義室も取ってくれる
