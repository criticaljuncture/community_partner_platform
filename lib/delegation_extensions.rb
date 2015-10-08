module DelegationExtensions
  extend ActiveSupport::Concern

  class_methods do
    def delegate_if_blank(*methods)
      options = methods.pop
      unless options.is_a?(Hash) && to = options[:to]
        raise ArgumentError, 'Delegation needs a target. Supply an options hash with a :to key as the last argument (e.g. delegate_if_blank :hello, to: :greeter).'
      end

      file, line = caller.first.split(':', 2)
      line = line.to_i

      to = to.to_s

      methods.each do |method|
        method = method.to_s

        method_def = [
          "def #{method}_with_delegation",
          "  Array(self.send('#{method}_without_delegation')).blank? ? self.send('#{to}').send('#{method}') : self.send('#{method}_without_delegation')",
          "end",
          "alias_method('#{method}_without_delegation', '#{method}')",
          "alias_method('#{method}', '#{method}_with_delegation')",
        ].join ';'

        module_eval(method_def, file, line)
      end

      # add a helper methods that return which methods are delegating
      method_def = [
        "def delegated_if_blank_methods",
        "  #{methods.to_a}",
        "end"
      ].join ';'
      module_eval(method_def)

      method_def = [
        "def delegating?(method)",
        "  delegated_if_blank_methods.include?(method) && self.send(\"\#{method}_without_delegation\").blank?",
        "end",
      ].join ';'
      module_eval(method_def)
    end
  end
end
