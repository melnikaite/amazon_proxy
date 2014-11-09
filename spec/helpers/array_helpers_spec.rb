RSpec.describe 'array' do
  context 'helper to_aws_options' do
    let(:string_option) { [{'key' => 'qwerty'}] }

    let(:number_option_before) { [{'key' => '1'}] }
    let(:number_option_after) { [{'key' => 1}] }

    let(:string_key) { [{'key' => 'qwerty'}] }
    let(:symbolized_key) { [{key: 'qwerty'}] }

    let(:hash_option) { [{key: {'deep_key' => 'qwerty'}}] }

    it 'should not change source array' do
      array = string_option
      expect{array.to_aws_options}.not_to change{array}
    end

    it 'should convert number values from string to integer' do
      array = number_option_before
      expect{array = array.to_aws_options}.to change{array[0].values[0].class}.to(Fixnum)
    end

    it 'should not convert non-number values from string to integer' do
      array = string_option
      expect{array = array.to_aws_options}.not_to change{array[0].values[0].class}
    end

    context 'should change keys to symbols' do
      it 'without recursion' do
        array = string_key
        expect{array = array.to_aws_options}.to change{array[0].keys[0].class}.to(Symbol)
      end

      it 'with recursion' do
        array = hash_option
        expect{array = array.to_aws_options}.to change{array[0].values[0].keys[0].class}.to(Symbol)
      end
    end
  end
end
