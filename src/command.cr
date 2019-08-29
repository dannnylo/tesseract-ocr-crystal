class Tesseract::Ocr::Command
  def initialize(source : String, output : String)
    @source = source
    @output = output

    @options = Hash(Symbol | String, String | Int32 | Nil | Array(String)).new
    @options[:config] = [] of String
  end

  def add_options(options)
    @options.merge!(options)
  end

  def add_config(config)
    @options[:config] = config
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
      [
        "#{@options[:command]? || "tesseract"}",
        @source,
        @output,
        make_short_option(:l, @options[:l]? || @options[:lang]?),
        make_option(:oem, @options[:oem]?),
        make_option(:psm, @options[:psm]?),
        make_option("tessdata-dir", @options[:"tessdata-dir"]? || @options[:tessdata_dir]?),
        make_option("user-words", @options[:"user-words"]? || @options[:user_words]?),
        make_option("user-patterns", @options[:"user-patterns"]? || @options[:user_patterns]?),
        make_short_option(:c, @options[:config]?),
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
