module PrivateWiki
  module WikiControllerPatch
    def self.included(base)
      base.send(:include, InstanceMethods)
      base.class_eval do
        unloadable
        before_filter :authorize_private_page, :only => [:rename, :protect, :history, :diff, :annotate, :add_attachment, :destroy]
        alias_method_chain :show, :private_wiki
      end
    end

    module InstanceMethods

      def show_with_private_wiki
        show_without_private_wiki
        authorize_private_page
      end

      def change_privacy
        find_existing_page
        @page.update_attribute :private, params[:private]
        redirect_to :action => 'show', :project_id => @project, :id => @page.title
      end

      private
      def authorize_private_page
        if @page.private and !User.current.allowed_to?(:view_private_wiki_pages, @project)
          render_403
        end
      end
    end
  end
end