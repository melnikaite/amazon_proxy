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
      if params['id']
        result = ec2.send(params['collection']).send(:[], params['id']).send(params['action'], params['options'].to_aws_options)
      else
        result = ec2.send(params['collection']).send(params['action'], *params['options'].to_aws_options)
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
