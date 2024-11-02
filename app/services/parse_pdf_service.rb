# frozen_string_literal: false

require 'pdf-reader'
require 'stringio'
##
# parse pdf files and output text
class ParsePdfService < ApplicationBaseService
  attr_reader :file_path, :password, :active_record, :attached_object

  def initialize(file_path: nil, password: nil, active_record: false,
                 attached_object: {})
    @file_path = file_path
    @password = password
    @active_record = active_record
    @attached_object = attached_object
  end

  def call
    text = ''
    start = false
    PDF::Reader.open(data_to_process, password: password) do |reader|
      reader.pages.each_with_index do |page, idx|
        page_number = idx + 1
        # puts "start of page: #{page_number}"
        text << "#{page_number}\n"
        page.text.each_line do |line|
          start = true if line.downcase.squish.include?(statement_start)
          next unless start
          break if line.downcase.squish.include?(statement_end)

          text << "#{line.strip}\n"
          # puts line.strip
        end
        # puts "end of page: #{page_number}"
        separator = '_' * 80
        # puts separator
        text << "#{separator}\n"
      end
    end
    text
  end
rescue StandardError => e
  puts "failed to extract text: #{e.message}\n#{e.backtrace&.join("\n\t")}"
  Rails.logger.error("failed to extract text: #{e.message}\n"\
                     "#{e.backtrace&.join("\n\t")}")
end

private

def data_to_process
  return file_path unless active_record

  klass = attached_object[:klass]
  id = attached_object[:id]
  attached = attached_object[:attached]

  unless klass && id && attached
    raise "attached_object is invalid: #{attached_object}"
  end

  object = klass.constantize.find(id)
  unless object
    raise 'attached_object has not been found; '\
          "class: #{klass.constantize}, #{id}"
  end

  StringIO.new(object.send(attached)&.download)
end

def alternate_start
  'Date Value Particulars Money Out Money In Balance'
end

def alternate_end
  'uncleared cheques'
end

def statement_start
  'Tran Date   Value Date              Tran Particulars                   '\
  'Debit              Credit             Balance'.downcase.squish
end

def statement_end
  'Note: Any omission or errors in this statement should be promptly'.downcase
end
