# -*- encoding : utf-8 -*-
require File.expand_path(File.dirname(__FILE__) + '/../test_helper')
require File.expand_path('test/unit/lib/redmine/wiki_formatting/macros_test', Rails.root)

class MacrosPatchTest < Redmine::WikiFormatting::MacrosTest


  context "PrivateWikiPlugin" do
    setup do
      @project = Project.find(1)
      @private_page = @project.wiki.find_page('Another_page')
      @private_page.private = true
      @private_page.save!
      User.current = User.find(2)
    end

    should "not be visible without permission" do
      text = "{{include(Another page)}}"
      assert textilizable(text).match(/Access to page is denied/)
    end

    should "be visible with permission" do
      Role.find(1).add_permission! :view_private_wiki_pages
      text = "{{include(Another page)}}"
      assert textilizable(text).match(/This is a link to a ticket/)
    end

  end

end

