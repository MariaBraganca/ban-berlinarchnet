require_relative 'seed_scrape_cleaner'
# require 'open-uri'
# require 'nokogiri'
IMG_URL = []
terminal_counter = 1
PHOTO_OFFICE_ARRAY_DASHED.each do |suffix|
  begin
    url = "https://www.archdaily.com/office/#{suffix[:external_name]}"
    html_file = open(url).read
    html_doc = Nokogiri::HTML(html_file)
    img_xpath = '/html/body/div[4]/div/div[1]/div[2]/a/div/@style'
    n_office_projects_xpath = '/html/body/div[4]/div/div[1]/div[1]/div[1]/div[2]/span'
    puts "#{terminal_counter} Office for images checked"
    terminal_counter += 1
    dirty_string = html_doc.xpath(img_xpath).text
    dirty_string.gsub!('background-image: url(', '')
    dirty_string.gsub!(')', '')
    suffix[:banner_url] = dirty_string
    n_office_projects = html_doc.xpath(n_office_projects_xpath).text
    suffix[:projects_array] = []
    scrape_counter = 1
    n_office_projects.to_i.times do
      sleep(5)
                      suffix[:projects_array] <<  {
                      project_name: html_doc.xpath("/html/body/div[4]/div/div[2]/div[2]/div[#{scrape_counter}]/div/h3/a").text,
                      project_img_url: html_doc.xpath("/html/body/div[4]/div/div[2]/div[2]/div[#{scrape_counter}]/a/div/div[1]/div[1]/div/img/@src").text,
                      project_year: html_doc.xpath("/html/body/div[4]/div/div[2]/div[2]/div[#{scrape_counter}]/div/ul/div/ul/li[3]/span[2]/a").text,
                      project_typology: html_doc.xpath("/html/body/div[4]/div/div[2]/div[2]/div[#{scrape_counter}]/div/ul/div/ul/li[3]/span[2]/a").text
                      }
                      scrape_counter += 1
      end
  rescue OpenURI::HTTPError => ex
  end
end


CLEAN_OFFICE_ARRAY.each do |clean_office|
  PHOTO_OFFICE_ARRAY_DASHED.each do |url_hash|
  clean_office[:banner_url] = url_hash.delete(:banner_url) if clean_office[:id] == url_hash[:id]
  clean_office[:projects_array] = url_hash.delete(:projects_array) if clean_office[:id] == url_hash[:id]
end
end
