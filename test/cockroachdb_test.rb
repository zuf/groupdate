require_relative "test_helper"

class CockroachdbTest < Minitest::Test
  include TestGroupdate
  include TestDatabase

  def setup
    super
    @@setup ||= begin
      ActiveRecord::Base.establish_connection adapter: "cockroachdb", database: "groupdate_test"
      create_tables
      true
    end
  end
end
