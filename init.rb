require 'redmine'
require 'private_wiki/hook'
require 'private_wiki/wiki_patch'
require 'private_wiki/wiki_controller_patch'

Rails.configuration.to_prepare do
  unless Wiki.included_modules.include? PrivateWiki::WikiPatch
    Wiki.send(:include, PrivateWiki::WikiPatch)
  end
  unless WikiPage.included_modules.include? PrivateWiki::WikiPatch
    WikiPage.send(:include, PrivateWiki::WikiPatch)
  end

  unless WikiController.included_modules.include? PrivateWiki::WikiControllerPatch
    WikiController.send(:include, PrivateWiki::WikiControllerPatch)
  end
end

Redmine::Plugin.register :redmine_private_wiki do
  name 'Private Wiki'
  author 'Oleg Kandaurov'
  description 'Adds private pages to wiki'
  version '0.3'
  author_url 'http://okandaurov.info'
  requires_redmine :version_or_higher => '2.0.0'

  project_module :wiki do
    permission :view_private_wiki_pages, {}
    permission :manage_private_wiki_pages, {:wiki => :change_privacy}, :require => :member
  end

end
