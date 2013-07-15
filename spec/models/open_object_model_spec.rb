require 'spec_helper'

describe OpenObjectModel do

  context "Included in any model class" do
    before(:all) do
      class AnyModelClass
        include OpenObjectModel
        @@available_fields = %w(code foo)
        attr_accessor *@@available_fields
      end
    end


    describe 'AnyModelClass.read' do
      before(:each) do
        allow(AnyModelClass).to receive(:read_without_fields)
      end

      context 'without fields' do
        it "calls read with model's available_fields" do

          expect(AnyModelClass).to receive(:read_without_fields)
                                   .with(BintjeStub.user_context,BintjeStub::Read.default_ids,['code','foo'])
          AnyModelClass.read(BintjeStub.user_context,BintjeStub::Read.default_ids,[])
        end

      end

      context 'with available fields' do
        it "call read with given fields" do
          expect(AnyModelClass).to receive(:read_without_fields)
                                   .with(BintjeStub.user_context,BintjeStub::Read.default_ids,['code'])
          AnyModelClass.read(BintjeStub.user_context,BintjeStub::Read.default_ids,['code'])
        end
      end

      context "with unavailable fields" do
        it 'call read without unvailable fields' do
          expect(AnyModelClass).to receive(:read_without_fields)
                                   .with(BintjeStub.user_context,BintjeStub::Read.default_ids,['code'])
          AnyModelClass.read(BintjeStub.user_context,BintjeStub::Read.default_ids,['code','bar'])
        end
      end

    end

  end
end
