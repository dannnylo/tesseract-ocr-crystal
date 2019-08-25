class Tesseract::Ocr::Command
  def initialize(source : String, output : String, options = {} of Symbol => String)
    @start_command = [
      "#{options[:command]? || "tesseract"}",
      source,
      output,
    ]
    @options = Hash(Symbol | String, String | Int32 | Nil | Array(String)).new
    @options.merge!(options)
  end

  def run
    `#{command}`.strip
  end

  # This function will mount the options to tesseract OCR
  #
  # ```
  # Tesseract::Ocr.command("test/resources/world.png", { :l => "por", :oem => "1" }) => "test/resources/world.png stdout -l por --oem 1"]
  # Tesseract::Ocr.command("test/resources/world.png", { :l => "por", :psm => 1 }) => ["test/resources/world.png stdout -l por --psm 1"]
  # Tesseract::Ocr.command("test/resources/world.png", { :c => "var=b" }) => ["test/resources/world.png stdout -c var=b"]
  # ```
  def command
    (
      @start_command +
        [
          make_short_option(:l, @options[:l]? || @options[:lang]?),
          make_option(:oem, @options[:oem]?),
          make_option(:psm, @options[:psm]?),
          make_option("tessdata-dir", @options[:"tessdata-dir"]? || @options[:tessdata_dir]?),
          make_option("user-words", @options[:"user-words"]? || @options[:user_words]?),
          make_option("user-patterns", @options[:"user-patterns"]? || @options[:user_patterns]?),
          make_short_option(:c, @options[:c]?),
          @options[:config_path]?,
        ]
    ).flatten.compact.join(' ')
  end

  def make_option(_name, value : Nil)
    nil
  end

  def make_option(name, value : Int | String)
    "--#{name} #{value}"
  end

  def make_option(name, values : Array(String))
    values.map { |value| make_option(name, value) }
  end

  def make_short_option(_name, value : Nil)
    nil
  end

  def make_short_option(name, value : Int | String)
    "-#{name} #{value}"
  end

  def make_short_option(name, values : Array(String))
    values.map { |value| make_short_option(name, value) }
  end
end
