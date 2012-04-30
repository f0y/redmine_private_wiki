# -*- encoding : utf-8 -*-
require File.expand_path('../../test_helper', __FILE__)

# Reuse the default test
require File.expand_path('test/functional/wiki_controller_test', RAILS_ROOT)

class WikiControllerTest < ActionController::TestCase

  fixtures :projects, :users, :roles, :members, :member_roles, :enabled_modules, :wikis, :wiki_pages, :wiki_contents, :journals, :attachments, :enumerations

  context "PrivateWikiPlugin" do
    setup do
      @project = Project.find(1)
      @request.session[:user_id] = 2
      @page = @project.wiki.find_page('Another_page')
    end

    context "#authorize_private_page" do
      setup do
        @page.private = true
        @page.save!
      end

      context "without permission" do

      end

      context "with permission" do
        Role.find(1).add_permission! :manage_project_roles
      end

    end

    #context "GET show" do
    #  setup do
    #    get :show
    #  end
    #
    #  should "not include local roles" do
    #    assert_include assigns(:roles), @global_role
    #    assert_not_include assigns(:roles), @local_role
    #  end
    #end


  end


end
