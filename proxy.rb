#!/usr/bin/env ruby -I ../lib -I lib
require 'sinatra'
require 'aws-sdk-v1'
require 'sinatra/json'
if development?
  require 'sinatra/reloader'
  require 'byebug'
end

# curl -i 'localhost:4567/images' -H 'Access-Key-Id: AKIAJXVQTP6DZL3LLFVQ' -H 'Secret-Access-Key: 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' -d 'filters[][name]=platform' -d 'filters[][values][]=windows' -X POST
post '/images' do
  begin
    ec2 = AWS::EC2.new(
      access_key_id: request.env['HTTP_ACCESS_KEY_ID'],
      secret_access_key: request.env['HTTP_SECRET_ACCESS_KEY']
    )

    options = {}
    options[:filters] = request.params['filters'] if request.params['filters']
    images = ec2.images.filtered_request(:describe_images, options).images_set.to_a

    [200, MultiJson.encode(images, pretty: curl?)]
  rescue Exception => msg
    [500, msg]
  end
end

helpers do
  def curl?
    !!(request.user_agent =~ /curl/)
  end
end
