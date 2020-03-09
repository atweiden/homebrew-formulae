class Libxxhash < Formula
  desc "Extremely fast non-cryptographic hash algorithm (library)"
  homepage "https://cyan4973.github.io/xxHash/"
  url "https://github.com/Cyan4973/xxHash/archive/v0.7.3.tar.gz"
  sha256 "952ebbf5b11fbf59ae5d760a562d1e9112278f244340ad7714e8556cbe54f7f7"
  head "https://github.com/Cyan4973/xxHash.git"

  def install
    system "make", "lib"
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    true
  end
end
