module Mongoid::Extensions
  module Bignum
    def mongoize
      to_s
    end

    module ClassMethods
      def mongoize(obj)
        obj.to_s
      end

      def demongoize(obj)
        obj.to_i
      end

      alias :evolve :mongoize
    end
  end
end

::Bignum.__send__(:include, Mongoid::Extensions::Bignum)
::Bignum.__send__(:extend, Mongoid::Extensions::Bignum::ClassMethods)
