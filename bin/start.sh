# Gems Install
bundle check || echo "bundle install..." && bundle install

# Run Foreman Server
rm -f /rails/tmp/pids/server.pid && bundle exec rails s -b 0.0.0.0
