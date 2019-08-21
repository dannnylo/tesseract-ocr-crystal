require "./spec_helper"

describe Tesseract::Ocr do
  it "read a image" do
    # Tesseract::Ocr.read("./spec/resources/blank.tif").should eq("")
    # Tesseract::Ocr.read("./spec/resources/test.tif").should eq("43XF")
    # Tesseract::Ocr.read("./spec/resources/test.png").should eq("HW9W")
    Tesseract::Ocr.read("./spec/resources/world.png", { :lang => "eng", :psm => 7, :oem => 1 }).should eq("world")
    # Tesseract::Ocr.read("./spec/resources/world.png", { :lang => "eng" }).should eq("world")
    # Tesseract::Ocr.read("./spec/resources/world.png", { :oem => 3 }).should eq("world")
  end

  # it "read a to_pdf" do
  #   Tesseract::Ocr.to_pdf(
  #     "./spec/resources/blank.tif",
  #     Tesseract::Ocr::Options.new
  #   ).should eq("")
  # end

  # it "read a to_s" do
  #   Tesseract::Ocr.to_s(
  #     "./spec/resources/blank.tif",
  #     {lang: "eng", psm: 7, oem: 1}
  #   ).should eq("world")
  # end

  # it "make options" do
  #   Tesseract::Ocr.make_option("psm", nil).should eq(nil)
  #   Tesseract::Ocr.make_option("psm", 1).should eq("--psm 1")
  #   Tesseract::Ocr.make_option("psm", "1").should eq("--psm 1")
#  end
end
