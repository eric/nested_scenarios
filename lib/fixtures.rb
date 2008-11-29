class Fixtures < (RUBY_VERSION < '1.9' ? YAML::Omap : Hash)
  def self.destroy_fixtures(table_names)
    NestedScenarios.delete_tables(table_names)
  end
end

module Test #:nodoc:
  module Unit #:nodoc:
    class TestCase #:nodoc:
      superclass_delegating_accessor :scenario_path

      def self.scenario(scenario_name = nil, options = {})
        case scenario_name
          when Hash
            scenario_name = scenario_name.join('/')
          when Symbol, String
            scenario_name = scenario_name.to_s
        end

        self.scenario_path = "#{self.fixture_path}/#{scenario_name}/" if scenario_name

        self.fixtures(:all)
      end

      def self.fixtures(*table_names)
        if table_names.first == :all
          table_names  = Dir["#{self.scenario_path || self.fixture_path}/*.yml"]
          table_names += Dir["#{self.scenario_path || self.fixture_path}/*.csv"]
          table_names.map! { |f| File.basename(f).split('.')[0..-2].join('.') }
        else
          table_names = table_names.flatten.map { |n| n.to_s }
        end

        self.fixture_table_names |= table_names

        require_fixture_classes(table_names)
        setup_fixture_accessors(table_names)
      end

      private
        def load_fixtures
          @loaded_fixtures = {}
          fixtures = Fixtures.create_fixtures(self.scenario_path || self.fixture_path, fixture_table_names, fixture_class_names)
          unless fixtures.nil?
            if fixtures.instance_of?(Fixtures)
              @loaded_fixtures[fixtures.table_name] = fixtures
            else
              fixtures.each { |f| @loaded_fixtures[f.table_name] = f }
            end
          end
        end

        def teardown_fixtures
          return unless defined?(ActiveRecord) && !ActiveRecord::Base.configurations.blank?

          Fixtures.destroy_fixtures(self.fixture_table_names)

          unless use_transactional_fixtures?
            Fixtures.reset_cache
          end

          # Rollback changes if a transaction is active.
          if use_transactional_fixtures? && ActiveRecord::Base.connection.open_transactions != 0
            ActiveRecord::Base.connection.rollback_db_transaction
            ActiveRecord::Base.connection.decrement_open_transactions
          end

          ActiveRecord::Base.clear_active_connections!
        end
    end
  end
end
