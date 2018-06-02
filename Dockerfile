# from https://hub.docker.com/_/drupal/
# @see  https://github.com/drupal-composer/drupal-project/blob/8.x/composer.json
FROM drupal:latest
# install the GIT for drupal-composer/drupal-project
RUN set -ex; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
		git \
	; \
	apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false; \
	rm -rf /var/lib/apt/lists/*  /var/www/html ; \
	curl -fSL "https://getcomposer.org/download/1.6.4/composer.phar" -o /usr/local/bin/composer ; \
	chmod +x /usr/local/bin/composer
RUN composer create-project drupal-composer/drupal-project:8.x-dev /var/www/drupal --stability dev --no-interaction

RUN mkdir /var/www/drupal/config ; \
	chown -R www-data:www-data /var/www/drupal/config /var/www/drupal/web/sites /var/www/drupal/web/modules /var/www/drupal/web/themes
COPY ./drupal/composer.json  /var/www/drupal/composer.json

WORKDIR /var/www/drupal
RUN composer update
