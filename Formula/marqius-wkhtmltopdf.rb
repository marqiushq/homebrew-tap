# The version, url and sha256 lines are written by .github/follow-release.py from
# https://marqius.com/download/marqius-wkhtmltopdf/latest after every release.
class MarqiusWkhtmltopdf < Formula
  desc "Drop-in wkhtmltopdf replacement for HTML to PDF (commercial, 30-day trial)"
  homepage "https://marqius.com/wkhtmltopdf/"
  url "https://marqius.com/download/marqius-wkhtmltopdf/0.12.17/marqius-wkhtmltopdf-linux-x86_64"
  version "0.12.17"
  sha256 "7ba9129dcf48e00c0ba6adc3a375d7015afcecf4ff0d3b0e8300c3e669be42fb"
  license :cannot_represent

  livecheck do
    url "https://marqius.com/download/marqius-wkhtmltopdf/latest"
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  on_macos do
    on_arm do
      url "https://marqius.com/download/marqius-wkhtmltopdf/0.12.17/marqius-wkhtmltopdf-macos-arm64"
      sha256 "574671257d7704f9f06a470e28cb67796168edbd627abc8f4f4fdfa3eff62a1c"
    end

    # the macOS build is for Apple silicon; for Intel Macs, write to hello@marqius.com
    depends_on arch: :arm64
  end

  on_linux do
    on_arm do
      url "https://marqius.com/download/marqius-wkhtmltopdf/0.12.17/marqius-wkhtmltopdf-linux-arm64"
      sha256 "8d8adee679dad3abe00196fe696e802f19cb59b8023df1e37d6bacee7f438767"
    end
  end

  def install
    program = Dir["marqius-wkhtmltopdf-*"].first
    chmod 0755, program
    bin.install program => "marqius-wkhtmltopdf"
    # The names libraries look for, kept in a folder of their own so they never hide another wkhtmltopdf
    (libexec/"bin").install_symlink bin/"marqius-wkhtmltopdf" => "wkhtmltopdf"
    (libexec/"bin").install_symlink bin/"marqius-wkhtmltopdf" => "wkhtmltoimage"
  end

  def caveats
    <<~EOS
      marqius-wkhtmltopdf is commercial software with a 30-day free trial, counted from its first run;
      `marqius-wkhtmltopdf licence` shows the days left. After the trial, without a licence, each page
      carries one line saying the copy is unlicensed. Plans: https://marqius.com/wkhtmltopdf/

      It is installed as marqius-wkhtmltopdf, so it never hides another wkhtmltopdf. Point your library at
        #{opt_bin}/marqius-wkhtmltopdf
      (`marqius-wkhtmltopdf help libraries` lists how for each library), or give it the names
      wkhtmltopdf and wkhtmltoimage by putting this folder first on your PATH:
        export PATH="#{opt_libexec}/bin:$PATH"
    EOS
  end

  test do
    assert_match "marqius-wkhtmltopdf #{version}", shell_output("#{bin}/marqius-wkhtmltopdf --version")
    assert_match "compatible; marqius-wkhtmltopdf #{version}", shell_output("#{libexec}/bin/wkhtmltopdf -V")

    (testpath/"invoice.html").write "<html><body><h1>Invoice 42</h1><p>Total 1,234.50</p></body></html>"
    system bin/"marqius-wkhtmltopdf", "-q", "invoice.html", "invoice.pdf"
    assert_equal "%PDF-", File.binread(testpath/"invoice.pdf", 5)
    system libexec/"bin/wkhtmltoimage", "-q", "--width", "400", "invoice.html", "invoice.png"
    assert_equal "\x89PNG".b, File.binread(testpath/"invoice.png", 4)
  end
end
