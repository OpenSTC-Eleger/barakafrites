module BintjeStub
  def self.user_context
    credential = FactoryGirl.create(:api_credential)
    {dbname: credential.open_object_dbname, uid: credential.open_object_uid, pwd: credential.open_object_pwd}
  end

  module Search
    def self.default_args
      [['field', 'operator', 'value']]
    end

    def self.default_result
      [1, 2]
    end

    def self.method_and_args(klass: OpenObject, args: self.default_args)
      klass.stub(:search).with(BintjeStub.user_context, args)
    end

    def self.success_result(klass: OpenObject, args: self.default_args, result: self.default_result)
      self.method_and_args(klass: klass, args: args)
      .and_return(OpenObject::BackendResponse.new(success: true, errors: nil, content: result))
    end
  end

  module Read
    def self.default_ids
      [1, 2]
    end

    def self.default_fields
      ['name']
    end

    def self.method_and_args(klass: OpenObject, ids: self.default_ids, fields: self.default_fields)
      klass.stub(:read).with(BintjeStub.user_context, ids, fields)
    end

    def self.default_result
      [{id: 1, name: 'one'}, {id: 2, name: 'two'}]
    end

    def self.success_result(klass: OpenObject, ids: self.default_ids, fields: self.default_fields, result: self.default_result)
      self.method_and_args(klass: klass, ids: ids, fields: fields)
      .and_return(OpenObject::BackendResponse.new(success: true, errors: nil, content: result))
    end

    def self.fail_result(klass: OpenObject, ids: self.default_ids, fields: self.default_fields, result: nil)
      self.method_and_args(klass: klass, ids: ids, fields: fields)
      .and_return(OpenObject::BackendResponse.new(success: false, errors: [{faultCode: "FAILED !!!"}], content: result))
    end

  end

  module Read
    def self.default_ids
      [1, 2]
    end

    def self.default_fields
      ['name']
    end

    def self.method_and_args(klass: OpenObject, ids: self.default_ids, fields: self.default_fields)
      klass.stub(:read).with(BintjeStub.user_context, ids, fields)
    end

    def self.default_result
      [{id: 1, name: 'one'}, {id: 2, name: 'two'}]
    end

    def self.success_result(klass: OpenObject, ids: self.default_ids, fields: self.default_fields, result: self.default_result)
      self.method_and_args(klass: klass, ids: ids, fields: fields)
      .and_return(OpenObject::BackendResponse.new(success: true, errors: nil, content: result))
    end

    def self.fail_result(klass: OpenObject, ids: self.default_ids, fields: self.default_fields, result: nil)
      self.method_and_args(klass: klass, ids: ids, fields: fields)
      .and_return(OpenObject::BackendResponse.new(success: false, errors: [{faultCode: "FAILED !!!"}], content: result))
    end
  end


  module Create
    def self.default_values
      {'name' => 'one'}
    end

    def self.method_and_args(klass: OpenObject, values: self.default_values)
      klass.stub(:create).with(BintjeStub.user_context, values)
    end

    def self.default_result
      1
    end

    def self.success_result(klass: OpenObject, values: self.default_values, result: self.default_result)
      self.method_and_args(klass: klass, values: values)
      .and_return(OpenObject::BackendResponse.new(success: true, errors: nil, content: result))
    end

    def self.fail_result(klass: OpenObject, values: self.default_values, result: self.default_result)
      self.method_and_args(klass: klass, values: values)
      .and_return(OpenObject::BackendResponse.new(success: false, errors: [{faultCode: "FAILED !!!"}], content: result))
    end
  end

  module Write
    def self.default_values
      {'name' => 'one'}
    end

    def self.default_ids
      [1, 2]
    end

    def self.method_and_args(klass: OpenObject, ids: self.default_ids, values: self.default_values)
      klass.stub(:write).with(BintjeStub.user_context, ids, values)
    end

    def self.default_result
      true
    end

    def self.success_result(klass: OpenObject, ids: self.default_ids, values: self.default_values, result: self.default_result)
      self.method_and_args(klass: klass, ids:ids ,values: values)
      .and_return(OpenObject::BackendResponse.new(success: true, errors: nil, content: result))
    end

    def self.fail_result(klass: OpenObject,  ids: self.default_ids, values: self.default_values, result: self.default_result)
      self.method_and_args(klass: klass, ids:ids, values: values)
      .and_return(OpenObject::BackendResponse.new(success: false, errors: [{faultCode: "FAILED !!!"}], content: result))
    end
  end

end