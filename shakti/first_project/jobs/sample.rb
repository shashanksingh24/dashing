current_valuation = 0
current_karma = 0

SCHEDULER.every '2s' do
  last_valuation = current_valuation
  last_karma     = current_karma
  current_valuation = rand(100)
  current_karma     = rand(200000)

  send_event('valuation', { current: current_valuation, last: last_valuation })
#  send_event('karma', { current: current_karma, last: last_karma })
  send_event('karma', { current: current_karma})
  send_event('synergy',   { value: rand(100) })
end

#require 'roo-xls'
#
#EM.kqueue = EM.kqueue?
#file_path = "#{Dir.pwd}/Test.xls"
#
#def fetch_spreadsheet_data(path)
#  s = Roo::Excel.new(path)
#  send_event('valuation',   { current: s.cell(1, 2) })
#end
#
#module Handler
#  def file_modified
#    fetch_spreadsheet_data(path)
#  end
#end
#
#fetch_spreadsheet_data(file_path)
#
#EM.next_tick do
#  EM.watch_file(file_path, Handler)
#end
