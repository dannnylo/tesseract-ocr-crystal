require "./spec_helper"

describe Tesseract::Ocr do
  it "read a image" do
    Tesseract::Ocr.read("./spec/resources/blank.tif").should eq("")
    Tesseract::Ocr.read("./spec/resources/test.tif").should eq("43XF")
    Tesseract::Ocr.read("./spec/resources/test.png").should eq("HW9W")
    Tesseract::Ocr.read("./spec/resources/world.png", {:lang => "eng", :psm => 7, :oem => 1}).should eq("world")
    Tesseract::Ocr.read("./spec/resources/world.png", {:lang => "eng"}).should eq("world")
    Tesseract::Ocr.read("./spec/resources/world.png", {:oem => 3}).should eq("world")
  end

  it "read a to_pdf" do
    pdf_path = Tesseract::Ocr.to_pdf(
      "./spec/resources/blank.tif",
      {
        :c => ["poly_debug=0"],
      }
    )

    pdf_path.should contain(".pdf")
    File.exists?(pdf_path)

    other_pdf_path = Tesseract::Ocr.to_pdf(
      "./spec/resources/world.png",
      {} of Symbol => String
    )
    other_pdf_path.should contain(".pdf")

    other_pdf_path.should_not eq(pdf_path)
  end
end
