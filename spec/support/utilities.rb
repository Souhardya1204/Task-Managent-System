# frozen_string_literal: true

def valid_emails
  %w[abc-d@mail.com abc.def@mail.com abc@mail.com abc_def@mail.com]
end

def invalid_emails
  %w[abc#def@mail.com abc.def@mail#archive.com abc.def@mail 123 abcdefghij]
end
