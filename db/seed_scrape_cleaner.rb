require_relative 'seed_data'

puts_counter = 1
CLEAN_OFFICE_ARRAY = []
POSTAL_CODES.each do |plz|
  scraped_website_page_counter = 0
  url = "https://www.ak-berlin.de/nc/mitgliedersuche/mitglieder.html?tx_sisimembers_memberlist%5Bmember%5D%5Bfachrichtung%5D=A&tx_sisimembers_memberlist%5Bmember%5D%5Bplz%5D=#{plz}&tx_sisimembers_memberlist%5Bmember%5D%5Bliste%5D=K&tx_sisimembers_memberlist%5Bmember%5D%5Barea%5D=K"
  append_url = '&tx_sisimembers_memberlist%5B%40widget_0%5D%5BcurrentPage%5D=2'
  dirty_office_array = []

  while scraped_website_page_counter <= 2

    html_file = open(url).read
    html_doc = Nokogiri::HTML(html_file)

    n_items_page = 1
    root_xpath = '/html/body/div[1]/div[2]/div/section/div[2]/div/div'

    while n_items_page <= 50
      studio = { external_name:     html_doc.xpath("#{root_xpath}/ul[#{n_items_page}]/li/div[1]").text.strip,
                 external_location: html_doc.xpath("#{root_xpath}/ul[#{n_items_page}]/li/div[3]/div[4]").text.strip + ', ' +
                           html_doc.xpath("#{root_xpath}/ul[#{n_items_page}]/li/div[3]/div[5]").text.strip,
                 external_url:      html_doc.xpath("#{root_xpath}/ul[#{n_items_page}]/li/div[3]/div[8]/a").text.strip }
      n_items_page += 1
      dirty_office_array << studio
    end
    url += append_url
    scraped_website_page_counter += 1
  end
  office_names = []
  office_urls = []
  dirty_office_array.each do |cleaned_studio|
    if cleaned_studio[:external_name] == ''
      cleaned_studio.delete(cleaned_studio)
    elsif office_names.include?(cleaned_studio[:external_name])
      cleaned_studio.delete(cleaned_studio)
    elsif office_urls.include?(cleaned_studio[:external_url])
      cleaned_studio.delete(cleaned_studio)
    elsif cleaned_studio[:external_location] == ''
      cleaned_studio.delete(cleaned_studio)
    elsif cleaned_studio[:external_url] == ''
      cleaned_studio.delete(cleaned_studio)
    elsif cleaned_studio[:external_url].nil?
      cleaned_studio.delete(cleaned_studio)
    elsif cleaned_studio[:external_url].include? 'http.//'
      cleaned_studio.delete(cleaned_studio)
    elsif cleaned_studio[:external_url].include? 'htp'
      cleaned_studio.delete(cleaned_studio)
    elsif cleaned_studio[:external_url].include? 'http//:'
      cleaned_studio.delete(cleaned_studio)
    elsif cleaned_studio[:external_url].include? 'at'
      cleaned_studio.delete(cleaned_studio)
    else
      CLEAN_OFFICE_ARRAY << cleaned_studio
    end
      office_names << cleaned_studio[:external_name]
      office_urls << cleaned_studio[:external_url]
  end
  puts "Scraped #{puts_counter} Postal Code out of #{POSTAL_CODES.size} Postal Codes"
  puts_counter += 1

end
