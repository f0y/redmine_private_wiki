module PrivateWiki
  module WikiPagePatch
    def self.included(base)
      base.send(:include, InstanceMethods)
      base.class_eval do
        unloadable

        attr_protected :private
        #after_initialize :set_parent_private
        alias_method_chain :visible?, :private_wiki
      end
    end

    module InstanceMethods

      #def set_parent_private
      #  if new_record? && parent
      #    self.private = parent.private
      #  end
      #end

      def private_with_ancestors
        self.private || ancestors.detect { |anc| anc.private }
      end

      def private_page_visible?(project, user)
        !user.nil? && user.allowed_to?(:view_private_wiki_pages, project)
      end

      def visible_with_private_wiki?(user=User.current)
        allowed = visible_without_private_wiki?(user)
        if allowed and self.private_with_ancestors
          return private_page_visible?(project, user)
        end
        allowed
      end

    end
  end
end