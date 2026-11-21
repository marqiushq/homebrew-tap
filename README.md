# Install wkhtmltopdf with Homebrew: marqius-wkhtmltopdf

**What it is.** The Homebrew tap for marqius-wkhtmltopdf, the maintained drop-in replacement for wkhtmltopdf, on Apple silicon Macs and on Linux (x86-64 and ARM64).

**Why it matters.** Homebrew no longer offers wkhtmltopdf: `brew install wkhtmltopdf` answers "No available formula", and wkhtmltopdf's own project was archived in 2023. This tap gives you a program that takes the same command and the same options, kept up to date by Homebrew like everything else on your machine.

## Install

```bash
brew install marqiushq/tap/marqius-wkhtmltopdf
```

## Make your first PDF

Try it in an empty folder:

```bash
echo '<h1>Invoice 42</h1><p>Total €1,234.50</p>' > invoice.html
marqius-wkhtmltopdf --page-size A4 invoice.html invoice.pdf
```

Open `invoice.pdf`. The options you know from wkhtmltopdf work as they did.

## Use it in your app

Keep your library, your HTML templates and your PDF calls. Point the library at marqius-wkhtmltopdf in one of two ways.

**Option 1: name its path in the library's settings.** This prints the path to use:

```bash
echo "$(brew --prefix)/bin/marqius-wkhtmltopdf"
```

Not sure where your library takes the path? `marqius-wkhtmltopdf help libraries` lists the libraries it knows, from python-pdfkit and Snappy to wicked_pdf and Rotativa, and `marqius-wkhtmltopdf help snappy` (or another name from that list) shows where that library takes it.

**Option 2: give it the names `wkhtmltopdf` and `wkhtmltoimage`** for everything you start from your shell, by putting its own folder of those names first on your PATH. Add the first line to your shell profile to keep it:

```bash
export PATH="$(brew --prefix)/opt/marqius-wkhtmltopdf/libexec/bin:$PATH"
wkhtmltopdf -V
```

Nothing is replaced or hidden: take the line out, and the wkhtmltopdf you had before is back.

## Always the latest release

The formula follows every release of marqius-wkhtmltopdf on its own: each hour [a workflow](.github/workflows/formula.yml) checks marqius.com, and a new release's builds are checked against their published checksums before the formula moves to them. To update:

```bash
brew upgrade marqius-wkhtmltopdf
```

## Before you switch

- [Parity suite](https://github.com/marqiushq/wkhtmltopdf-parity): the same HTML documents through wkhtmltopdf and marqius-wkhtmltopdf on every release, misses included. Run it on your own templates; nothing is uploaded.
- [Library tests](https://github.com/marqiushq/wkhtmltopdf-library-tests): the test suites of 15 wkhtmltopdf libraries, run with both programs.
- [Examples](https://github.com/marqiushq/marqius-wkhtmltopdf-examples) for 14 wkhtmltopdf libraries.
- [The switching manual](https://marqius.com/download/marqius-wkhtmltopdf/replace-wkhtmltopdf.pdf) (PDF).

## Questions

**Does it work on Intel Macs?**
Not yet: there is no Intel build. Write to hello@marqius.com if you need one.

**How do I remove it?**
`brew uninstall marqius-wkhtmltopdf`, and take the PATH line out of your shell profile if you added it.

## Licence

marqius-wkhtmltopdf is commercial software from Simple AI LLC, free for 30 days from its first run; `marqius-wkhtmltopdf licence` shows the days left. After the trial, without a licence, each page carries one line, “Prepared by Marqius, Purchase Licence”: it never stops making PDFs. [Plans and licences](https://marqius.com/wkhtmltopdf-buy/).

More about the program: [marqius-wkhtmltopdf](https://github.com/marqiushq/marqius-wkhtmltopdf). Questions: hello@marqius.com.
