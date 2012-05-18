module PrivateWiki
  module WikiPatch
    def self.included(base)
      base.send(:include, InstanceMethods)
      base.class_eval do
        unloadable
        alias_method_chain :visible?, :private_wiki
      end
    end

    module InstanceMethods

      def is_private_page_visible?(project, user=User.current)
        !user.nil? && user.allowed_to?(:view_private_wiki_pages, project)
      end

      def visible_with_private_wiki?(user)
        if self.private and !is_private_page_visible?(project)
          return false
        end
        visible_without_private_wiki?
      end

    end
  end
end