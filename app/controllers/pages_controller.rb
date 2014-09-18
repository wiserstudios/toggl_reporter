class PagesController < ApplicationController
  def home
    require 'httparty'
    @user_tasks = []
    master_credentials = User.master.credentials
    User.all.each do |user|
      response = HTTParty.get "https://www.toggl.com/api/v8/time_entries/current", basic_auth: user.credentials
      if response.parsed_response["data"].nil?
        @user_tasks << {time: nil, name: user.name, client: "", project: "", task: "Resting" }
        next
      end
      wid = response.parsed_response["data"]["wid"]
      pid = response.parsed_response["data"]["pid"]
      time = response.parsed_response["data"]["start"]
      task = response.parsed_response["data"]["description"]

      response = HTTParty.get "https://www.toggl.com/api/v8/projects/#{pid}", basic_auth: master_credentials
      project = response.parsed_response["data"]["name"]
      cid = response.parsed_response["data"]["cid"]

      response = HTTParty.get "https://www.toggl.com/api/v8/clients/#{cid}", basic_auth: master_credentials
      client = response.parsed_response["data"]["name"]
      @user_tasks << {time: time, name: user.name, client: client, project: project, task: task }
    end
  end
end
