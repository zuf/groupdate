require_relative "test_helper"

class TestSqlite < Minitest::Test
  include TestGroupdate
  include TestDatabase

  def setup
    super
    @@setup ||= begin
      ActiveRecord::Base.establish_connection adapter: "sqlite3", database: ":memory:"
      create_tables
      true
    end
  end
end
