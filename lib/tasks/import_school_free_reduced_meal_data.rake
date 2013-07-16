namespace :import do
  require 'csv'

  namespace :school do
    # see doc/free_reduced_meals.md for field details
    task :free_reduced_meal_data => :environment do
      invalid_school_year = "\n\n************\n Must supply a school year in the format 'school_year=2012-2013' \n************\n\n"
      raise invalid_school_year unless ENV['school_year'] && ENV['school_year'] =~ /^\d{4}\-\d{4}$/

      school_year = ENV['school_year']
      school_year_file_format = "#{school_year.slice(0..3)}_#{school_year.slice(5..8)}"

      record_count = 0
      processed_record_count = 0

      CSV.foreach("#{Rails.root}/data/CSV/ousd_free_reduced_meal_#{school_year_file_format}.csv", :headers => true) do |row|
        record_count += 1

        school_name = row['school_name'].strip

        school = School.find_by_name(school_name) || School.find_by_name("#{school_name} School")

        if school.nil?
          puts "Could not find #{school_name}. Proceeding to next record."
          next
        else
          school.school_code = row['school_code'].strip

          charter_number = row['direct_funded_charter_school_number'].strip
          school.direct_funded_charter_school = charter_number.blank? ? false : true
          school.direct_funded_charter_school_number = charter_number         
          
          school.save

          frm_data = School::FreeReducedMealData.find_or_create_by_school_id_and_school_year(school.id, school_year)
          
          frm_data.date                         = Date.parse(row['data_date'].strip)
          frm_data.provision_two_three_school   = row['provision_two_three_school'].strip == 'Y' ? true : false
          frm_data.data_source                  = row['data_source'].strip
          frm_data.low_grade                    = row['low_grade'].strip
          frm_data.high_grade                   = row['high_grade'].strip
          frm_data.enrollment_k_12              = row['enrollment_k_12'].strip
          frm_data.free_meal_count_k_12         = row['free_meal_count_k_12'].strip
          frm_data.percent_eligible_free_k_12   = row['percent_eligible_free_k_12'].strip
          frm_data.frpm_total_undup_count_k_12  = row['frpm_total_undup_count_k_12'].strip
          frm_data.frpm_percent_eligible_k_12   = row['frpm_percent_eligible_k_12'].strip
          frm_data.enrollment_5_17              = row['enrollment_5_17'].strip
          frm_data.free_meal_count_5_17         = row['free_meal_count_5_17'].strip
          frm_data.percent_eligible_5_17        = row['percent_eligible_5_17'].strip
          frm_data.frpm_total_undup_count_5_17  = row['frpm_total_undup_count_5_17'].strip
          frm_data.frpm_percent_eligible_5_17   = row['frpm_percent_eligible_5_17'].strip

          frm_data.save

          processed_record_count += 1
        end
      end
      puts "Sucessfully processed #{processed_record_count}/#{record_count} records."
    end
  end
end
