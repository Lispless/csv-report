require "test_helper"
require "./rent_role_report.rb"

class CsvTest < ActiveSupport::TestCase
  csv_path = "./units-and-residents.csv"
  greeting_expected = "Welcome to Rent Role Report.\n"
  csv_search_expected = "Searching for CSV files...\n" +
  "Available file-\n" +
  "units-and-residents.csv\n"

  test 'prints welcome to console' do
    assert_output(greeting_expected) { RentRoleReport.new.send(:greet) }
  end

  # test 'input valid 1' do
  #   input = StringIO.new("1\n")
  #   $stdin = input

  #   assert_equal "1", read_input("")
  #   $stdin = STDIN
  # end

  test 'invalid input' do
    input = StringIO.new("A\n")
    $stdin = input

    refute_equal "1", read_input("")
    $stdin = STDIN
  end

  test 'search for csv file' do
    assert_output(csv_search_expected) { csv_search }
  end

  test 'import csv files' do
    CSV.foreach(csv_path, headers: true) do |row|
      unit = Unit.find_or_create_by(unit_number: row["unit"].to_i,
      floor_plan: row["floor_plan"])
      assert unit.persisted?

      if row["resident"].present?
        move_in_date = row["move_in"]. present? ?
        Time.strptime(row["move_in"], "%m/%d/%Y") :
        nil
        move_out_date = row["move_out"]. present? ?
        Time.strptime(row["move_out"], "%m/%d/%Y") :
        nil

        resident = unit.residents.create(
          name: row["resident"],
          move_in: move_in_date,
          move_out: move_out_date
        )
        assert resident.persisted?
      end
    end
  end
end
