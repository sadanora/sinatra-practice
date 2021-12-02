# 概要
フィヨルドブートキャンプの「Sinatra を使ってWebアプリケーションの基本を理解する」の提出物です。

# 開発環境
- ruby 2.7.2(rbenv1.1.2)
- Bundler version 2.2.31

# 利用方法
1. このリポジトリをクローン
1. クローン先のディレクトリで`$ bundle install`し必要なGemをインストール後、`$ bundle exec ruby app.rb`
1. ブラウザで http://localhost:4567/ にアクセスしてください

# 注意点
ruby3.0.0以降の場合、sinatraを起動するためには別途webrick gemのインストールが必要です。

ruby 2.7.2で開発しているため、Gemfileにwebrickを記述していません。

（2.7系以前のrubyは標準で入っている）

参考 [Ruby 3\.0\.0 リリース](https://www.ruby-lang.org/ja/news/2020/12/25/ruby-3-0-0-released/)

ruby3系での検証はしていませんが、もしruby3系で試す場合は
- `$ gem install webrick`する
- Gemfileへ`gem 'webrick'` を追記してから`$ bundle install`する

など、適宜webrickのインストールが必要です。
