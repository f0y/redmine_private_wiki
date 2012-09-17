# Private Wiki plugin for Redmine

Allows individual wiki pages to be set as private. Private pages are visible only to roles with "View private wiki pages" permission.
http://www.redmine.org/plugins/private_wiki

![Wiki Page](https://github.com/f0y/redmine_private_wiki/raw/devel/doc/private_wiki.png)

## ChiliProject

If you are using ChiliProject you must take a look at plugin https://github.com/jnv/chiliproject_private_wiki by Jan Vlnas
which is a fork of current plugin. ChiliProject plugin offers different functionality. If you want some of its features, please let me know.

## Compatibility

There are few versions of the plugin:
* redmine-1.4 for Redmine 1.4.x
* redmine-2.0 for Redmine 2.0.x
* redmine-2.1 for Redmine 2.1.x and highe

## Installation

    cd /home/user/path_to_you_app/
    git clone git://github.com/f0y/redmine_private_wiki.git plugins/redmine_private_wiki
    cd plugins/redmine_private_wiki; git checkout <YOUR BRANCH HERE - see above>

For Redmine 1.4.x

    bundle exec rake db:migrate_plugins RAILS_ENV=production

For Redmine 2.x and higher

    bundle exec rake redmine:plugins:migrate RAILS_ENV=production

Also you can read instructions on http://www.redmine.org/projects/redmine/wiki/Plugins

## License

This plugin is licensed under the MIT license.
