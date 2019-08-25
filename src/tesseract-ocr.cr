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
  def to_pdf(path, options = Hash(Symbol, String | Int32).new)
    merged = Hash(Symbol, String | Int32 | Nil).new
    merged[:tessedit_create_pdf] = 1
    merged.merge!(options)

    filename = File.tempname(".pdf")

    Tesseract::Ocr::Command.new(path, filename, options).run

    return filename
  end
end
