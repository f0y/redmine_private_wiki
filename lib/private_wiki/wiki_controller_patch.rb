module PrivateWiki
  module WikiControllerPatch
    def self.included(base)
      base.send(:include, InstanceMethods)
      base.class_eval do
        unloadable
        alias_method_chain :show, :private_wiki
      end
    end

    module InstanceMethods

      def show_with_private_wiki
        if @page.private and !@page.is_private_page_visible?(@project)
          return deny_access
        end
        show_without_private_wiki
      end

      def change_privacy
        find_existing_page
        @page.update_attribute :private, params[:private]
        redirect_to :action => 'show', :project_id => @project, :id => @page.title
      end
    end
  end
end