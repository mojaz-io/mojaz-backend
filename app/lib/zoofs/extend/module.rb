# frozen_string_literal: true

class Module
  def attr_rw(*attrs)
    file, line, = caller(1..1).first.split(":")
    line = line.to_i

    attrs.each do |attr|
      module_eval <<-DEFINTION, file, line
        def #{attr}(val=nil)
          @#{attr} ||= nil
          return @#{attr} if val.nil?
          @#{attr} = val
        end
      DEFINTION
    end
  end
end
