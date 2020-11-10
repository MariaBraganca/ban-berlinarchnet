class Job < ActiveRecord::Base
  establish_connection :external_job_database

  self.table_name = "job"
end
