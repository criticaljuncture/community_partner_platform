class SimilarProgramCollapser
  attr_reader :master_program, :program

  def self.perform(master_program, program)
    new(master_program, program).perform
  end

  def initialize(master_program, program)
    @master_program = master_program
    @program = program
  end

  def perform
    collapse
    remove
  end

  def collapse
    program.school_programs.each do |collapsible_program|
      collapsible_program.community_program_id = master_program.id

      collapsible_program.delegated_if_blank_methods.each do |method|
        # create customized attributes where the collapsible_program
        # differs from the master_program
        unless collapsible_program.send(method) == master_program.send(method)
          collapsible_program.send(
            "#{method}=",
            collapsible_program.send(method)
          )
        end
      end

      collapsible_program.save!
    end
  end

  def remove
    program.destroy
  end
end
