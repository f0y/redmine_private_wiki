module PrivateWiki
  module WikiPagePatch
    def self.included(base)
      base.send(:include, InstanceMethods)
      base.class_eval do
        unloadable

        attr_protected :private
        alias_method_chain :visible?, :private_wiki
      end
    end

    module InstanceMethods

      def is_private_page_visible?(project, user)
        !user.nil? && user.allowed_to?(:view_private_wiki_pages, project)
      end

      def visible_with_private_wiki?(user=User.current)
        if self.private and !is_private_page_visible?(@project, user)
          return false
        end
        visible_without_private_wiki?(user)
      end

    end
  end
end