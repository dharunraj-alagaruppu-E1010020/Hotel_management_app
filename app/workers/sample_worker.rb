require 'sidekiq'
# require_relative '../controllers/user_controller'

class SampleWorker
  include Sidekiq::Worker

  # sidekiq_options queue: 'default', retry: 2

  # def perform(name)
  #   puts "Hello, #{name}!"
  #   # controller = UserController.new
  #   # # controller.sample_check
  #   # x =  controller.index
  #   # return true
  # end

  def perform()
    puts 'I am in the SampleWorker'
    HighPriorityWorker.perform_async('Alagar')
    DefaultWorker.perform_async('Dharun')
  end

end

