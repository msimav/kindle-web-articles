# Web Articles for Kindle

<p align="center">
  <img src="logo.png" />
</p>

## Usage

```bash
echo 'https://www.joelonsoftware.com/2000/08/09/the-joel-test-12-steps-to-better-code/' > src/1.url
echo 'http://www.paulgraham.com/hp.html' > src/2.url
echo 'https://www.jwz.org/doc/worse-is-better.html' > src/3.url

make -s -j 8
```

## Installation

### Installing Requirements
This tool uses `jq`, `pandoc`, and `kindlegen` behind the scenes.

```bash
brew install jq pandoc
brew cask install kindlegen
```

### Mercury Web Parser API
This tools depends on _Mercury Web Parser API_ for getting content from web articles.
Go to [mercury.postlight.com/web-parser](https://mercury.postlight.com/web-parser/),
click _Sign up for Mercury_ button and get an API key.

```bash
export MERCURY_KEY="..."
```

