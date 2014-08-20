module AngularSprinkles
  module Decorators
    class BindWrapper
      # create BindWrapper so that methods and variables don't pollute
      # the object being wrapped by Bind

      attr_reader :_object, :key, :context_proc

      def initialize(object, key, context_proc)
        @_object, @key, @context_proc = object, key, context_proc
      end

      def bind(_method = nil)
        if _method.present? && !context.var_initialized?([key, _method])
          set_prototype_variable_and_yield(_method)
        end

        context.bind(key, _method)
      end

      private

      def context
        context_proc.call
      end

      def set_prototype_variable_and_yield(_method)
        var = [key, _method].join('.')
        str = context.set_prototype_variable(var, _object.send(_method))
        yield_to_sprinkles("#{str};")
      end

      def yield_to_sprinkles(content)
        context.content_for(:sprinkles) do
          context.content_tag(:script, content.html_safe)
        end
      end
    end

    class Bind < SimpleDelegator
      def initialize(object, key, context_proc)
        @_sprinkles_bind_wrapper = BindWrapper.new(object, key, context_proc)
        super(object)
      end

      def bind(_method = nil)
        @_sprinkles_bind_wrapper.bind(_method)
      end
    end
  end
end
