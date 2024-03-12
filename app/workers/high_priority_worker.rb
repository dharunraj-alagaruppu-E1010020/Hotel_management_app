class HighPriorityWorker
  include Sidekiq::Worker
  sidekiq_options queue: :high_priority

  def perform(name)
    byebug
    puts "HighPriorityWorker: Hello, #{name}!"
  end
end