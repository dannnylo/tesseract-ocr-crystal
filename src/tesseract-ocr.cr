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
    command = Tesseract::Ocr::Command.new(path, "stdout")
    command.add_options(options)
    command.run
  end

  # This function reads the chars on image by OCR and saves on a pdf file.
  # and returning the path.
  #
  # ```
  # Tesseract::Ocr.to_pdf("spec/resources/world.png") => "/tmp/random_file.pdf"
  # ```
  def to_pdf(path, options = Hash(Symbol, String | Int32 | Array(String)).new)
    filename = File.tempname

    command = Tesseract::Ocr::Command.new(path, filename)
    command.add_options(options)
    command.add_config("tessedit_create_pdf=1")
    command.run
    # merged = normalize_and_add_config(options, "tessedit_create_pdf=1")
    # Tesseract::Ocr::Command.new(path, filename, merged).run

    return "#{filename}.pdf"
  end

  # This function reads the chars on image by OCR and saves on a tsv file.
  # and returning the path.
  #
  # ```
  # Tesseract::Ocr.to_tsv("spec/resources/world.png") => "/tmp/random_file.tsv"
  # ```
  def to_tsv(path, options = Hash(Symbol, String | Int32 | Array(String)).new)
    filename = File.tempname

    command = Tesseract::Ocr::Command.new(path, filename)
    command.add_options(options)
    command.add_config("tessedit_create_tsv=1")
    command.run

    return "#{filename}.tsv"
  end

  # def normalize_and_add_config(options, option : String)
  #   merged = Hash(Symbol, String | Nil | Array(String)).new
  #   merged.merge!(options)

  #   merged[:config] = [merged[:c]?, option].flatten.compact

  #   merged.delete(:c)

  #   merged
  # end
end
