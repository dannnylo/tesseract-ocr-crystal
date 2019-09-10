# tesseract-ocr

This package is a wrapper of Tesseract OCR. Helping to read characters on a image.

## Installation

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     tesseract-ocr:
       github: dannnylo/tesseract-ocr-crystal
   ```

2. Run `shards install`

## Usage

```crystal
require "tesseract-ocr"
```

Basic usage:

```crystal
Tesseract::Ocr.read("spec/resources/world.png") => "world"
```


With options:

```crystal
Tesseract::Ocr.read("spec/resources/world.png", {  :l => "por", :oem => "1" }) => "world"
```


Convert image to PDF readable.

```crystal
Tesseract::Ocr.to_pdf("spec/resources/world.png", { :oem => "1" }) => "/tmp/RANDOM_NAME.pdf"
```


## Contributing

1. Fork it (<https://github.com/dannnylo/tesseract-ocr-crystal/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Danilo Jeremias da Silva](https://github.com/dannnylo) - creator and maintainer
