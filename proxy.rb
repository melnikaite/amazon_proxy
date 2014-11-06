#!/usr/bin/env ruby -I ../lib -I lib
require 'sinatra'
require 'aws-sdk-v1'
require 'sinatra/json'
if development?
  require 'sinatra/reloader'
  require 'byebug'
end

# curl -i 'localhost:4567/images' -H 'Access-Key-Id: AKIAJXVQTP6DZL3LLFVQ' -H 'Secret-Access-Key: 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' -d 'filters[][name]=platform' -d 'filters[][values][]=windows' -X GET
get '/images*' do
  respond_with(collection: :images, set: :images, filters: request.params['filters'])
end

get '/instances*' do
  respond_with(collection: :instances, set: :reservation, filters: request.params['filters'])
end

get '/volumes*' do
  respond_with(collection: :volumes, set: :volume, filters: request.params['filters'])
end

get '/snapshots*' do
  respond_with(collection: :snapshots, set: :snapshot, filters: request.params['filters'])
end

helpers do
  def curl?
    !!(request.user_agent =~ /curl/)
  end

  def respond_with(collection:, set:, filters:)
    begin
      options = {}
      options[:filters] = filters if filters
      results = ec2.send(collection).filtered_request(:"describe_#{collection}", options).send("#{set}_set").to_a
      [200, MultiJson.encode(results, pretty: curl?)]
    rescue Exception => msg
      [500, msg]
    end
  end

  def ec2
    AWS::EC2.new(
      access_key_id: request.env['HTTP_ACCESS_KEY_ID'],
      secret_access_key: request.env['HTTP_SECRET_ACCESS_KEY']
    )
  end
end
