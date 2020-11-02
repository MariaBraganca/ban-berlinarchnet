require 'open-uri'
require 'json'

=begin
# Goal: create a JSON File with an array of offices
offices = [{
  "name" = "",
  "location" = "",
  "url" = ""
}]
=end

# Class OfficeScraper
class OfficeScraper
  # Class Method
  def self.get_offices
    zips = ["10115","10117","10119","10178","10179","10243","10245","10247","10249","10315","10317","10318","10319","10365","10367","10369","10405","10407","10409","10435","10437","10439","10551","10553","10555","10557","10559","10585","10587","10589","10623","10625","10627","10629","10707","10709","10711","10713","10715","10717","10719","10777","10779","10781","10783","10785","10787","10789","10823","10825","10827","10829","10961","10963","10965","10967","10969","10997","10999"]

    offices = []
    office = {}

    zips.each do |zip|
      url = "https://www.ak-berlin.de/nc/mitgliedersuche/mitglieder.html?tx_sisimembers_memberlist%5Bmember%5D%5Bfachrichtung%5D=A&tx_sisimembers_memberlist%5Bmember%5D%5Bplz%5D=#{zip}&tx_sisimembers_memberlist%5Bmember%5D%5Bliste%5D=K&tx_sisimembers_memberlist%5Bmember%5D%5Barea%5D=K"

      html_string = open(url).read
      html_doc = Nokogiri::HTML(html_string)

      page = 1

      until html_doc.css('li.list-group-item.row').empty?
        url = "https://www.ak-berlin.de/nc/mitgliedersuche/mitglieder.html?tx_sisimembers_memberlist%5Bmember%5D%5Bfachrichtung%5D=A&tx_sisimembers_memberlist%5Bmember%5D%5Bplz%5D=#{zip}&tx_sisimembers_memberlist%5Bmember%5D%5Bliste%5D=K&tx_sisimembers_memberlist%5Bmember%5D%5Barea%5D=K&tx_sisimembers_memberlist%5B%40widget_0%5D%5BcurrentPage%5D=#{page}"

        html_string = open(url).read
        html_doc = Nokogiri::HTML(html_string)

        html_doc.css('li.list-group-item.row').each do |element|
          unless element.css('div.col-lg-12.col-md-12.col-sm-12.col-xs-12').empty? || element.css('div.col-lg-8.col-md-8.col-sm-8.col-xs-12').empty?
            url = element.css('a:contains("www")').text.strip # URL
            name = element.css('div.col-lg-12.col-md-12.col-sm-12.col-xs-12').first.text.strip # NAME
            street = element.css('div.col-lg-8.col-md-8.col-sm-8.col-xs-12').children.select{ |e| e.text  =~ /\d/ }.first.text.strip # STREET

            unless url.empty? || name.empty? # IF URL AND NAME, CREATE OFFICE
              office = { name: name, location: "#{street}, #{zip} Berlin", url: url }
              # puts "---"
              # puts office.values
              offices << office
            end
            # binding.pry
          end
        end
        page += 1
      end
    end
    offices.uniq!{ |office| office[:name].downcase }
    offices.uniq!{ |office| office[:url] }
    offices.sort_by!{ |office| office[:location] }
    # p offices
    # p offices.length
    # binding.pry
    json = JSON.pretty_generate(offices)
    File.open("db/offices.json", 'w') { |file| file.write(json) }
  end
end
