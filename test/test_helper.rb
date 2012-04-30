# -*- encoding : utf-8 -*-
# Load the normal Rails helper
require File.expand_path('../../../../test/test_helper', File.dirname(__FILE__))

# Ensure that we are using the temporary fixture path
Engines::Testing.set_fixture_path

# Load custom exemplars
#Dir[File.dirname(__FILE__) + '/exemplars/*.rb'].each { |file| require file }

