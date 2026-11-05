class Unabridged < Formula
  desc "Export AI coding agent chats (Claude Code, Codex) to Markdown, HTML or JSON"
  homepage "https://github.com/saieeshb/unabridged"
  url "https://github.com/saieeshb/unabridged/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "6466ee35df2ff8955bc2b1b68da8518e267d010498797c1be7df45a341657c9b"
  license "MIT"

  depends_on "node"

  def install
    libexec.install Dir["*"]
    %w[unabridged cc-exporter].each do |name|
      (bin/name).write <<~SH
        #!/bin/bash
        exec "#{formula_opt_bin("node")}/node" "#{opt_libexec}/bin/unabridged.mjs" "$@"
      SH
    end
  end

  def caveats
    <<~EOS
      Export a chat:                 unabridged --list
      Add it to your coding agents:  unabridged setup
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/unabridged --version")
  end
end
