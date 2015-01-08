require_relative 'scrapper'

link = 'http://ardroid.com'

root = Scrapper::Links.new(link)
root.find

puts "Number of branches: #{root.links.size}"

root.links.each do |branch|
  b = Scrapper::Links.new(branch)
  b.find
  b.links.each do |branch_link|
    puts branch_link
  end
end
