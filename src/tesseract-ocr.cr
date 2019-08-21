require "./command"

# This Module is a wrapper of tesseract-ocr
module Tesseract::Ocr
  extend self

  VERSION = "0.1.0"

  # This function reads the chars on image by OCR
  #
  # ```
  # Tesseract::Ocr.read("spec/resources/world.png") => "world"
  # ```
  def read(path, options = Hash(Symbol, String | Int32).new)
    Tesseract::Ocr::Command.new(path, "stdout", options).run
  end

  # def to_s(path, options = OPTIONS)
  #   Tesseract::Ocr::Command.new(path, "stdout", options : Hash(String | Symbol, String | Int32 | Nil)).run
  # end

  # # alias to_s read

  # def to_pdf(source, options = OPTIONS)
  #   options[:tessedit_create_pdf] = 1
  #   Tesseract::Ocr::Command.new(source, "/tmp/teste.txt", options).run

  #   # File.open(temp_file('.pdf'), 'r')
  # end
end
