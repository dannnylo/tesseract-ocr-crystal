class Tesseract::Ocr::Command
  def initialize(source : String, output : String, options : Hash(Symbol, String))
    @start_command = [
      "#{options[:command]? || "tesseract"}",
      source,
      output
    ]
    @options = options
  end

  def initialize(source : String, output : String, options : Hash(Symbol, Int32))
    @start_command = [
      "#{options[:command]? || "tesseract"}",
      source,
      output
    ]
    @options = options
  end

  def initialize(source : String, output : String, options : Hash(Symbol, String | Int32))
    @start_command = [
      "#{options[:command]? || "tesseract"}",
      source,
      output
    ]
    @options = options
  end

  def initialize(source : String, output : String, options : Hash(Symbol, String | Int32 | Nil))
    @start_command = [
      "#{options[:command]? || "tesseract"}",
      source,
      output
    ]
    @options = options
  end

  def run
    print(command_options)
    print("\n")
    `tesseract #{command_options}`.strip
  end

  # This function will mount the options to tesseract OCR
  #
  # ```
  # Tesseract::Ocr.command_options("test/resources/world.png", { l: "por", oem: "1" }) => "test/resources/world.png stdout -l por --oem 1"]
  # Tesseract::Ocr.command_options("test/resources/world.png", { l: "por", psm: 1 }) => ["test/resources/world.png stdout -l por --psm 1"]
  # Tesseract::Ocr.command_options("test/resources/world.png", { c: "var=b" }) => ["test/resources/world.png stdout -c var=b"]
  # ```
  def command_options
    (
      @start_command +
      [
        make_short_option(:l, @options[:l]? || @options[:lang]?),
        make_option(:oem, @options[:oem]?),
        make_option(:psm, @options[:psm]?),
        make_short_option(:c, @options[:c]?),
      ]
    ).compact.join(' ')
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

  # class RTesseract
  #   class Command
  #     FIXED = %i[command psm oem lang tessdata_dir user_words user_patterns config_file].freeze

  #     attr_reader :options

  #     def full_command
  #       add_option('--psm', options.psm)
  #       add_option('--oem', options.oem)
  #       add_option('-l', options.lang)
  #       add_option('--tessdata-dir', options.tessdata_dir)
  #       add_option('--user-words', options.user_words)
  #       add_option('--user-patterns', options.user_patterns)

  #       other_configs

  #       add_option(options.config_file)

  #       @full_command
  #     end

  #     def add_option(*options)
  #       return unless options.last

  #       @full_command << options.map(&:to_s)
  #     end

  #     def other_configs
  #       @options.to_h.map do |key, value|
  #         next if FIXED.include?(key)

  #         add_option('-c', "#{key}=#{value}")
  #       end
  #     end

  #     def run
  #       output, error, status = Open3.capture3(*full_command.flatten)

  #       @errors.push(error)

  #       return output if status.success?

  #       raise RTesseract::Error, error
  #     end
  #   end
  # end

end
