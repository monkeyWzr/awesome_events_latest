Ruby 3.0.2 + Rails 6.1.4で「パーフェクトRuby on Rails　第２版」第6章以降のサンプルアプリケーションの実装です。

オリジナルrepo: [perfect-ruby-on-rails/awesome_events](https://github.com/perfect-ruby-on-rails/awesome_events)

環境:

* Ubuntu 20.04
* Chrome 92
* Ruby 3.0.2
* Rails 6.1.4
* BootStrap 5
* Elasticsearch 7.14.0
* gemのバージョン指定なし

新パージョンにより変わったところ、対応必要になったところ：

### ActiveModel::Errors.add を使う

6.1から`<<`を使うと警告が出る

```ruby
# model.errors[:some_key] << 'some message'
model.errors.add :some_key, 'some message'
```
参照: [https://qiita.com/jnchito/items/0712e8b692c4b3c288f3](https://qiita.com/jnchito/items/0712e8b692c4b3c288f3)

### Ruby 3.0.0からrexmlの指定が必要

```ruby
gem 'rexml'
```

参照: [https://stackoverflow.com/questions/65479863/rails-6-1-ruby-3-0-0-tests-error-as-they-cannot-load-rexml](https://stackoverflow.com/questions/65479863/rails-6-1-ruby-3-0-0-tests-error-as-they-cannot-load-rexml)


### omniauthのcsrf_detected_error

わかんない。
開発環境で`provider_ignores_state: true`を設定したら解決(?)

[config/initializers/omniauth.rb#L4](https://github.com/monkeyWzr/awesome_events_latest/blob/ffa806e7a01888fc74ec2bc56376e5fa67633c3c/config/initializers/omniauth.rb#L4)

### form_withのデフォルト挙動変更(非同期送信から同期送信に変更)

もともとデフォルトで`local: false`になり、form_withがAjaxで非同期送信する。
rails 6.1から`:local`のデフォルト値が`true`に更新され、同期遷移になった。
そのため、local: falseの指定が必要になった。

```ruby
form_with(model: @event, local: false)
```

参照: [https://bon-voyage23.hatenablog.com/entry/2021/05/01/152200](https://bon-voyage23.hatenablog.com/entry/2021/05/01/152200)

### kaminariの最新ソースでgemインストールする

```ruby
gem 'kaminari', git: 'https://github.com/kaminari/kaminari'
```

Ruby 3から、URI.openでURLをフェッチすることになって、[#1050](https://github.com/kaminari/kaminari/pull/1050)
のprがマージ済んだが、まだリリースされてない

### BootStrap5について

* `form-control`廃止、`md-3`を使う
* `btn-block`廃止
* kaminariのBootStrap4テーマそのままで使える

### Elasticsearchのセットアップ

デフォルトでメモリを食いすぎる(70%だった)
`/etc/elasticsearch/jvm.options`でmaxメモリが指定できる。
以下は最大1GB
```text
-Xmx1g
```

問題なく

### その他

* たまたまrailsコマンドの挙動が変になって、`spring stop`の実行が必要だった。
* GitHub ActionsでElasticsearchが不安定だった。[MissingIndexError](https://github.com/monkeyWzr/awesome_events_latest/runs/3441655320?check_suite_focus=true) がたまたま出る。searchkick:reindex:allのタスクを[追加した](https://github.com/monkeyWzr/awesome_events_latest/blob/ffa806e7a01888fc74ec2bc56376e5fa67633c3c/.github/workflows/ruby.yml#L49)
