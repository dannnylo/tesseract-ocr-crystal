require "./command"

# This Module is a wrapper of tesseract-ocr
module Tesseract::OcrWords
  extend self

  # This function reads the words on image by OCR then returns with the positions
  #
  # ```
  # Tesseract::OcrWords.read("spec/resources/world.png") => "world"
  # ```
  def read(path, options = Hash(Symbol, String | Int32).new)
    filename = File.tempname

    command = Tesseract::Ocr::Command.new(path, filename)
    command.add_options(options)
    command.add_config("tessedit_create_hocr=1")
    command.run

    parse(File.read("#{filename}.hocr"))
  end

  def parse(content)
    content.lines.map { |line| parse_line(line) }.compact
  end

  def parse_line(line)
    return if line[/oc(rx|r)_word/]?.nil?

    word = content_match(line, /(?<=>)(.*?)(?=<)/)

    return if word == ""

    word_info(word, parse_position(line), parse_confidence(line))
  end

  def word_info(word, positions, confidence)
    {
      word:       word,
      confidence: confidence[-1].to_i,
      x_start:    positions[1].to_i,
      y_start:    positions[2].to_i,
      x_end:      positions[3].to_i,
      y_end:      positions[4].to_i,
    }
  end

  def parse_position(line)
    content_match(line, /(?<=title)(.*?)(?=;)/).split(" ")
  end

  def parse_confidence(line)
    content_match(line, /(?<=;)(.*?)(?=')/).split(" ")
  end

  def content_match(string, re)
    unless line_word = string.match(re)
      return ""
    end

    line_word[0]
  end
end
