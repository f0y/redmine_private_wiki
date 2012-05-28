# -*- encoding : utf-8 -*-
require File.expand_path(File.dirname(__FILE__) + '/../../../test_helper')


class PrivateWiki::WikiPagePatchTest < ActiveSupport::TestCase

  def setup
    project = FactoryGirl.create(:project)
    wiki = FactoryGirl.create(:wiki, :project => project)
    @wiki_page = FactoryGirl.create(:wiki_page, :wiki => wiki, :private => true)
    user = User.current =  FactoryGirl.create(:user)
    @role = FactoryGirl.create(:role, :permissions => [:view_wiki_pages])
    FactoryGirl.create(:member, :principal => user, :project => project, :roles => [@role])
  end

  #should_not_allow_mass_assignment_of :private


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