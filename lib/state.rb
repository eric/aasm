module AASM
  module SupportingClasses
    class State
      attr_reader :name, :options

      def initialize(name, options={})
        @name, @options = name, options
      end

      def ==(state)
        if state.is_a? Symbol
          name == state
        else
          name == state.name
        end
      end

      def call_action(action, record, *args)
        action = @options[action]
        case action
        when Symbol, String
          record.send(action, *args)
        when Proc
          action.call(record, *args)
        end
      end

      def for_select
        [name.to_s.gsub(/_/, ' ').capitalize, name.to_s]
      end
    end
  end
end
