# Private Wiki plugin for ChiliProject

[![Build Status](https://secure.travis-ci.org/jnv/chiliproject_private_wiki.png?branch=master)](http://travis-ci.org/jnv/chiliproject_private_wiki)

Allows individual wiki pages to be set as private. Private pages are visible only to roles with "View private wiki pages" permission.

## Modifications in this fork

Plugin is based on [Redmine Private Wiki](https://github.com/f0y/redmine_private_wiki) by Oleg Kandaurov.

The main goal of this fork is to provide ChiliProject compatibility and test coverage.

- Privacy is checked for page's ancestors. If a parent page is private, all its descendants will be considered private too.
- Uses jQuery instead of Prototype.

## Installation

1. Follow the instructions at https://www.chiliproject.org/projects/chiliproject/wiki/Plugin_Install
2. Two new permissions will be available for roles: View private wiki pages and Manage private wiki pages (to manage privacy of the page)
3. Page can be changed to private using the contextual links on the wiki page

## Compatibility

Plugin was tested with ChiliProject 3.1.0 and Ruby 1.9.3.

## Development and testing

Patches, pull requests and forks are welcome, but if possible, provide proper test coverage.

Test suite uses [Shoulda](https://github.com/thoughtbot/shoulda/tree/v2.10.3).

To run tests, follow [Redmine's instructions](http://www.redmine.org/projects/redmine/wiki/Plugin_Tutorial#Initialize-Test-DB).

Due to [Engines compatibility bug](https://www.chiliproject.org/issues/944) the test suite won't work under Ruby 1.9 with standard ChiliProject distribution. You can replace ChiliProject's engines with [fixed version](https://github.com/jnv/engines).

You can also use [Travis-CI](http://travis-ci.org/) integration based on the [chiliproject_test_plugin](https://github.com/jnv/chiliproject_test_plugin).

## License

This plugin is licensed under the MIT license.
