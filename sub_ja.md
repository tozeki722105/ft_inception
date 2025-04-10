## はじめに

このプロジェクトは、Docker を使用してシステム管理の知識を広げることを目的としています。
新しいパーソナル仮想マシン上に複数の Docker イメージを仮想化して作成します。

## 一般的なガイドライン

* このプロジェクトは仮想マシン上で行う必要があります。
* プロジェクトの設定に必要なすべてのファイルは `srcs` フォルダに配置する必要があります。
* Makefile も必要で、ディレクトリのルートに配置する必要があります。Makefile はアプリケーション全体をセットアップする必要があります（つまり、`docker-compose.yml` を使用して Docker イメージをビルドする必要があります）。
* この課題は、あなたのバックグラウンドによってはまだ学習していない可能性のある概念の実践を必要とします。したがって、Docker の使用方法や、この課題を完了するのに役立つと思われるその他すべての関連ドキュメントを積極的に読むことをお勧めします。

## 必須パート

このプロジェクトでは、特定のルールに基づいて、異なるサービスで構成される小規模なインフラストラクチャをセットアップします。プロジェクト全体は仮想マシン上で行う必要があります。`docker compose` を使用する必要があります。

各 Docker イメージは、対応するサービスと同じ名前を持つ必要があります。
各サービスは専用のコンテナ内で実行する必要があります。
パフォーマンス上の理由から、コンテナは Alpine または Debian の最新から2番目の安定バージョンからビルドする必要があります。どちらを選択するかはあなた次第です。

また、サービスごとに1つずつ、独自の Dockerfile を作成する必要があります。Dockerfile は `docker-compose.yml` 内で Makefile によって呼び出される必要があります。
つまり、プロジェクトの Docker イメージを自分でビルドする必要があります。そのため、既製の Docker イメージを pull すること、および Docker Hub などのサービスを使用することは禁止されています（Alpine/Debian はこのルールから除外されます）。

次に、以下をセットアップする必要があります。

* TLSv1.2 または TLSv1.3 のみを使用する NGINX を含む Docker コンテナ。
* WordPress + php-fpm のみを含む Docker コンテナ (nginx は不要、インストールと設定が必要)。
* MariaDB のみを含む Docker コンテナ (nginx は不要)。
* WordPress データベースを含むボリューム。
* WordPress ウェブサイトファイルを含む2つ目のボリューム。
* コンテナ間の接続を確立する docker ネットワーク。

コンテナはクラッシュした場合に再起動する必要があります。

Docker コンテナは仮想マシンではありません。したがって、コンテナを実行しようとする際に `tail -f` などに基づくハッキーなパッチを使用することはお勧めしません。デーモンの仕組みと、デーモンを使用するのが良い考えかどうかについて読んでください。

もちろん、`network: host` や `--link` や `links:` の使用は禁止されています。`network` 行は `docker-compose.yml` ファイルに存在する必要があります。
コンテナは無限ループを実行するコマンドで起動してはいけません。したがって、これはエントリポイントとして使用されるコマンド、またはエントリポイントスクリプトで使用されるコマンドにも適用されます。`tail -f`、`bash`、`sleep infinity`、`while true` など、ハッキーなパッチの使用は禁止されています。

PID 1 と Dockerfile を記述するためのベストプラクティスについて読んでください。

WordPress データベースには2人のユーザーが必要です。そのうち1人は管理者です。管理者のユーザー名に admin/Admin または administrator/Administrator を含めることはできません（例：admin、administrator、Administrator、admin-123 など）。

ボリュームは、Docker を使用してホストマシンの `/home/login/data` フォルダで利用できます。もちろん、`login` は自分のログイン名に置き換える必要があります。

物事を簡単にするために、ローカル IP アドレスを指すようにドメイン名を設定する必要があります。
このドメイン名は `login.42.fr` である必要があります。ここでも、自分のログイン名を使用する必要があります。
たとえば、ログイン名が wil の場合、`wil.42.fr` は wil のウェブサイトを指す IP アドレスにリダイレクトされます。

`latest` タグは禁止されています。
Dockerfile にパスワードを含めてはいけません。
環境変数を使用することは必須です。
また、`.env` ファイルを使用して環境変数を保存すること、および Docker secrets を使用して機密情報を保存することを強くお勧めします。
NGINX コンテナは、TLSv1.2 または TLSv1.3 プロトコルを使用してポート 443 のみ経由でインフラストラクチャへの唯一のエントリポイントである必要があります。
