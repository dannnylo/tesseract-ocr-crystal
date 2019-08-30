require "./spec_helper"

describe Tesseract::Ocr::Command do
  it "make options" do
    instance = Tesseract::Ocr::Command.new("./spec/resources/blank.tif", "stdout")
    instance.make_option("psm", nil).should eq(nil)
    instance.make_option("psm", 1).should eq("--psm 1")
    instance.make_option("psm", "1").should eq("--psm 1")
    instance.make_option("test", ["1", "2"]).should eq(["--test 1", "--test 2"])
  end

  it "make sort options" do
    instance = Tesseract::Ocr::Command.new("./spec/resources/blank.tif", "stdout")

    instance.make_short_option("l", nil).should eq(nil)
    instance.make_short_option("l", "por").should eq("-l por")
    instance.make_short_option("z", 0).should eq("-z 0")
    instance.make_short_option("test", ["1", "2"]).should eq(["-test 1", "-test 2"])
  end

  it "join all options to a command" do
    command = Tesseract::Ocr::Command.new("./spec/resources/blank.tif", "stdout")
    command.add_options({
      :config_path => "/tmp/config_path.txt",
      :l           => "eng",
      :config      => [
        "a=1",
        "b=2",
      ],
    })

    command.command.should eq("tesseract ./spec/resources/blank.tif stdout -l eng -c a=1 -c b=2 /tmp/config_path.txt")
  end

  it "join all options to a command" do
    command = Tesseract::Ocr::Command.new("./spec/resources/blank.tif", "stdout")
    command.add_options({
      :config => [
        "a=1",
        "b=2",
      ],
    })

    command.add_config("c=3")
    command.add_config("d=4")

    command.command.should eq("tesseract ./spec/resources/blank.tif stdout -c a=1 -c b=2 -c c=3 -c d=4")
  end
end
