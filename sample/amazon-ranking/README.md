# amazon-ranking

https://www.amazon.co.jp/gp/bestsellers/

amazonの全てのカテゴリの売れ筋ランキングを1位から20位まで抽出する。

## Requirements

- Ruby
- RabbitMQ
- RDB
  - PostgreSQL (default)
  - MySQL
  - SQLite3

## Usage

1. Install dependencies

```
$ bundle install
```

2. Create database

```
$ bundle exec rake db:create
$ bundle exec rake db:migrate
```

3. Open new terminal and run crawler/processor

```
$ bin/crawler   # on new terminal
$ bin/processor # on new terminal
```

4. Enqueue task

```
$ bin/enqueue url http://example.com/
```

5. You'll see `It works with 'http://example.com'` on your terminal which runs your processor!

6. You can re-enqueue task for processor

```
$ bin/enqueue response http://example.com/
```

Display `It works with 'http://example.com'` again on your terminal which runs your processor.

## Usage with docker-compose

1. Build docker images

```
$ docker-compose build
```

2. Run docker containers

```
$ docker-compose up -d
```

3. Run a command on docker containers

```
$ docker-compose exec <service name> <command>
```

For example,

```
$ docker-compose exec amazon-ranking-db bash
$ docker-compose exec amazon-ranking-crawler sh
```

4. Shutdown docker containers

```
$ docker-compose down
$ docker-compose down --rmi all # Remove all related images
```
