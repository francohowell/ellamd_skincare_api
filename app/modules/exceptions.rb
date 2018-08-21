##
# We define custom application-specific Exceptions in this module.
#
# rubocop:disable Style/ClassAndModuleChildren
module Exceptions
  ##
  # A catch-all ApplicationError for general application-specific errors.
  class ApplicationError < StandardError; end

  class NotAuthorizedError < ApplicationError; end
end
