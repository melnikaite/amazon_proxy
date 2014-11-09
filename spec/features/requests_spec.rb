RSpec.describe 'request', feature: true do
  before do
    AWS.stub!
  end

  let(:headers) { {'HTTP_ACCESS_KEY_ID' => 'qwerty', 'HTTP_SECRET_ACCESS_KEY' => 'qwerty'} }

  %w(images instances volumes snapshots).each do |service|
    context "to #{service}" do
      it 'without filters should return an array' do
        get "/#{service}", nil, headers
        expect(last_response.status).to eq 200
        expect(JSON.parse last_response.body).to eq []
      end

      it 'with filters should return an array' do
        get "/#{service}", {filters: [{name: 'qwerty'}, values: ['qwerty']]}, headers
        expect(last_response.status).to eq 200
        expect(JSON.parse last_response.body).to eq []
      end
    end
  end

  it 'to create volume should return id' do
    allow_any_instance_of(AWS::EC2::VolumeCollection).to receive(:create).and_return(AWS::EC2::Volume.new('vol-123'))
    get '/volumes/create', {options: [{availability_zone: 'qwerty', size: 1}]}, headers
    expect(last_response.status).to eq 200
    expect(JSON.parse last_response.body).to eq('id' => 'vol-123')
  end

  it 'to check existence of snapshot should return true' do
    allow_any_instance_of(AWS::EC2::Snapshot).to receive(:exists?).and_return(true)
    get '/snapshots/exists%3F', {id: 'qwerty'}, headers
    expect(last_response.status).to eq 200
    expect(JSON.parse(last_response.body, :quirks_mode => true)).to eq(true)
  end

  it 'without credentials should return error' do
    get '/images'
    expect(last_response.status).to eq 500
    expect(JSON.parse last_response.body).to have_key('error')
  end
end
