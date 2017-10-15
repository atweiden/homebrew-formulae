class Just < Formula
  desc "Just a command runner"
  homepage "https://github.com/casey/just"
  head do
    url "https://github.com/casey/just.git"
  end

  depends_on "rust" => :build

  def install
    system "cargo", "build", "--release"
    bin.install "target/release/just"
  end

  test do
    system "#{bin}/just", "--version"
  end
end
