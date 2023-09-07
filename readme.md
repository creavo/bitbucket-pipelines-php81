# Bitbucket Pipelines PHP 8.1 image

[![](https://images.microbadger.com/badges/version/creavo/bitbucket-pipelines-php81.svg)](https://microbadger.com/images/creavo/bitbucket-pipelines-php81 "Get your own version badge on microbadger.com") [![](https://images.microbadger.com/badges/image/creavo/bitbucket-pipelines-php81.svg)](https://microbadger.com/images/creavo/bitbucket-pipelines-php81 "Get your own image badge on microbadger.com")

## Based on Ubuntu 22.04

### Packages installed

- `php8.1-zip`, `php8.1-xml`, `php8.1-mbstring`, `php8.1-curl`, `php8.1-json`, `php8.1-imap`, `php8.1-mysql`, `php8.1-tokenizer`, `php8.1-xdebug`, `php8.1-intl`, `php8.1-soap`, `php8.1-pdo`, `php8.1-cli`, `php8.1-gd`, `php8.1-gmp` and `php-imagick`
- wget, curl, unzip
- Composer 2
- Mysql 8.0
- Redis-Server
- NPM
- Node + Yarn

### Sample `bitbucket-pipelines.yml`

```YAML
image: creavo/bitbucket-pipelines-php81
pipelines:
  default:
    - step:
        script:
          - composer self-update
          - phive self-update
          - service mysql start
          - mysql -h localhost -u root -proot -e "CREATE DATABASE test;"
          - composer install --no-interaction --no-progress --prefer-dist
          - ./vendor/phpunit/phpunit/phpunit -v --coverage-text --colors=never --stderr
```
