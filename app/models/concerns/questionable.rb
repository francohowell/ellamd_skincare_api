module Questionable
  extend ActiveSupport::Concern

  included do
    def self.question_with_optional_details(*question_columns)
      question_columns.each do |question_column|
        override_question_reader(question_column)
        override_question_writer(question_column)
      end
    end

    def self.question_with_required_details(*question_columns)
      question_columns.each do |question_column|
        override_question_reader(question_column)
        override_question_writer(question_column)
        validate_question_detail_presence_when_not_false(question_column)
      end
    end

    def self.override_question_reader(question_column)
      define_method question_column do
        read_attribute(question_column) || false
      end
    end

    def self.override_question_writer(question_column)
      define_method "#{question_column}=".to_sym do |new_value|
        if new_value == false
          write_attribute(question_column, nil)
        elsif new_value == true
          write_attribute(question_column, "")
        else
          write_attribute(question_column, new_value)
        end
      end
    end

    def self.validate_question_detail_presence_when_not_false(question_column)
      validates question_column, presence: true, unless: ->(record) { record.send(question_column) == false }
    end
  end
end
