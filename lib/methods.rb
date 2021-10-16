require 'csv'

def display_list(gift_list)
  # iterate .each_with_index do |(key, value), index|
  # format the text:
  # 1 - [ ] sockets
  # 2 - [X] ruby book
  # 3 - [ ] macbook pro
  gift_list.each_with_index do |(item, purchased), index|
    x_mark = purchased ? 'X' : ' '
    puts "#{index + 1} - [#{x_mark}] #{item}"
  end
end

def load_csv
  csv_options = { col_sep: ',', quote_char: '"', headers: :first_row }
  filepath    = 'lib/gifts.csv'
  gift_list = {}

  CSV.foreach(filepath, csv_options) do |row|
    # TODO: build new gift from information stored in each row
    purchased = row[1] == 'true'
    gift_list[row[0]] = purchased
  end
  gift_list
end

def save_csv(gift_list)
  csv_options = { col_sep: ',', force_quotes: true, quote_char: '"' }
  filepath    = 'lib/gifts.csv'

  CSV.open(filepath, 'wb', csv_options) do |csv|
    # We had headers to the CSV
    csv << ['item','purchased']
    # TODO: store each gift
    gift_list.each do |item, purchased|
      csv << [item, purchased]
    end
  end
end
