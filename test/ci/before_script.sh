#!/bin/sh

# Git repo of the ChiliProject/Redmine

# Prepare ChiliProject
git clone --depth=100 $MAIN_REPO $TARGET_DIR
cd $TARGET_DIR
#git submodule update --init --recursive

# Copy over the already downloaded plugin 
cp -r ~/builds/*/$REPO_NAME vendor/plugins/$PLUGIN_DIR

#export BUNDLE_GEMFILE=$TARGET_DIR/Gemfile

bundle install $BUNDLER_ARGS

echo "creating $DB database"
case $DB in
  "mysql" )
    mysql -e 'create database chiliproject_test;'
    cat > config/database.yml << EOF
test:
  adapter: mysql2
  username: root
  encoding: utf8
  database: chiliproject_test
EOF
    ;;
  "postgres" )
    psql -c 'create database chiliproject_test;' -U postgres
    cat > config/database.yml << EOF
test:
  adapter: postgresql
  database: chiliproject_test
  username: postgres
EOF
    ;;
esac

bundle exec rake db:migrate
bundle exec rake db:migrate:plugins
