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

  unless Redmine::WikiFormatting::Macros::Definitions.included_modules.include? PrivateWiki::MacrosPatch
    Redmine::WikiFormatting::Macros::Definitions.send(:include, PrivateWiki::MacrosPatch)
  end
end

Redmine::Plugin.register :redmine_private_wiki do
  name 'Private Wiki'
  author 'Oleg Kandaurov'
  description 'Adds private pages to wiki'
  version '0.1.1'
  author_url 'http://f0y.me'
  requires_redmine :version => ['1.4.0', '1.4.1', '1.4.2', '1.4.3', '1.4.4', '1.4.5', '1.4.6', '1.4.7', '1.4.8', '1.4.9']

  project_module :wiki do
    permission :view_private_wiki_pages, {}
    permission :manage_private_wiki_pages, {:wiki => :change_privacy}, :require => :member
  end

end
