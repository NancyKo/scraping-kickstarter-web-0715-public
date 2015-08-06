# require libraries/modules here
require 'nokogiri'
# require 'open-uri'
require 'pry'

def create_project_hash
  # write your code here
  # scraping from a live website
  # html = open('http://www.kickstarter.com')
  # html.read



# projects: kickstarter.css("li.project.grid_4")
# itle: project.css("h2.bbcard_name strong a").text
# image link: project.css("div.project-thumbnail a img").attribute("src").value
# project_blurb: project.css("p.bbcard_blurb").text
# percent_funded: project.css("ul.project-stats li.first.funded strong").text
  projects = {}

  html = File.open('fixtures/kickstarter.html')
  kickstarter = Nokogiri::HTML(html)
  kickstarter.css("li.project.grid_4").each do |project| 
    title = project.css("h2.bbcard_name strong a").text
    projects[title] = {

      :image_link => project.css("div.project-thumbnail a img").attribute("src").value,

      :description => project.css("p.bbcard_blurb").text,

      :percent_funded => project.css("ul.project-stats li.first.funded strong").text.to_i,
      
      :location => project.css("ul.project-meta span.location-name").text
    }
  end
  return projects
end

create_project_hash
