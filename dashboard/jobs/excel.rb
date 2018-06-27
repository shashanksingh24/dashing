require 'roo-xls'

EM.kqueue = EM.kqueue?
file_path = "#{Dir.pwd}/Test.xls"

def fetch_spreadsheet_data(path)
  s = Roo::Excel.new(path)
  send_event('excel',   { current: s})
end

module Handler
  def file_modified
    fetch_spreadsheet_data(path)
  end
end

fetch_spreadsheet_data(file_path)

EM.next_tick do
  EM.watch_file(file_path, Handler)
end
