require_relative 'methods'
require_relative 'scraper'

gift_list = load_csv
# Welcome the user
puts 'Welcome to the Christmas List!'

action = nil
# Ask user what action they want to do
until action == 'quit'
  puts 'Which action [list|add|delete|mark|idea|quit]?'
  # Store the user answer in a variable
  action = gets.chomp
  # Direct the user to the correct action (if/else - case)
  case action
  when 'list'
    display_list(gift_list)
  when 'add'
    # Ask the user what they want to add
    puts 'What do you want to add?'
    # gift = get user answer
    gift = gets.chomp
    # Add the gift to gift_list hash_name[new_key] = value
    gift_list[gift] = false
    # Puts a message 'gift added to the list'
    puts "#{gift.capitalize} was added to the list"
    save_csv(gift_list)
  when 'delete'
    # Display the list again (create display_list method)
    display_list(gift_list)
    # Ask what to delete (number/index)
    puts 'What gift do you want to delete? (Input a number)'
    # index = get user answer (integer/index)
    index = gets.chomp.to_i - 1
    # gift = get the gift to delete somehow... using the index (.keys)
    gifts = gift_list.keys
    gift = gifts[index]
    # Remove the gift from the hash (CRUD DELETE)
    gift_list.delete(gift)
    # Tell the user the gift was deleted
    puts "#{gift} was deleted"
    save_csv(gift_list)
  when 'mark'
    # Display the list again (create display_list method)
    display_list(gift_list)
    # Ask what to delete (number/index)
    puts 'What gift do you want to mark as bought? (Input a number)'
    # index = get user answer (integer/index)
    index = gets.chomp.to_i - 1
    # gift = get the gift to delete somehow... using the index (.keys)
    gifts = gift_list.keys
    gift = gifts[index]
    # Change the value of the gift in the hash (CRUD UPDATE)
    gift_list[gift] = !gift_list[gift]
    # Tell the user the gift was marked
    puts "#{gift} was updated!"
    save_csv(gift_list)
  when 'idea'
    # Ask user what to search
    puts 'What are you searching for on Etsy?'
    # keyword = get user answer
    keyword = gets.chomp
    # Turn scraper into a method - scraper.rb
    # Scrape etsy for 5 ideas
    # etsy_results = Scraper method should return a hash
    etsy_results = scrape(keyword)
    # display results using display_list
    display_list(etsy_results)
    # Ask user for a number (index)
    puts 'What gift would you like to import? (Input a number)'
    index = gets.chomp.to_i - 1
    # Find the etsy item to import
    etsy_gifts = etsy_results.keys
    gift = etsy_gifts[index]
    # Add the gift to the gift_list (CRUD CREATE)
    gift_list[gift] = false
    # Tell the user gift was added
    puts "#{gift} was added to the list!"
    save_csv(gift_list)
  when 'quit'
    puts 'Goodbye!'
    # save_csv(gift_list)
  else
    puts 'Sorry, wrong action. Try again.'
  end
end
