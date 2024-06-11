require_relative 'event_manager'

event_manager = EventManager.new

# Define handlers for different actions
send_welcome_email = proc do |user|
  puts "Sending welcome email to #{user[:email]}"
end

log_signup = proc do |user|
  puts "User signed up: #{user[:name]}, #{user[:email]}"
end

# Subscribe the handlers
event_manager.subscribe(&send_welcome_email)
event_manager.subscribe(&send_welcome_email)
event_manager.subscribe(&log_signup)
event_manager.unsubscribe(&log_signup)

# Simulate a user sign-up and broadcast the event
new_user = { name: "John Doe", email: "john.doe@example.com" }
event_manager.broadcast(new_user)
