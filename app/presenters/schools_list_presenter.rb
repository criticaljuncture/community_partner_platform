class SchoolsListPresenter
  attr_accessor :schools

  def initialize(schools)
    @schools = schools.map{|s| SchoolListPresenter.new(s)}
  end

  class SchoolListPresenter
    attr_accessor :school
    delegate :name, :id, to: :@school

    def initialize(school)
      @school = school
    end

    def community_program_count
      @cp_count ||= school.community_programs.count
    end

    def organization_count
      @org_count ||= school.organizations.uniq.count
    end

    def quality_element_count
      @qe_count ||= school.quality_elements.count
    end

    def quality_element_list
      return "" if school.quality_elements.nil?

      school.quality_elements.map(&:name).sort.join(", <br/>").html_safe
    end
  end
end
