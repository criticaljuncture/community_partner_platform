namespace :ousd do
  namespace :import do
    task :ousd_community_partners => :environment do
      require 'csv'

      CSV.foreach("#{Rails.root}/data/ousd_community_partners.csv", :headers => true) do |row|
        region_name = row["region"]
        region = nil
        if region_name
          region = Region.find_or_create_by_name(name: region_name)
          region.save
        end

        school_name = row["school"]
        school = nil
        if school_name
          school = School.find_or_create_by_name(name: school_name)
          school.save
        end

        csssp_name = row["school_quality_indicator_sub_area"]
        csssp = nil
        if csssp_name
          csssp = SchoolQualityIndicatorSubArea.find_or_create_by_name(name: csssp_name)
          csssp.save
        end

        additional_csssp = row["additional_school_quality_indicator_sub_area"]
        
        organization_name = row["organization"]
        organization = nil
        if organization_name
          organization = Organization.find_or_create_by_name(name: organization_name)
        end

        service_provided = row["service_provided"]

        service_type_name = row["service_type"]
        service_type = nil
        if service_type_name
          service_type = ServiceType.find_or_create_by_name(name: service_type_name)
          service_type.save
        end
        
        date_collected = row["date_collected"]
        point_of_contact = row["point_of_contact"]

        community_partner = CommunityPartner.new(
          school_id: school.try(:id),
          region_id: region.try(:id),
          school_quality_indicator_sub_area_id: csssp.try(:id),
          additional_school_quality_indicator_sub_area: additional_csssp,
          organization_id: organization.try(:id),
          service_provided: service_provided,
          service_type_id: service_type.try(:id),
          date_collected: date_collected,
          point_of_contact: point_of_contact
        )

        community_partner.save
      end
    end

    task :move_regions_to_schools => :environment do
      community_partners = CommunityPartner.all

      community_partners.each do |community_partner|
        school = community_partner.school
        if school
          school.region_id = community_partner.region_id
          school.save
        end
      end
    end

    desc "Links new quality elements to new service types - 20130918"
    task :link_quality_element_to_service_types => :environment do
      require 'csv'
      QualityElementServiceType.truncate

      CSV.foreach("#{Rails.root}/data/CSV/quality_element_service_type.csv", :headers => true) do |row|
        puts "importing #{row['service_type'].strip} :: #{row['quality_element'].strip}"
         service_type = ServiceType.find_by_name!( row['service_type'].strip )
         quality_element = QualityElement.find_by_name!( row['quality_element'].strip )

         qest = QualityElementServiceType.new(quality_element_id: quality_element.id,
                                              service_type_id: service_type.id)
         qest.save
      end
    end
  end
end
