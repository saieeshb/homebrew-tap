class CcExporter < Formula
  desc "Export Claude Code chats in full detail to Markdown, HTML or JSON"
  homepage "https://github.com/saieeshb/cc-exporter"
  url "https://github.com/saieeshb/cc-exporter/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "c8a1126c8819f4849f0332d423c7a6623e50b8a092a9f27c6d7d59b1dee6faed"
  license "MIT"

  depends_on "node"

  def install
    libexec.install Dir["*"]
    (bin/"cc-exporter").write <<~SH
      #!/bin/bash
      exec "#{Formula["node"].opt_bin}/node" "#{libexec}/bin/cc-exporter.mjs" "$@"
    SH
  end

  def caveats
    <<~EOS
      Export a Claude Code chat:  cc-exporter --list
      Use it as an MCP server:    claude mcp add cc-exporter -- cc-exporter mcp
      For /export-chat inside Claude Code, also install the plugin:
        /plugin marketplace add saieeshb/cc-exporter
        /plugin install cc-exporter@cc-exporter
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/cc-exporter --version")
    assert_match "export a Claude Code chat", shell_output("#{bin}/cc-exporter --help")
  end
end
