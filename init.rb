require 'redmine'
require_dependency 'private_wiki/hook'

Rails.configuration.to_prepare do

  require_dependency 'wiki_page'
  unless WikiPage.included_modules.include? PrivateWiki::WikiPagePatch
    WikiPage.send(:include, PrivateWiki::WikiPagePatch)
  end

  require_dependency 'wiki_controller'
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
  version '0.2.1'
  author_url 'http://f0y.me'
  requires_redmine :version => ['2.0.0', '2.0.1', '2.0.2', '2.0.3', '2.0.4', '2.0.5', '2.0.6', '2.0.7', '2.0.8', '2.0.9']

  project_module :wiki do
    permission :view_private_wiki_pages, {}
    permission :manage_private_wiki_pages, {:wiki => :change_privacy}, :require => :member
  end

end
