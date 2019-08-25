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

  # This function reads the chars on image by OCR and saves on a pdf file.
  # and returning the path.
  #
  # ```
  # Tesseract::Ocr.to_pdf("spec/resources/world.png") => "/tmp/random_file.pdf"
  # ```
  def to_pdf(path, options = Hash(Symbol, String | Int32 | Array(String)).new)
    merged = Hash(Symbol, String | Int32 | Nil | Array(String)).new
    merged.merge!(options)

    merged[:c] = ["tessedit_create_pdf=1", options[:c]?].flatten.compact

    filename = File.tempname

    Tesseract::Ocr::Command.new(path, filename, merged).run

    return "#{filename}.pdf"
  end
end
