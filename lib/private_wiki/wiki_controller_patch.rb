module PrivateWiki
  module WikiControllerPatch
    def self.included(base)
      base.send(:include, InstanceMethods)
      base.class_eval do
        unloadable
        before_filter :authorize_private_page, :only => [:rename, :protect, :history, :diff, :annotate, :add_attachment, :destroy]
        alias_method_chain :show, :private_wiki
        alias_method_chain :edit, :private_wiki
        alias_method_chain :update, :private_wiki
      end
    end

    module InstanceMethods

      def show_with_private_wiki
        show_without_private_wiki
        authorize_private_page
      end

      def edit_with_private_wiki
        edit_without_private_wiki
        unless @page.new_record?
          authorize_private_page
        end
      end

      def update_with_private_wiki
        find_existing_or_new_page
        if @page
          success = authorize_private_page
          return false unless success
        end
        update_without_private_wiki
      end

      def change_privacy
        find_existing_page
        @page.update_attribute :private, params[:private]
        redirect_to project_wiki_path(@project, @page.title)
      end

      private
      def authorize_private_page
        if @page.private and !@page.private_page_visible?(@project, User.current)
          self.response_body = nil  #Prevent double render error
          deny_access
        else
          true
        end
      end

    end
  end
end