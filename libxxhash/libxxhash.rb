class Libxxhash < Formula
  desc "Extremely fast non-cryptographic hash algorithm (library)"
  homepage "https://cyan4973.github.io/xxHash/"
  url "https://github.com/Cyan4973/xxHash/archive/v0.8.1.tar.gz"
  sha256 "3bb6b7d6f30c591dd65aaaff1c8b7a5b94d81687998ca9400082c739a690436c"
  head "https://github.com/Cyan4973/xxHash.git"
  license "BSD-2-Clause"

  def install
    system "make", "lib"
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    true
  end
end
