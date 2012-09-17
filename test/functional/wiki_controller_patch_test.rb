# -*- encoding : utf-8 -*-
require File.expand_path('../../test_helper', __FILE__)

# Re-raise errors caught by the controller.
class WikiController;
  def rescue_action(e)
    raise e
  end
end

require File.expand_path('test/functional/wiki_controller_test', Rails.root)

class WikiControllerPatchTest < WikiControllerTest

  fixtures :projects, :users, :roles, :members, :member_roles, :enabled_modules, :wikis, :wiki_pages, :wiki_contents, :journals, :attachments, :enumerations

  context "PrivateWikiPlugin" do
    setup do
      @controller = WikiController.new
      @request = ActionController::TestRequest.new
      @response = ActionController::TestResponse.new
      User.current = nil
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

        should "not contains private label" do
          assert_no_tag :tag => 'span', :attributes => {:class => 'private'}
        end
      end

      context "with permission" do
        setup do
          Role.find(1).add_permission! :view_private_wiki_pages
          get :show, :project_id => @project, :id => @page.title
        end

        should_respond_with :success

        should "contains private label" do
          assert_tag :tag => 'span', :attributes => {:class => 'private'}
        end
      end

    end

    context "POST change privacy" do
      setup do
        Role.find(1).add_permission! :view_private_wiki_pages
      end

      context "without permission" do
        setup do
          post :change_privacy, :project_id => @project, :id => @page.title, :private => 0
        end
        should_respond_with 403
      end

      context "with permission" do
        setup do
          assert @page.private
          Role.find(1).add_permission! :manage_private_wiki_pages
          post :change_privacy, :project_id => @project, :id => @page.title, :private => 0
        end

        should redirect_to("project_wiki") { project_wiki_path(@project, @page.title) }

        should "change page's privacy" do
          assert !@page.reload.private
        end
      end

    end

    context "#authorize_private_page" do
      {:rename => :get, :edit => :get, :update => :put, :protect => :post, :history => :get,
       :diff => :get, :annotate => :get, :add_attachment => :post, :destroy => :delete}.each do |action, verb|
        context "#{verb.to_s.upcase} #{action}" do
          setup do
            self.send verb, action, :project_id => @project, :id => @page.title, :version => 1
          end
          should respond_with 403
        end
      end

    end

  end
end