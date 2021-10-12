require "./spec_helper"

describe Tesseract::OcrWords do
  it "read a image and returns the words positions" do
    Tesseract::OcrWords.read("spec/resources/world.png", {:oem => "1"}).should eq([
      {word: "world", confidence: 95, x_start: 2, y_start: 2, x_end: 185, y_end: 56},
    ])

    Tesseract::OcrWords.read("./spec/resources/test_words.png").should eq([
      {word: "If", confidence: 89, x_start: 52, y_start: 13, x_end: 63, y_end: 27},
      {word: "you", confidence: 96, x_start: 69, y_start: 17, x_end: 100, y_end: 31},
      {word: "are", confidence: 92, x_start: 108, y_start: 17, x_end: 136, y_end: 27},
      {word: "a", confidence: 92, x_start: 140, y_start: 8, x_end: 147, y_end: 35},
      {word: "friend,", confidence: 95, x_start: 158, y_start: 13, x_end: 214, y_end: 29},
      {word: "you", confidence: 96, x_start: 51, y_start: 39, x_end: 82, y_end: 53},
      {word: "speak", confidence: 96, x_start: 90, y_start: 35, x_end: 140, y_end: 53},
      {word: "the", confidence: 96, x_start: 146, y_start: 35, x_end: 174, y_end: 49},
      {word: "password,", confidence: 96, x_start: 182, y_start: 35, x_end: 267, y_end: 53},
      {word: "and", confidence: 96, x_start: 51, y_start: 57, x_end: 81, y_end: 71},
      {word: "the", confidence: 95, x_start: 89, y_start: 57, x_end: 117, y_end: 71},
      {word: "doors", confidence: 95, x_start: 124, y_start: 57, x_end: 172, y_end: 71},
      {word: "will", confidence: 96, x_start: 180, y_start: 57, x_end: 208, y_end: 71},
      {word: "open.", confidence: 96, x_start: 216, y_start: 61, x_end: 263, y_end: 75},
    ])
  end
end
