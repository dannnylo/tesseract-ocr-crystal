require "./spec_helper"

describe Tesseract::Ocr do
  it "read a image" do
    Tesseract::Ocr.read("./spec/resources/blank.tif").should eq("")
    Tesseract::Ocr.read("./spec/resources/test.tif").should eq("43XF")
    Tesseract::Ocr.read("./spec/resources/test.png").should eq("HW9W")
    Tesseract::Ocr.read("./spec/resources/test copy.png").should eq("HW9W")
    Tesseract::Ocr.read("./spec/resources/world.png", {:lang => "eng", :psm => 7, :oem => 1}).should eq("world")
    Tesseract::Ocr.read("./spec/resources/world.png", {:lang => "eng"}).should eq("world")
    Tesseract::Ocr.read("./spec/resources/world.png", {:oem => 3}).should eq("world")
    Tesseract::Ocr.read("./spec/resources/world.png", {:oem => 3, :c => "poly_debug=0"}).should eq("world")
  end

  it "convert a image to pdf" do
    pdf_path = Tesseract::Ocr.to_pdf(
      "./spec/resources/blank.tif",
      {
        :c => ["poly_debug=0"],
      }
    )

    pdf_path.should contain(".pdf")
    File.exists?(pdf_path)

    other_pdf_path = Tesseract::Ocr.to_pdf(
      "./spec/resources/test-pdf.png",
      {} of Symbol => String
    )
    other_pdf_path.should contain(".pdf")

    other_pdf_path.should_not eq(pdf_path)
  end

  it "convert a image to tsv" do
    tsv_path = Tesseract::Ocr.to_tsv(
      "./spec/resources/test_words.png",
      {
        :c => ["poly_debug=0"],
      }
    )

    tsv_path.should contain(".tsv")
    File.exists?(tsv_path)

    other_tsv_path = Tesseract::Ocr.to_tsv(
      "./spec/resources/test_words.png",
      {} of Symbol => String
    )
    other_tsv_path.should contain(".tsv")

    other_tsv_path.should_not eq(tsv_path)

    content = File.read(tsv_path)

    content.should contain("	If")
    content.should contain("	you")
    content.should contain("	are")
    content.should contain("	a")
    content.should contain("	friend,")
    content.should contain("	you")
    content.should contain("	speak")
    content.should contain("	the")
    content.should contain("	password,")
    content.should contain("	and")
    content.should contain("	the")
    content.should contain("	doors")
    content.should contain("	will")
    content.should contain("	open.")
  end
end
