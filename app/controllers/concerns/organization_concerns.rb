module OrganizationConcerns
  extend ActiveSupport::Concern

  def counts_by_org
    sql = <<-SQL
      SELECT community_programs.organization_id as organization_id,
        COUNT(DISTINCT(community_programs.id)) as program_count,
        COUNT(DISTINCT(school_programs.school_id)) as school_count
      FROM community_programs
      JOIN school_programs
        ON school_programs.community_program_id = community_programs.id
      WHERE community_programs.active = 1
        AND school_programs.active = 1
      GROUP BY community_programs.organization_id
    SQL

    results = ActiveRecord::Base.connection.exec_query(sql).to_a

    results.inject({}) do |hsh, r|
      hsh[r["organization_id"]] = {
        program_count: r["program_count"],
        school_count: r["school_count"]
      }
      hsh
    end
  end
end
