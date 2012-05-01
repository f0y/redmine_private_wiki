# -*- encoding : utf-8 -*-
require File.expand_path('../../../../test_helper', __FILE__)

require_dependency 'wiki_page'
class ProjectRolesPlugin::WikiPagePatchTest < ActiveSupport::TestCase

  subject { WikiPage.new }

  # Based on WikiPageDropTest
  def setup
    @project = Project.generate!
    @wiki = Wiki.generate(:project => @project)
    @wiki_page = WikiPage.generate!(:wiki => @wiki) do |page|
      page.private = true
    end
    User.current = @user = User.generate!
    @role = Role.generate!(:permissions => [:view_wiki_pages])
    Member.generate!(:principal => @user, :project => @project, :roles => [@role])
  end

  should_not_allow_mass_assignment_of :private

  context "#visible?" do
    should "not be visible without permission" do
      assert @wiki_page.private
      assert !@wiki_page.visible?
    end

    should "be visible with permission" do
      @role.add_permission! :view_private_wiki_pages
      User.current.reload

      assert @wiki_page.visible?
    end

    should_eventually "respect private pages in upper hierarchy" do

    end

  end

end
