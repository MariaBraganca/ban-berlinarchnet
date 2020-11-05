require 'open-uri'
require 'json'
require 'watir'

class BaunetzScraper
  def self.get_office_projects(office_link, office)
    url = "https://www.baunetz-architekten.de#{office_link}"

    html_string = open(url).read
    html_doc = Nokogiri::HTML(html_string)

    office_banner = html_doc.css('div.profile-image__image').css('img').attribute('src').value
    office[:banner_url] = office_banner

    projects = []
    project = {}

    html_doc.css('a.teaser-item--project').take(4).each do |element|
      project_name = element.css('div.teaser-item__headline').children.text
      project_img_url = element.css('img.teaser-item-image__image').attribute('src').value

      project = { project_name: project_name, project_img_url: project_img_url }
      puts "#{project_name}"

      projects << project
    end

    office[:projects] = projects
  end

  def self.get_office_description(office_link, office)
    url = "https://www.baunetz-architekten.de#{office_link}"

    html_string = open(url).read
    html_doc = Nokogiri::HTML(html_string)

    office_description = html_doc.css('div.profile-meta__text').children.text.strip

    office[:description] = office_description
  end

  def self.get_office_contact(office_link, office)
    url = "https://www.baunetz-architekten.de#{office_link}"

    html_string = open(url).read
    html_doc = Nokogiri::HTML(html_string)

    office_street = html_doc.css('div.profile-meta-contact').children[2].text.strip
    office_zip = html_doc.css('div.profile-meta-contact').children[4].text.strip

    office[:location] = "#{office_street}, #{office_zip}"

    office_url = html_doc.css('a:contains("www")').attribute('href').value

    office[:url] = office_url
  end

  def self.get_offices
    url = "https://www.baunetz-architekten.de"

    html_string = open(url).read
    html_doc = Nokogiri::HTML(html_string)

    offices = []
    office = {}

    html_doc.css('a.abc-architect-link').each do |element|
      office_name = element.css('span.abc-name').text
      office_link = element.attribute('href').value

      office = { name: office_name }
      puts "=== #{office_name} ==="

      get_office_contact(office_link, office)

      get_office_description(office_link, office)

      get_office_projects(office_link, office)

      offices << office
    end

    offices.uniq!{ |office| office[:name].downcase }
    offices.uniq!{ |office| office[:url] }
    offices.sort_by!{ |office| office[:name] }

    p offices.count

    json = JSON.pretty_generate(offices)
    File.open("db/offices.json", 'w') { |file| file.write(json) }
  end
end
