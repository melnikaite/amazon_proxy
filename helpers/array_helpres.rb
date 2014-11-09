class Array
  # Converts recursively keys to symbols and number values to integer
  # @return [Array]
  def to_aws_options
    self.map do |option|
      result = {}
      option.each_key do |key|
        value = option[key]
        value = value.to_i if value.is_a?(String) && /^\d$/ =~ value
        value = [value].to_aws_options[0] if value.is_a?(Hash)
        result[key.to_sym] = value
      end
      result
    end
  end
end
