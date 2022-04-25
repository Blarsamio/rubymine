# frozen_string_literal: true

require_relative 'post_repository'
require_relative 'controller'
require_relative 'router'

repository = PostRepository.new
controller = Controller.new(repository)

router = Router.new(controller)

router.run
