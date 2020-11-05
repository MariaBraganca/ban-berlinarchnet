require 'open-uri'
require 'json'
require 'watir'

class BaunetzScraperBerlin
  def self.get_office_projects(html_doc, office)
    office_banner = html_doc.css('div.profile-image__image').css('img').attribute('src').value
    office[:banner_url] = office_banner

    projects = []
    project = {}

    html_doc.css('a.teaser-item--project').take(4).each do |element|
      project_name = element.css('div.teaser-item__headline').children.text
      project_img_url = element.css('img.teaser-item-image__image').attribute('src').value

      project = { project_name: project_name, project_img_url: project_img_url }
      puts "- #{project_name}"

      projects << project
    end

    office[:projects] = projects
  end

  def self.get_office_description(html_doc, office)
    office_description = html_doc.css('div.profile-meta__text').children.text.strip

    office[:description] = office_description
  end

  def self.get_office_contact(html_doc, office, url)
    office_name = html_doc.css('h1.profile__title').text.strip
    puts ""
    puts "// #{office_name}"

    if html_doc.css('div.profile-meta-contact__switch').find{|e| e.text.include?("Berlin")}.attribute('class').value.include?("profile-meta-contact__switch--active")
      office_street = html_doc.css('div.profile-meta-contact--active').children.find{|e| e.text =~ /[a-zäöüß-]+[\s[a-zäöüß-]]*.?\s+\d+/i}.text[/[a-zäöüß-]+[\s[a-zäöüß-]]*.?\s+\d+/i]
      office_zip = html_doc.css('div.profile-meta-contact--active').children.find{|e| e.text =~ /\d+\s+\w+/i}.text[/\d+\s+\w+/i]

      puts "#{office_street}, #{office_zip}"
    else
      browser = Watir::Browser.new
      browser.goto("#{url}")
      browser.div(class: 'profile-meta-contact__switch', text: 'Berlin').click

      office_street = browser.div(class: 'profile-meta-contact--active').text[/[\r\n]+[a-zäöüß-]+[\s[a-zzäöüß-]]*.?\s+\d+/i][/[a-zäöüß-]+[\s[a-zäöüß-]]*.?\s+\d+/i]
      office_zip = browser.div(class: 'profile-meta-contact--active').text[/[\r\n]+(\w\W)?\d+\s+\w+/i][/\d+\s+\w+/i]

      browser.close

      puts "#{office_street}, #{office_zip}"
    end

    office[:name] = office_name
    office[:location] = "#{office_street}, #{office_zip}"

    office_url = html_doc.css('a:contains("www")').attribute('href').value[/(?:[a-z0-9](?:[a-z0-9-]{0,61}[a-z0-9])?\.)+[a-z0-9][a-z0-9-]{0,61}[a-z0-9]/]
    puts "#{office_url}"

    office[:url] = office_url
  end

  def self.get_offices
    index_url = "https://www.baunetz-architekten.de"

    index_html_string = open(index_url).read
    index_html_doc = Nokogiri::HTML(index_html_string)

    offices = []
    office = {}

    index_html_doc.css('a.abc-architect-link').each do |element|
      office_link = element.attribute('href').value

      url = "https://www.baunetz-architekten.de#{office_link}"

      html_string = open(url).read
      html_doc = Nokogiri::HTML(html_string)

      next if html_doc.css('div.profile-meta-contact__switch').children.find{|e| e.text == "Berlin"}.nil?

      office = { baunetz_link: office_link }

      get_office_contact(html_doc, office, url)

      get_office_description(html_doc, office)

      get_office_projects(html_doc, office)

      offices << office
    end

    offices.uniq!{ |office| office[:name].downcase }
    offices.uniq!{ |office| office[:url] }
    offices.sort_by!{ |office| office[:name] }

    puts "#{offices.count} offices were scraped!"

    json = JSON.pretty_generate(offices)
    File.open("db/offices.json", 'w') { |file| file.write(json) }
  end
end
