require 'open-uri'
require 'json'

class BaunetzJobScraper
  def self.get_job_description(html_doc, job)
    job_description_selector = html_doc.css('p.job-detail-kategorie').find{|k| k.text.include?("Stellenbeschreibung")}.next_element

    # binding.pry

    if job_description_selector.text.blank?
      job_description = job_description_selector.next_element.text
    else
      job_description = job_description_selector.text
    end

    job[:job_description] = job_description
  end

  def self.get_office_contact(html_doc, job)
    job_office_url_selector = html_doc.css('a.content_link').find{|link| !link.text.include?("@")}

    if job_office_url_selector
      url_regex = /(?:[a-z0-9](?:[a-z0-9-]{0,61}[a-z0-9])?\.)+[a-z0-9][a-z0-9-]{0,61}[a-z0-9]/
      job_office_url = job_office_url_selector.text[url_regex]

      job[:office_url] = job_office_url
    else
      job[:office_url] = ""
    end
  end

  def self.get_jobs
    index_url = "https://www.baunetz.de/stellenmarkt/index.html?s_text=&s_ort=berlin&s_umkreis=20000"

    index_html_string = open(index_url).read
    index_html_doc = Nokogiri::HTML(index_html_string)

    jobs = []
    job = {}

    index_html_doc.css('div.jobs-liste-eintrag').each do |element|

      job_date = element.css('p.jobs-liste-eintrag-datum').text
      job_position = element.css('p.jobs-liste-eintrag-titel').text
      job_office_name = element.css('p.jobs-liste-eintrag-untertitel').text

      job_url = element.css('a').attribute('href').value

      html_string = open(job_url).read
      html_doc = Nokogiri::HTML(html_string)

      job = { job_site: "Baunetz", job_url: job_url, job_date: job_date, job_position: job_position, office_name: job_office_name  }

      get_office_contact(html_doc, job)

      get_job_description(html_doc, job)

      # puts ""
      # puts job.values

      jobs << job
    end

    phase = "jobs"
    n_jobs = jobs.size
    terminal_counter = 1

    jobs.each do |job|
      Opening.where(job_url: job[:job_url]).first_or_create(
                                                            date: job[:job_date],
                                                            job_position: job[:job_position],
                                                            description: job[:job_description],
                                                            job_site: job[:job_site],
                                                            job_url: job[:job_url],
                                                            office_name: job[:office_name],
                                                            office_url: job[:office_url]
                                                            )

      puts "=== #{terminal_counter} out of #{n_jobs} #{phase} seeded ==="
      terminal_counter += 1
    end

  end
end
