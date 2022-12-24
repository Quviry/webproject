# frozen_string_literal: true

# Application models highest abstraction
class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class
end
