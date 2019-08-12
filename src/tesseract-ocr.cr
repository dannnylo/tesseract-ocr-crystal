# This Module is a wrapper of tesseract-ocr
module Tesseract::Ocr
  extend self

  VERSION = "0.1.0"

  # This function reads the chars on image by OCR
  #
  # ```
  # Tesseract::Ocr.read("spec/resources/world.png") => "world"
  # ```
  def read(path, options = {} of String | Symbol => String | Int32)
    command(path, options).strip
  end

  # This function executes the tesseract on system and return the output
  def command(path, options)
    `tesseract #{command_options(path, options)}`
  end

  # This function will mount the options to tesseract OCR
  #
  # ```
  # Tesseract::Ocr.command_options("test/resources/world.png", { l: "por", oem: "1" }) => "test/resources/world.png stdout -l por --oem 1"]
  # Tesseract::Ocr.command_options("test/resources/world.png", { l: "por", psm: 1 }) => ["test/resources/world.png stdout -l por --psm 1"]
  # Tesseract::Ocr.command_options("test/resources/world.png", { c: "var=b" }) => ["test/resources/world.png stdout -c var=b"]
  # ```
  def command_options(path, options)
    [
      path,
      "stdout",
      make_short_option(:l, options[:l]? || options[:lang]?),
      make_option(:oem, options[:oem]?),
      make_option(:psm, options[:psm]?),
      make_short_option(:c, options[:c]?),
    ].compact.join(' ')
  end

  def make_option(_name, value : Nil)
    nil
  end

  def make_option(name, value : Int | String)
    "--#{name} #{value}"
  end

  def make_short_option(_name, value : Nil)
    nil
  end

  def make_short_option(name, value : Int | String)
    "-#{name} #{value}"
  end
end
