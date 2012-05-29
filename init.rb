require 'redmine'
require 'private_wiki/hook'

require 'dispatcher'
Dispatcher.to_prepare :redmine_private_wiki do
  unless WikiPage.included_modules.include? PrivateWiki::WikiPagePatch
    WikiPage.send(:include, PrivateWiki::WikiPagePatch)
  end

  unless WikiController.included_modules.include? PrivateWiki::WikiControllerPatch
    WikiController.send(:include, PrivateWiki::WikiControllerPatch)
  end
end

Redmine::Plugin.register :redmine_private_wiki do
  name 'Private Wiki'
  author 'Oleg Kandaurov'
  description 'Adds private pages to wiki'
  version '0.0.1'
  author_url 'http://okandaurov.info'

  project_module :wiki do
    permission :view_private_wiki_pages, {}
    permission :manage_private_wiki_pages, {:wiki => :change_privacy}, :require => :member
  end

end
