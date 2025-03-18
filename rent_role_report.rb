def read_input(prompt)
  puts prompt
  gets.chomp.strip
end

def csv_search
  puts "Searching for CSV files..."
  csv_files = Dir.glob("*.csv")
  puts "Available file-"
  csv_files.each do |file|
    puts file.gsub("/home/kay/Code/Ruby/welcomehome/", "")
  end
end

def csv_load
  CSV.foreach(csv_path, headers: true) do |row|
    unit = Unit.find_or_create_by(unit_number: row['unit'].to_i, floor_plan: row['floor_plan'])
    if row['resident'].present?
      unit.residents.create(
        name: row['resident'],
        status: row['status'],
        move_in: row['move_in'].present? ? Date.strptime(row['move_in'], '%m/%d/%Y') : nil,
        move_out: row['move_out'].present? ? Date.strptime(row['move_out'], '%m/%d/%Y') : nil
      )
    end
  end
end

class RentRoleReport
  GREETING = "Welcome to Rent Role Report."
  LOADING = "Loading CSV"

  def run
    greet

    choice = nil
    until choice == '1' || choice == '2'
      choice = read_input("Would you like to load a csv?
      1) Yes
      2) No")
    end

    exit if choice == '2'

    csv_search

    load_message

    csv_load
  end

  private
  def greet
    puts GREETING
  end

  def load_message
    puts LOADING
  end
end

# RentRoleReport.new.run
