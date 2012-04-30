# -*- encoding : utf-8 -*-
require 'redmine'
require 'dispatcher'
Dispatcher.to_prepare :chiliproject_private_wiki do
  unless Wiki.included_modules.include? PrivateWiki::WikiPagePatch
    Wiki.send(:include, PrivateWiki::WikiPagePatch)
  end
  unless WikiPage.included_modules.include? PrivateWiki::WikiPagePatch
    WikiPage.send(:include, PrivateWiki::WikiPagePatch)
  end

  unless WikiController.included_modules.include? PrivateWiki::WikiControllerPatch
    WikiController.send(:include, PrivateWiki::WikiControllerPatch)
  end
end

Redmine::Plugin.register :chiliproject_private_wiki do
  name 'Private Wiki'
  author 'Oleg Kandaurov'
  description 'Allows wiki pages to be set as private'
  version '0.0.1'
  url 'https://github.com/jnv/chiliproject_private_wiki'
  author_url 'http://okandaurov.info'

  project_module :wiki do
    permission :view_private_wiki_pages, {}
    permission :manage_private_wiki_pages, {:wiki => :change_privacy}, :require => :member
  end

end
