class SimilarProgramClassifier
  attr_reader :master_program, :program

  SIMILAR_COMMUNITY_PROGRAM_ATTRIBUTES = {
    quality_element: :same,
    service_types: :include
  }

  SIMILAR_SCHOOL_PROGRAM_ATTRIBUTES = {
    student_population: :same,
    demographic_groups: :same
  }

  def initialize(master_program:, program:)
    @master_program = master_program
    @program = program
  end

  def self.normalize_program_names(program_names)
    program_names.inject({}) do |hsh, name|
      normalized_name = name.downcase.gsub(' ','')
      hsh[normalized_name] ||= []

      hsh[normalized_name] << name
      hsh
    end
  end

  # programs are collapsible if they have similar community program values
  # (defined below) and similar descriptions. Otherwise they are collapsible
  # if their descriptions are different but the community program values and
  # select school program values are similar.
  def collapsible?
    community_program_values_similar = compare_community_program_value_similarity
    descriptions_similar = similar?(:service_description, :same, master_program, program)

    if community_program_values_similar && descriptions_similar
      true
    else
      school_program_values_similar = compare_school_program_value_similarity
      community_program_values_similar && school_program_values_similar
    end
  end

  private

  def compare_community_program_value_similarity
    SIMILAR_COMMUNITY_PROGRAM_ATTRIBUTES.all? do |method, similarity|
      similar?(method, similarity, master_program, program)
    end
  end

  def compare_school_program_value_similarity
    SIMILAR_SCHOOL_PROGRAM_ATTRIBUTES.all? do |method, similarity|
      similar?(method, similarity, master_program, program)
    end
  end

  def similar?(method, similarity, master_program, program)
    case similarity
    when :same
      program.send(method).blank? || master_program.send(method) == program.send(method)
    when :include
      program.send(method).blank? || subset?(program.send(method), master_program.send(method))
    end
  end

  # is 'a' a subset of 'b'
  def subset?(a,b)
    a.all? {|x| b.include? x}
  end
end
