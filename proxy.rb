#!/usr/bin/env ruby -I ../lib -I lib
require 'sinatra'
require 'aws-sdk-v1'
require 'sinatra/json'
if development?
  require 'sinatra/reloader'
  require 'byebug'
end

class Array
  def to_aws_options
    self.map do |option|
      result = {}
      option.each_key do |key|
        value = option[key]
        value = value.to_i if /^\d$/ =~ value
        result[key.to_sym] = value
      end
      result
    end
  end
end

# curl -i 'localhost:4567/volumes/create' -H 'Region: eu-central-1' -H 'Access-Key-Id: AKIAJXVQTP6DZL3LLFVQ' -H 'Secret-Access-Key: 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' -d 'options[][availability_zone]=eu-central-1a' -d 'options[][size]=1' -X GET
get '/:collection/:action' do
  respond_to_action(params: params)
end

# curl -i 'localhost:4567/images' -H 'Region: eu-central-1' -H 'Access-Key-Id: AKIAJXVQTP6DZL3LLFVQ' -H 'Secret-Access-Key: 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' -d 'filters[][name]=platform' -d 'filters[][values][]=windows' -X GET
get '/images*' do
  respond_with_collection(collection: :images, set: :images, filters: params['filters'])
end

get '/instances*' do
  respond_with_collection(collection: :instances, set: :reservation, filters: params['filters'])
end

get '/volumes*' do
  respond_with_collection(collection: :volumes, set: :volume, filters: params['filters'])
end

get '/snapshots*' do
  respond_with_collection(collection: :snapshots, set: :snapshot, filters: params['filters'])
end

helpers do
  def curl?
    !!(request.user_agent =~ /curl/)
  end

  def respond_with_collection(collection:, set:, filters:)
    begin
      options = {}
      options[:filters] = filters if filters

      results = ec2.send(collection).filtered_request(:"describe_#{collection}", options).send("#{set}_set").to_a

      [200, MultiJson.encode(results, pretty: curl?)]
    rescue Exception => msg
      [500, msg]
    end
  end

  def respond_to_action(params:)
    begin
      result = if params['id']
        ec2.send(params['collection']).send(:[], params['id']).send(params['action'], params['options'].to_aws_options)
      else
        ec2.send(params['collection']).send(params['action'], *params['options'].to_aws_options)
      end

      [200, MultiJson.encode({id: result.id}, pretty: curl?)]
    rescue Exception => msg
      [500, msg]
    end
  end

  def ec2
    AWS::EC2.new(
      region: request.env['HTTP_REGION'],
      access_key_id: request.env['HTTP_ACCESS_KEY_ID'],
      secret_access_key: request.env['HTTP_SECRET_ACCESS_KEY']
    )
  end
end
