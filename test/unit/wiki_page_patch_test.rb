# -*- encoding : utf-8 -*-
require File.expand_path(File.dirname(__FILE__) + '/../test_helper')
require File.expand_path('test/unit/wiki_page_test', Rails.root)

class WikiPagePatchTest < WikiPageTest

  subject { WikiPage.new }
  should_not_allow_mass_assignment_of :private

  context "PrivateWikiPlugin" do
    setup do
      @project = Project.generate!
      @wiki = Wiki.generate(:project => @project)
      @wiki_page = WikiPage.generate!(:wiki => @wiki) do |page|
        page.private = true
      end
      User.current = @user = User.generate!
      @role = Role.generate!(:permissions => [:view_wiki_pages])
      Member.generate!(:principal => @user, :project => @project, :roles => [@role])
    end

    context "#visible?" do

      should "not be visible without permission" do
        assert @wiki_page.private
        assert !@wiki_page.visible?
      end

      should "be visible with permission" do
        @role.add_permission! :view_private_wiki_pages
        assert @wiki_page.visible?
      end

    end
  end

end