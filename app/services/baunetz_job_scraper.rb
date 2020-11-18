require 'open-uri'
require 'json'

class BaunetzJobScraper
  def self.get_job_description(html_doc, job)
    job_description_selector = html_doc.at_css('div.job-detail-body div')

    if job_description_selector
      job_description = job_description_selector.text
    else
      job_description = html_doc.at_css('div.job-detail-body p').next_element.text
    end

    job[:job_description] = job_description
  end

  def self.get_office_contact(html_doc, job)
    url_regex = /^(www\.|http:\/\/|https:\/\/)[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/
    job_office_url_selector = html_doc.css('a.content_link').find{|l| l.attribute('href').value.downcase =~ url_regex }

    if job_office_url_selector
      # Trim url to its domain name, example: webpage.com or www.webpage.com
      domain_regex = /(?:[a-z0-9](?:[a-z0-9-]{0,61}[a-z0-9])?\.)+[a-z0-9][a-z0-9-]{0,61}[a-z0-9]/
      job_office_url = job_office_url_selector.text.downcase[domain_regex]

      if !job_office_url.include?('www.')
        job_office_url = "www." + job_office_url
      end

      job[:office_url] = job_office_url
    else
      job[:office_url] = ""
    end

    street_regex = /[a-zäöüß-]+[\s[a-zäöüß-]]*.?\s+\d+/i
    job_office_location_selector = html_doc.css('p.job-detail-kategorie').find{|k| k.text.include?("Kontakt")}.next_element.children.find{|e| e.text =~ street_regex}

    if job_office_location_selector
      job_office_location = job_office_location_selector.text.strip

      job[:office_location] = job_office_location
    else
      job[:office_location] = ""
    end
  end

  def self.get_jobs
    index_url = "https://www.baunetz.de/stellenmarkt/index.html?s_text=&s_ort=berlin&s_umkreis=20000"

    index_html_string = open(index_url).read
    index_html_doc = Nokogiri::HTML(index_html_string)

    jobs = []
    job = {}

    index_html_doc.css('div.jobs-liste-eintrag').each do |element|
      job_date = Time.at(element.css('p.jobs-liste-eintrag-datum').attribute('data-timestamp').value.to_i)
      job_position = element.css('p.jobs-liste-eintrag-titel').text.strip
      job_office_name = element.css('p.jobs-liste-eintrag-untertitel').text.strip

      job_office_logo_selector = element.css('img.jobs-liste-eintrag-logo')

      if job_office_logo_selector.empty?
        job_office_logo = ""
      else
        job_office_logo = "https://www.baunetz.de" + job_office_logo_selector.attribute('src').value
      end

      job_url = element.css('a').attribute('href').value

      html_string = open(job_url).read
      html_doc = Nokogiri::HTML(html_string)

      job = { job_site: "Baunetz", job_url: job_url, job_date: job_date, job_position: job_position, office_name: job_office_name, office_logo: job_office_logo  }

      get_office_contact(html_doc, job)

      # get_job_description(html_doc, job)

      # puts ""
      # puts job.values

      jobs << job
    end

    n_jobs = jobs.size

    phase = "jobs"
    puts "===:::::::::::#{phase}:::::::::::#{phase}:::::::::::#{phase}:::::::::::#{phase}:::::::::::==="

    terminal_counter = 1

    jobs.each do |job|
      if job[:office_url].blank?
        opening = Opening.new(date: job[:job_date],
                              job_position: job[:job_position],
                              job_site: job[:job_site],
                              job_url: job[:job_url],
                              office_name: job[:office_name],
                              office_logo: job[:office_logo])

      elsif Office.pluck(:url).include?(job[:office_url])
        opening = Opening.new(date: job[:job_date],
                              job_position: job[:job_position],
                              job_site: job[:job_site],
                              job_url: job[:job_url],
                              office_id: Office.find_by(url: job[:office_url]).id)

      else
        Office.create(name: job[:office_name],
                      url: job[:office_url],
                      location: job[:office_location],
                      banner_url: job[:office_logo])
        puts "= Office: #{Office.last.name} seeded ="

        opening = Opening.new(date: job[:job_date],
                              job_position: job[:job_position],
                              job_site: job[:job_site],
                              job_url: job[:job_url],
                              office_id: Office.last.id)
      end

      if opening.save
        puts "=== #{terminal_counter} out of #{n_jobs} #{phase} seeded ==="
      else
        puts "=== #{terminal_counter} out of #{n_jobs} #{phase} skipped ==="
      end
      terminal_counter += 1
    end

    puts ""
    puts "Random #{phase} sample:"
    p Opening.last
    # p Opening.find(rand(1..Opening.all.count))
    puts ""

  end
end
