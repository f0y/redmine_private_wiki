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
      @wiki = @project.wiki
      @page = @wiki.find_page('Another_page')
      @page.private = true
      @page.save!
    end

    context "GET show" do

      context "without permission" do
        setup do
          get :show, :project_id => @project, :id => @page.title
        end
        should_respond_with 403
      end

      context "with permission" do
        setup do
          Role.find(1).add_permission! :view_private_wiki_pages
          get :show, :project_id => @project, :id => @page.title
        end
        should_respond_with :success
      end

      context "public subpage" do
        setup do
          @subpage = @page.children.generate!(:wiki => @wiki) do |page|
            page.private = false
          end
          get :show, :project_id => @project, :id => @subpage.title
        end
        should_respond_with 403
      end

    end

    context "#authorize_private_page" do

    end

  end


end
