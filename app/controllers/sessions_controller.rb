class SessionsController < ApplicationController
  resource_description do
    short 'Authentication'
    description <<-EOS
    The API authentication is really simple.

    On successful authentication a token is granted to your system.
    Then you just have to use this token in every request header :

      Authorization: Token token=31b3d3f11b62ce1d0031a08a35787b75

    Once the token expires ( through logout or server-side expiry ) you'll receive 401 Responses.
    It means you have to request a new token ( authenticate )

    EOS
  end

  api :POST, '/sessions', 'Authenticate'
  param :dbname, String, desc: 'The database to authenticate on', required: true
  param :login, String, desc: 'The profile to use', required: true
  param :password, String, desc: 'The password for this profile on this database', required: true
  description <<-EOF

  On successful authentication it provides the auth token to use in API request headers. ( in the example below "token":"31b3d3f11b62ce1d0031a08a35787b75" )

  === Example

  ==== Request

    Request URL: http://ostc-staging.siclic.fr/sessions
    Request Method: POST

  ==== Request Payload

    {"dbname":"pontlabbe2-staging","login":"dst","password":"dstdst"}

  ==== Response

    {"user":{"id":2,"href":"/open_object/users/2","context_tz":"Europe/Paris","groups_id":[3,7,8,10,15,16,18,20,21,23,24,25,26,27,28,29],"tasks":[599,626,649],"context_lang":"fr_FR","name":"ALAMICHEL","firstname":"dst","service_ids":[1,2,3,4,5,8,9,18,19,23,25,26,36,37,38,39,40,41],"lastname":false,"contact_id":[],"phone":false,"isDST":true,"complete_name":"dst  ALAMICHEL","team_ids":[],"date":"2013-09-27 12:43:14.682186","service_id":[19,"SERVICES TECHNIQUES MUNICIPAUX"],"login":"amic","isManager":false,"user_email":"","service_names":[[1,"Voirie"],[2,"Bâtiments"],[3,"Espaces Verts"],[4,"Propreté"],[5,"Environnement"],[8,"Garage"],[9,"STADES / SOS"],[18,"ECLAIRAGE PUBLIC"],[19,"SERVICES TECHNIQUES MUNICIPAUX"],[23,"Informatique"],[25,"Garage-Meca"],[26,"Garage-Ferronerie"],[36,"Entretien"],[37,"DST"],[38,"Fluides"],[39,"Aire de Jeux"],[40,"Bâtiments Sportifs"],[41,"Service"]],"actions":["create","update","delete"],"current_group":[18,"DST"]},"token":"31b3d3f11b62ce1d0031a08a35787b75","menu":{"success":true,"errors":[],"content":[{"parent_id":false,"tag":"interventions","name":"Interventions","child_id":[1491,802],"id":123,"children":[{"parent_id":[123,"Interventions"],"tag":"gestion-des-interventions","name":"Gestion des interventions","child_id":[800,1159,1672,801],"id":1491,"children":[{"parent_id":[1491,"Gestion des interventions"],"tag":"demandes-dinterventions","name":"Demandes d'interventions","child_id":[],"id":800,"children":[]},{"parent_id":[1491,"Gestion des interventions"],"tag":"planning","name":"Planning","child_id":[],"id":1159,"children":[]},{"parent_id":[1491,"Gestion des interventions"],"tag":"interventions","name":"Interventions","child_id":[],"id":1672,"children":[]},{"parent_id":[1491,"Gestion des interventions"],"tag":"taches","name":"Tâches","child_id":[],"id":801,"children":[]}]},{"parent_id":[123,"Interventions"],"tag":"configuration","name":"Configuration","child_id":[1487,1673,804,1488,803,1489,1467,1674,1471],"id":802,"children":[{"parent_id":[802,"Configuration"],"tag":"affectations-des-interventions","name":"Affectations des interventions","child_id":[],"id":1487,"children":[]},{"parent_id":[802,"Configuration"],"tag":"organisations","name":"Organisations","child_id":[],"id":1673,"children":[]},{"parent_id":[802,"Configuration"],"tag":"services","name":"Services","child_id":[],"id":804,"children":[]},{"parent_id":[802,"Configuration"],"tag":"categories-des-taches","name":"Catégories des tâches","child_id":[],"id":1488,"children":[]},{"parent_id":[802,"Configuration"],"tag":"sites","name":"Sites","child_id":[],"id":803,"children":[]},{"parent_id":[802,"Configuration"],"tag":"types-dabscence","name":"Types d'abscence","child_id":[],"id":1489,"children":[]},{"parent_id":[802,"Configuration"],"tag":"equipes","name":"Equipes","child_id":[],"id":1467,"children":[]},{"parent_id":[802,"Configuration"],"tag":"types-dorganisation","name":"Types d'organisation","child_id":[],"id":1674,"children":[]},{"parent_id":[802,"Configuration"],"tag":"equipements","name":"Equipements","child_id":[],"id":1471,"children":[]}]}]}]}}

  EOF
  def create
    if uid = OpenObject::User.authenticate(params[:dbname],params[:login],params[:password])
      credential = ApiCredential.create(open_object_dbname:params[:dbname], open_object_uid:uid, open_object_pwd:params[:password])
      set_user_context(credential)
      @user = OpenObject::User.find_one(user_context,uid).content
      @menu = OpenObject::Menu.fetch(user_context)
      @token = credential.access_token
      respond_to do |format|
        format.json { render :show}
      end
    else
      render :json => {:errors => ['Authentication Failed']}, :status => 401
    end
  end


  api :DELETE, '/sessions', 'Logout (Expires auth token)'
  description 'You wont be able to use the provided token'
  def destroy
    @api_credential = ApiCredential.where(access_token: params[:id]).last
    if @api_credential
      if @api_credential.delete
        render :json => true,  :status => 200
      else
        render :json => false, status: 400
      end

    else
      render nothing: true, status: 404
    end
  end
end
