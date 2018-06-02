# docker-compose run Drupal 8 with drupal-composer/drupal-project

## build it!
	docker build -t="drupal:composer" .
## start it
	docker-compose -p ddAPI up -d  --build --remove-orphans --force-recreate
## stop it
	docker-compose -p drupal8 down


## simplehtmldom libraries bug!
    docker cp helper.inc ddapi_drupal_1:/var/www/drupal/web/modules/contrib/simplehtmldom/helper.inc
## setting.php
    docker cp settings.php ddapi_drupal_1:/var/www/drupal/web/sites/default/settings.php
    
    $config_directories['sync'] = '../config/sync';
    $databases['default']['default'] = array (
      'database' => 'drupal',
      'username' => 'drupal',
      'password' => 'drupal',
      'prefix' => 'api_',
      'host' => 'mysql',
      'port' => '3306',
      'namespace' => 'Drupal\\Core\\Database\\Driver\\mysql',
      'driver' => 'mysql',
    );
    $settings['install_profile'] = 'standard';
    // reverse proxy support to make sure the real ip gets logged by Drupal
    $settings['reverse_proxy'] = TRUE;
    $settings['reverse_proxy_addresses'] = array($_SERVER['REMOTE_ADDR']);
    $settings['reverse_proxy_header'] = 'X_FORWARDED_FOR';
    $settings['reverse_proxy_proto_header'] = 'X_FORWARDED_PROTO';
    // trusted_host_patterns
    $settings['trusted_host_patterns'] = array(
      '^api\.yongbuzhixi\.com$',
      '^api\.aws\.yongbuzhixi\.com$',
      '^api\.staging\.yongbuzhixi\.com$'
    );
    // $settings['update_free_access'] = TRUE;
    $settings['file_private_path'] = '/tmp/files/private'; 