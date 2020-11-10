# Githib Repository: https://github.com/architectural-networks/ban-jobs-scraping
# Application built in python with Scrapy as framework: https://docs.scrapy.org/en/latest/

# Scrapy collects data from 4 websites (=spiders)
# 1. Baunetz
    # name = 'baunetz'
    # allowed_domains = ['baunetz.de']
    # start_urls = ['https://www.baunetz.de/stellenmarkt/index.html?s_ort=Berlin']

# 2. Competition Online
    # name = 'competitionline'
    # allowed_domains = ['competitionline.com']
    # start_urls = ['https://www.competitionline.com/api/jobs?ra=20&co=Deutschland&ci=Berlin&lat=52.51605&lon=13.37691']

# 3. Dezeen
    # name = 'dezeen'
    # allowed_domains = ['dezeenjobs.com']
    # start_urls = ['https://www.dezeenjobs.com/location/berlin/']

# 4. German Architects
    # name = 'germanarchitects'
    # allowed_domains = ['german-architects.com']
    # start_urls = ['https://www.german-architects.com/de/stellenanzeigen?country_id=9&preserve=1']

# Job Item (job_id, date, title, subtitle, company, url, image_url, site*, slack*)

# Integration in Ruby on Rails
# Goal: Store Scrapy crawled data to PostgresSQL database and display it as an opening instance on berlinarchnet! (see https://architecturalnetworks.com/berlin/)

# 1. access data => Python script should output JSON to a file which Ruby can parse
  # Example:
  # [
  #   {
  #   "date": "2020-11-05 16:00",
  #   "title": "Architekt (m/w/d) für eine unbefristete Festanstellung",
  #   "company": "PROPOS Projektentwicklung GmbH ",
  #   "url": "www.propos-gmbh.de ",
  #   "site": "www.baunetz.de"
  #   }
  # ]

# 2. get data => connection through entry point in router? like an api?
  # namespace :api, defaults: { format: :json } do
  #   namespace :v1 do
  #     resources :openings
  #   end
  # end

# 3. parse data => with Nokogiri?
  # JSON.parse("some long string") that you get from the python application

# 4. validate data => model? (*needs to be adjusted)
  # Openings:
  # create_table "openings", force: :cascade do |t|
  #   t.datetime "date"
  #   t.string "job_position"
  #   t.text "description"
  #   t.bigint "office_id", null: false
  #   t.datetime "created_at", precision: 6, null: false
  #   t.datetime "updated_at", precision: 6, null: false
  #   t.index ["office_id"], name: "index_openings_on_office_id"
  # end
  #
  # belongs_to :office
  # validates :date, presence: true
  # validates :job_position, presence: true

# 5. save data => seeds.rb
  # openings.each do |opening|
  #   if Office.pluck(:url).include("#{job["url"][url_regex]}"
  #     Opening.create!(date: job["date"],
  #                job_position: job["title"],
  #                office_id: Office.where(url: job["url"][url_regex])
  #   else
  #     Opening.create!(date: job["date"],
  #                job_position: job["title"],
  #                *office_name: job["company"],
  #                *office_url: job["url"][url_regex])
  #   end
  # end
  #
  # At the moment an opening belongs to an office.
  # If office_url exists? get office_id
  # else, office_id: nullified? + save office_name and office_url

# 6. display data => controller / view
  # openings: index, show
  # office: show (if office_id)

# 7. Alternative: Connect databases?
