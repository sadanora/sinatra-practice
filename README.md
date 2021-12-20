# 概要
フィヨルドブートキャンプの「Sinatra を使ってWebアプリケーションの基本を理解する」の提出物です。

# 開発環境
- ruby 2.7.2(rbenv1.1.2)
- Bundler version 2.2.31
- PostgreSQL 14.1

# 利用方法
## データベースの用意
- このアプリ用のデータベース(PostgreSQL)を用意してください。
- テーブル名は`memos`にしてください。
- 開発者は以下のDDL文でテーブルを作成しています。

  `CREATE TABLE memos (id serial NOT NULL, title VARCHAR(100), detail TEXT, PRIMARY KEY (id));`

上記のDDL文で作成したテーブルは、以下のようになるはずです。
```
 Column |          Type          | Collation | Nullable |              Default
--------+------------------------+-----------+----------+-----------------------------------
 id     | integer                |           | not null | nextval('memos_id_seq'::regclass)
 title  | character varying(100) |           |          |
 detail | text                   |           |          |
Indexes:
    "memos_pkey" PRIMARY KEY, btree (id)
```

## リポジトリのクローン、アプリの起動
1. このリポジトリをクローン

1. 接続先のデータベース情報の設定

    `/app.rb` 10行目あたりで定数`CONNECTION`を定義しています。

    `CONNECTION = PG.connect(dbname: 'sinatra_memoapp')`

    PG.connectの引数`(dbname: 'sinatra_memoapp')`をご自身の環境に合わせて書き換えてください。

    開発者の環境ではdbnameのみを指定していますが、環境によりその他の情報が必要な場合は適宜設定してください。

    PG.connectについて詳細を確認したい場合は以下などを参考にしてください。

    [Class: PG::Connection — Documentation for pg \(1\.2\.3\)](https://www.rubydoc.info/gems/pg/PG/Connection)
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
