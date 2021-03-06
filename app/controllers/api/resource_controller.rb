##
#
# Barakafrites helps openerp 6 to speak REST
#
#    Copyright (C) 2013  Siclic
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU Affero General Public License as
#    published by the Free Software Foundation, either version 3 of the
#    License, or (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU Affero General Public License for more details.
#
#    You should have received a copy of the GNU Affero General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
##


class Api::ResourceController < ApplicationController
#  extend Apipie::DSL::Concern
  resource_description do
    short 'Generic CRUD operations on resources'
    formats ['json']
    error 401, "Authentication or authorization failed"
    error 400, "Any command operation failed, or resource does not exist"
    error 500, "Internal programming error"
    error 502, "Internal network error"
    description <<-EOS
    The pattern below apply to any resource available in the list below.
    EOS
  end


  before_filter :check_authenticated?

  def self.common_collection_get
    Rails.application.routes.routes.select do |r|
      /^\/api\//.match(r.path.spec.to_s) &&  !(r.path.spec.to_s.include?(':id')) && /GET/.match(r.verb.to_s)
    end.map do |r|
      r.path.spec.to_s.gsub(/\(.*$/, '')
    end
  end

  def self.common_collection_post
    Rails.application.routes.routes.select do |r|
      /^\/api\//.match(r.path.spec.to_s) &&  !(r.path.spec.to_s.include?(':id')) && /POST/.match(r.verb.to_s)
    end.map do |r|
      r.path.spec.to_s.gsub(/\(.*$/, '')
    end
  end

  def self.common_resource_get
    Rails.application.routes.routes.select do |r|
      /^\/api\//.match(r.path.spec.to_s) &&  (r.path.spec.to_s.include?(':id')) && /GET/.match(r.verb.to_s)
    end.map do |r|
      r.path.spec.to_s.gsub(/\(.*$/, '')
    end
  end

  def self.common_resource_put
    Rails.application.routes.routes.select do |r|
      /^\/api\//.match(r.path.spec.to_s) &&  (r.path.spec.to_s.include?(':id')) && /PUT/.match(r.verb.to_s)
    end.map do |r|
      r.path.spec.to_s.gsub(/\(.*$/, '')
    end
  end


  def self.common_resource_delete
    Rails.application.routes.routes.select do |r|
      /^\/api\//.match(r.path.spec.to_s) &&  (r.path.spec.to_s.include?(':id')) && /DELETE/.match(r.verb.to_s)
    end.map do |r|
      r.path.spec.to_s.gsub(/\(.*$/, '')
    end
  end

  api :GET, '/:path', 'List :resource'
  param :filters, Hash, :desc =>"Filters to be applied to collection" do
    param 'n', Hash, :desc => "n is the Ordinal number, filters will be applied following the number order" do
      param :field, String, :desc => 'Field or relation which apply filter'
      param :operator, String, :desc => 'Operator ( >,<,=,like ...)'
      param :value, String, :desc => 'Value that operator compare to field'
    end
    param 'n', String, :desc => 'Params Combinator, default is & ( logical and ), can be | ( logical or )'
  end
  param 'limit', Integer, :desc => 'Paginate results by :limit'
  param 'offset', Integer, :desc => 'Paginate results from :offset'
  param 'sort', String, :desc => 'Sort results. Values can be "ASC" or "DES", followed by field name. ex : "ASC name" to sort by ascending name '
  param 'fields', Array, :desc => 'list of fields fetched on response objects'
  @common_collection = self.common_collection_get
  description <<-EOS
  Apply to the following resources :

  *  #{@common_collection.join("\n  *  ")}


  === Example

  ==== Query String

    http://api.ostc.siclic.fr/api/openstc/intervention_requests?limit=20&offset=0&sort=id+DESC&filters%5B0%5D%5Bfield%5D=name&filters%5B0%5D%5Boperator%5D=ilike&filters%5B0%5D%5Bvalue%5D=arbre&fields%5B%5D=id&fields%5B%5D=name&fields%5B%5D=actions&fields%5B%5D=tooltip&fields%5B%5D=create_date&fields%5B%5D=create_uid&fields%5B%5D=description&fields%5B%5D=manager_id&fields%5B%5D=partner_address&fields%5B%5D=partner_id&fields%5B%5D=partner_service_id&fields%5B%5D=partner_type&fields%5B%5D=partner_type_code&fields%5B%5D=people_name&fields%5B%5D=service_id&fields%5B%5D=site1&fields%5B%5D=site_details&fields%5B%5D=state&fields%5B%5D=refusal_reason&fields%5B%5D=has_equipment&fields%5B%5D=equipment_id

  ==== Parsed parameters

    limit:20
    offset:0
    sort:id DESC
    filters[0][field]:name
    filters[0][operator]:ilike
    filters[0][value]:arbre
    fields[]:id
    fields[]:name
    fields[]:actions
    fields[]:tooltip
    fields[]:create_date
    fields[]:create_uid
    fields[]:description
    fields[]:manager_id
    fields[]:partner_address
    fields[]:partner_id
    fields[]:partner_service_id
    fields[]:partner_type
    fields[]:partner_type_code
    fields[]:people_name
    fields[]:service_id
    fields[]:site1
    fields[]:site_details
    fields[]:state
    fields[]:refusal_reason
    fields[]:has_equipment
    fields[]:equipment_id

  ==== Result

    [{"partner_address":[654,"contact1, Rue Georges Meynieu"],"create_uid":[14,"Eric  DURAND"],"site_details":" v","create_date":"2013-08-19 12:13:17","name":"Arbre tout vert","refusal_reason":"tttt","partner_service_id":false,"tooltip":"tttt\\n(ALAMICHEL)","equipment_id":false,"partner_type_code":false,"site1":[77,"DE PORS MORO / CHE"],"has_equipment":false,"partner_type":[1,"Administré"],"state":"refused","manager_id":[22,"Larry  BILLIEN"],"people_name":"Jean Mi","service_id":[3,"Espaces Verts"],"actions":["valid"],"partner_id":false,"id":285,"description":"Description de l'arbre tout vert","href":"/openstc/intervention_requests/285"},{"partner_address":[2,"LAMY, Pont l'Abbé, Rue de Penker"],"create_uid":[2,"dst  ALAMICHEL"],"site_details":"proche du croisement","create_date":"2013-05-31 09:10:34","name":"Arbre couché","refusal_reason":false,"partner_service_id":false,"tooltip":" Par DURAND Fin prévue le samedi, 01. juin 2013 10:00","equipment_id":false,"partner_type_code":false,"site1":[210,"De Kerembleis / Rue"],"has_equipment":false,"partner_type":[1,"Administré"],"state":"valid","manager_id":[22,"Larry  BILLIEN"],"people_name":"Martin Jean","service_id":[3,"Espaces Verts"],"actions":[],"partner_id":false,"id":221,"description":"suite à la tempete, \\nsqdkhjdqd","href":"/openstc/intervention_requests/221"},{"partner_address":[2,"LAMY, Pont l'Abbé, Rue de Penker"],"create_uid":[16,"Fabienne  COÏC"],"site_details":"la cour sud","create_date":"2013-05-23 12:52:19","name":"Arbre couché","refusal_reason":false,"partner_service_id":[2,"Bâtiments"],"tooltip":" Par DURAND Fin prévue le jeudi, 30. mai 2013 10:00","equipment_id":false,"partner_type_code":false,"site1":[260,"CHARLES DU QUELENNEC / Rue"],"has_equipment":false,"partner_type":[2,"Service interne de la mairie"],"state":"valid","manager_id":[22,"Larry  BILLIEN"],"people_name":"","service_id":[3,"Espaces Verts"],"actions":[],"partner_id":[2,"SEJ"],"id":213,"description":"suite à la tempête, il ya un arbre couché dans la cour,\\n\\n","href":"/openstc/intervention_requests/213"},{"partner_address":[2,"LAMY, Pont l'Abbé, Rue de Penker"],"create_uid":[2,"dst  ALAMICHEL"],"site_details":"proche du préau de la cour","create_date":"2013-03-18 14:42:17","name":"Arbre couché","refusal_reason":false,"partner_service_id":[2,"Bâtiments"],"tooltip":"","equipment_id":false,"partner_type_code":false,"site1":false,"has_equipment":false,"partner_type":[2,"Service interne de la mairie"],"state":"valid","manager_id":[4,"Bertrand  LE PAPE"],"people_name":"","service_id":[2,"Bâtiments"],"actions":[],"partner_id":[2,"SEJ"],"id":146,"description":"suite à la tempête, un gros chêne est tombé.","href":"/openstc/intervention_requests/146"},{"partner_address":[10,"GUICHAOUA, PONT L'ABBE, Rue Jules Ferry"],"create_uid":[2,"dst  ALAMICHEL"],"site_details":"","create_date":"2013-01-26 16:24:26","name":"Arbre couché","refusal_reason":false,"partner_service_id":false,"tooltip":" Par ALAMICHEL Non planifiée ","equipment_id":false,"partner_type_code":false,"site1":false,"has_equipment":false,"partner_type":[2,"Service interne de la mairie"],"state":"valid","manager_id":[4,"Bertrand  LE PAPE"],"people_name":"","service_id":[2,"Bâtiments"],"actions":[],"partner_id":[12,"CUISINE CENTRALE"],"id":136,"description":"dans la cour","href":"/openstc/intervention_requests/136"},{"partner_address":[2,"LAMY, Pont l'Abbé, Rue de Penker"],"create_uid":[14,"Eric  DURAND"],"site_details":"proche du préau \\n\\n\\n\\n\\n\\n","create_date":"2013-01-08 13:44:07","name":"Arbre couché","refusal_reason":false,"partner_service_id":[2,"Bâtiments"],"tooltip":"je vois pas ce qu'il faut faire\\n(DURAND)","equipment_id":false,"partner_type_code":false,"site1":false,"has_equipment":false,"partner_type":[2,"Service interne de la mairie"],"state":"confirm","manager_id":[7,"Denis  DUGOR"],"people_name":"","service_id":[3,"Espaces Verts"],"actions":[],"partner_id":[2,"SEJ"],"id":131,"description":"suite à la tempête, un arbre est couché dans la cour.\\nvérifier l'état des autres arbres","href":"/openstc/intervention_requests/131"},{"partner_address":[5,"Gaëlle Queffelec"],"create_uid":[2,"dst  ALAMICHEL"],"site_details":"au fond de la cour","create_date":"2012-12-14 11:32:25","name":"arbre couché","refusal_reason":false,"partner_service_id":[12,"Service Enfance Jeunesse"],"tooltip":"","equipment_id":false,"partner_type_code":false,"site1":false,"has_equipment":false,"partner_type":[2,"Service interne de la mairie"],"state":"valid","manager_id":[4,"Bertrand  LE PAPE"],"people_name":"","service_id":[2,"Bâtiments"],"actions":[],"partner_id":[6,"Point info jeunesse"],"id":125,"description":"suite la tempête","href":"/openstc/intervention_requests/125"},{"partner_address":[5,"Gaëlle Queffelec"],"create_uid":[2,"dst  ALAMICHEL"],"site_details":"au fond de la cour","create_date":"2012-12-14 11:32:25","name":"arbre couché","refusal_reason":"Ne fait pas partie de la commune","partner_service_id":[12,"Service Enfance Jeunesse"],"tooltip":"Ne fait pas partie de la commune\\n(ALAMICHEL)","equipment_id":false,"partner_type_code":false,"site1":false,"has_equipment":false,"partner_type":[2,"Service interne de la mairie"],"state":"refused","manager_id":[4,"Bertrand  LE PAPE"],"people_name":"","service_id":[2,"Bâtiments"],"actions":["valid"],"partner_id":[6,"Point info jeunesse"],"id":124,"description":"suite la tempête","href":"/openstc/intervention_requests/124"},{"partner_address":[5,"Gaëlle Queffelec"],"create_uid":[2,"dst  ALAMICHEL"],"site_details":"au fond de la cour","create_date":"2012-12-14 11:32:25","name":"arbre couché","refusal_reason":"test","partner_service_id":[12,"Service Enfance Jeunesse"],"tooltip":"test\\n(ALAMICHEL)","equipment_id":false,"partner_type_code":false,"site1":false,"has_equipment":false,"partner_type":[2,"Service interne de la mairie"],"state":"refused","manager_id":[4,"Bertrand  LE PAPE"],"people_name":"","service_id":[2,"Bâtiments"],"actions":["valid"],"partner_id":[6,"Point info jeunesse"],"id":123,"description":"suite la tempête","href":"/openstc/intervention_requests/123"},{"partner_address":[2,"LAMY, Pont l'Abbé, Rue de Penker"],"create_uid":[2,"dst  ALAMICHEL"],"site_details":"proche du préau","create_date":"2012-12-12 13:50:47","name":"Arbre couché","refusal_reason":false,"partner_service_id":[2,"Bâtiments"],"tooltip":"","equipment_id":false,"partner_type_code":false,"site1":false,"has_equipment":false,"partner_type":[2,"Service interne de la mairie"],"state":"valid","manager_id":[7,"Denis  DUGOR"],"people_name":"","service_id":[3,"Espaces Verts"],"actions":[],"partner_id":[2,"SEJ"],"id":116,"description":"arbre couché dans la cour (suite à la tempête)","href":"/openstc/intervention_requests/116"},{"partner_address":[6,"Bernard"],"create_uid":[2,"dst  ALAMICHEL"],"site_details":"Espace vert Au centre du quartier ","create_date":"2012-11-03 18:08:58","name":"Elagage arbre","refusal_reason":false,"partner_service_id":[1,"Voirie"],"tooltip":"","equipment_id":false,"partner_type_code":"ELU","site1":false,"has_equipment":false,"partner_type":[4,"Elu"],"state":"valid","manager_id":false,"people_name":false,"service_id":[3,"Espaces Verts"],"actions":[],"partner_id":[7,"adjoint travaux"],"id":80,"description":false,"href":"/openstc/intervention_requests/80"}]

  EOS
  def common_collection_get

  end

  api :HEAD, '/:path', 'Get collection Metadata'
  param :filters, Hash, :desc =>"Filters to be applied to collection" do
    param 'n', Hash, :desc => "n is the Ordinal number, filters will be applied following the number order" do
      param :field, String, :desc => 'Field or relation which apply filter'
      param :operator, String, :desc => 'Operator ( >,<,=,like ...)'
      param :value, String, :desc => 'Value that operator compare to field'
    end
    param 'n', String, :desc => 'Params Combinator, default is & ( logical and ), can be | ( logical or )'
  end

  description <<-EOS
  Use HEAD against a collection URI to discover Meta Data, you can use filters to narow result
  From now only the collection Size (count) and the Resource Name are available

  === Example

  ==== Request

    Request URL: http://ostc-staging.siclic.fr/api/open_object/partners
    Request Method: HEAD

  ==== Response

    Content-Range: OpenObject::Partner 0-0/433

  Where 'OpenObject::Partner' is the resource name and '433' is the count

  EOS
  def common_collection_head

  end

  api :POST, '/:path', 'Create :resource'
  param :resource_name, Hash, :desc => 'The resource name (singular) ex : for uri api/openstc/absence_categories it would be absence_category', :required => true do
    param 'attribute_name', String, :desc => 'an attribute ("attribute_name") value'
    param 'another_attribute_name', String, :desc => 'an another attribute ("another_attribute_name") value'
  end
  description <<-EOS

  This can apply to the following URIs :

  *  #{self.common_collection_post.join("\n  *  ")}

  Responds with the created resource id

  === Example

  ==== Request URI

    Request URL:http://localhost/api/openstc/intervention_requests
    Request Method:POST

  ==== Request Payload

    {"id":null,"name":"Pneu creuve","site1":202,"service_id":8,"description":"Pneu explosÃ©, pas de roue de secours.","site_details":"Sur le bord de la route","has_equipment":true,"equipment_id":35,"is_citizen":false,"partner_id":225,"partner_address":883}

  ==== Response

    325

  EOS
  def common_collection_post

  end

  api :GET, '/:path/:id', 'Read :resource'
  param 'fields', Array, desc: 'List of string to be fetched'
  description <<-EOS
  Access to resource identified by :id

  This apply to the following URI :

  *  #{self.common_resource_get.join("\n  *  ")}

  === Example

  ==== Request URI

    Request URL:http://localhost/api/openstc/intervention_requests/325?fields%5B%5D=id&fields%5B%5D=name&fields%5B%5D=actions&fields%5B%5D=tooltip&fields%5B%5D=create_date&fields%5B%5D=create_uid&fields%5B%5D=date_deadline&fields%5B%5D=description&fields%5B%5D=manager_id&fields%5B%5D=note&fields%5B%5D=partner_address&fields%5B%5D=partner_id&fields%5B%5D=partner_phone&fields%5B%5D=partner_service_id&fields%5B%5D=partner_type&fields%5B%5D=partner_type_code&fields%5B%5D=people_name&fields%5B%5D=people_email&fields%5B%5D=people_phone&fields%5B%5D=refusal_reason&fields%5B%5D=service_id&fields%5B%5D=site1&fields%5B%5D=site_details&fields%5B%5D=state&fields%5B%5D=intervention_assignement_id&fields%5B%5D=has_equipment&fields%5B%5D=equipment_id&fields%5B%5D=is_citizen
    Request Method:GET

  ==== Request parsed query

    fields[]:id
    fields[]:name
    fields[]:actions
    fields[]:tooltip
    fields[]:create_date
    fields[]:create_uid
    fields[]:date_deadline
    fields[]:description
    fields[]:manager_id
    fields[]:note
    fields[]:partner_address
    fields[]:partner_id
    fields[]:partner_phone
    fields[]:partner_service_id
    fields[]:partner_type
    fields[]:partner_type_code
    fields[]:people_name
    fields[]:people_email
    fields[]:people_phone
    fields[]:refusal_reason
    fields[]:service_id
    fields[]:site1
    fields[]:site_details
    fields[]:state
    fields[]:intervention_assignement_id
    fields[]:has_equipment
    fields[]:equipment_id
    fields[]:is_citizen

  ==== Result

    {"partner_address":[883,"alavolee"],"create_uid":[2,"dst  ALAMICHEL"],"site_details":"Sur le bord de la route","create_date":"2013-09-26 14:55:39","name":"Pneu creuve","refusal_reason":false,"partner_service_id":false,"tooltip":"","equipment_id":[35,"308 sw / Véhicules"],"partner_type_code":false,"site1":[202,"Arnoult / ROND-POINT"],"has_equipment":true,"partner_type":false,"state":"wait","manager_id":[50,"false  STRULLU"],"people_name":false,"service_id":[8,"Garage"],"actions":["valid","refused"],"partner_id":[225,"3 AXES INDUSTRIES"],"id":325,"description":"Pneu explosé, pas de roue de secours.","href":"/openstc/intervention_requests/325","intervention_assignement_id":false,"note":false,"people_phone":false,"people_email":false,"date_deadline":false,"partner_phone":false}

  EOS
  def common_resource_get

  end

  api :PATCH, '/:path/:id', 'Update :resource'
  api :PUT, '/:path/:id', 'Update :resource'
  description <<-EOS
  Update existing resource identified by :id.

  PUT should be used to update the whole resource.
  PATCH should be used to update only properties passed in request payload.

  This apply to the following URIs :

  *  #{self.common_resource_put.join("\n  *  ")}

  === Example

  This example use patch to update the intervention_request state

  ==== Request

    Request URL: http://ostc-staging.siclic.fr/api/openstc/intervention_requests/257
    Request Method: PATCH

  ==== Request Payload

    {"state":"valid","intervention_assignement_id":3,"service_id":2,"date_deadline":"2013-10-04","description":"","create_task":false,"planned_hours":2,"category_id":""}

  ==== Response

    null

  EOS
  def common_resource_put

  end

  api :DELETE, '/:path.:id', 'Delete :resource'
  description <<-EOS

  Delete resource identified by :id from collection.

  This verb is available on the following URIs :

  *  #{self.common_resource_delete.join("\n  *  ")}

  === Example

  ==== Request

    Request URL: http://ostc-staging.siclic.fr/api/openstc/sites/7
    Request Method: DELETE

  ==== Result

    null

  EOS
  def common_resource_delete

  end
end
