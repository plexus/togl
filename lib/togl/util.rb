module Togl
  module Util
    module_function

    def camelize(str)
      str.gsub(/\/(.?)/)     { "::#{ $1.upcase }" }
        .gsub!(/(?:^|_)(.)/) { $1.upcase          }
    end
  end
end
