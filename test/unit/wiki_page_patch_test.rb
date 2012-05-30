# -*- encoding : utf-8 -*-
require File.expand_path(File.dirname(__FILE__) + '/../test_helper')
require File.expand_path('test/unit/wiki_page_test', Rails.root)

class WikiPagePatchTest < WikiPageTest
  include FactoryGirl::Syntax::Methods

  subject { WikiPage.new }
  should_not allow_mass_assignment_of :private

  context "PrivateWikiPlugin" do
    def setup
      project = create(:project)
      wiki = create(:wiki, :project => project)
      @wiki_page = create(:wiki_page, :wiki => wiki, :private => true)
      user = User.current = create(:user)
      @role = create(:role, :permissions => [:view_wiki_pages])
      create(:member, :principal => user, :project => project, :roles => [@role])
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