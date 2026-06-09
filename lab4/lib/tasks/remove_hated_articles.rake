task remove_hated_articles: :environment do
  puts "remove hated articles #{Time.now}"
  count = Article.where(reports_count: 6...).delete_all
  puts "removed #{count} articles"
end
