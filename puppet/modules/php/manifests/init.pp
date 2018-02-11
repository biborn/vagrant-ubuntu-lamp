# == Class: php
#
# Installs php7.1 and necessary modules. Sets config files.
#
class php {

  apt::ppa:
  'ppa:ondrej/php':
    ensure: 'present'

  package { ['php7.1',
             'php7.1-cli',
             'libapache2-mod-php7.1',
             'php-apc',
             'php7.1-curl',
             'php7.1-dev',
             'php7.1-gd',
             'php7.1-imagick',
             'php7.1-mcrypt',
             'php7.1-memcache',
             'php7.1-mysql',
             'php7.1-pspell',
             'php7.1-sqlite',
             'php7.1-tidy',
             'php7.1-xdebug',
             'php7.1-xmlrpc',
             'php7.1-xsl']:
    ensure => present;
  }

  file {
    '/etc/php/7.1/apache2':
      ensure => directory,
      before => File ['/etc/php/7.1/apache2/php.ini'];

    '/etc/php/7.1/apache2/php.ini':
      source  => 'puppet:///modules/php/apache2-php.ini',
      require => Package['php7.1'];

    '/etc/php/7.1/cli':
      ensure => directory,
      before => File ['/etc/php/7.1/cli/php.ini'];

    '/etc/php/7.1/cli/php.ini':
      source  => 'puppet:///modules/php/cli-php.ini',
      require => Package['php7.1-cli'];
  }
}
