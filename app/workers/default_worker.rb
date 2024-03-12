class DefaultWorker
  include Sidekiq::Worker

  def perform(name)
    puts "DefaultWorker: Hello, #{name}!"
  end
end