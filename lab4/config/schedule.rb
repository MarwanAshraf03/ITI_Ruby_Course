env :PATH, ENV["PATH"]
set :environment, "development"
set :output, "log/cron.log"

every 5.minutes do
  rake "remove_hated_articles"
end
