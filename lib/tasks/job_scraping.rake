namespace :job_scraping do
  # Baunetz
  desc "Fetches jobs from Baunetz"
  task baunetz_jobs: :environment do
    BaunetzJobScraper.get_jobs
  end
  # German Architects
  desc "Fetches jobs from German Architects"
  task ga_jobs: :environment do
    # Scraper Class
  end
  # Compitionline
  desc "Fetches jobs from Competionline"
  task _jobs: :environment do
    # Scraper Class
  end
  # Dezeen
  desc "Fetches jobs from Dezeen"
  task dezeen_jobs: :environment do
    # Scraper Class
  end

  task :all => [:baunetz_jobs]
  # task :all => [:baunetz_jobs, :ga_architekten, :compitionline_jobs, :dezeen_jobs]
end

desc "Seed jobs"
task :job_scraping => 'job_scraping:all'
